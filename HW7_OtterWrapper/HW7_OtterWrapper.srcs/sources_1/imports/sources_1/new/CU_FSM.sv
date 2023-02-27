`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: California Polytechnic State University, San Luis Obispo
// Engineer: Brian Mere
// 
// Create Date: 02/21/2023 11:27:10 PM
// Design Name: OTTER_MCU
// Module Name: CU_FSM
// Project Name: HW6
// Target Devices: Basys3 Boards
// Description: FSM of OTTER_MCU that handles all flags (read/writes)
// 
// Dependencies: None
//////////////////////////////////////////////////////////////////////////////////

// Define all states here, as SV will handle the numbering for us :)

module CU_FSM(
    input RST,               // Reset the entirety of the computer. PC -> 0 and so on.
    input CS_INTR,           // Interrupt from CSR and externally. For now connect just external and not use.
    input [6:0] OPCODE,      // IR[6:0]: Gives the main opcode for each instruction
    input [14:12] SIZE_SIGN, // IR[12:14]: gives the size and sign for certain operations. 
    input CLK,                 
    output logic PCWRITE,    // Should we be writing to PC now?
    output logic regWRITE,   // Should we be writing to REG_FILE now?
    output logic memWE2,     // Should we write towards memory?
    output logic memRDEN1,   // Should we get the next instruction?
    output logic memRDEN2,   // Should we be reading from memory?
    output logic reset,      // Go high if the RST is high
    output logic csr_WE,     // Not used until next HW
    output logic int_taken,  // Not used until next HW
    output logic mret_exec   // Not used until future HW
    );

    typedef enum  {  
    ST_INIT,        // default to here on startup
    ST_FETCH,       // waits an extra clock cycle to get the next intstruction
    ST_EXEC,        // have the instruction actually go through the main MCU
    ST_WRITEBACK    // wait an extra clock cycle so that load instructions are handled.
    } state;

    state PS, NS; // define next-state and previous state under enum type

    // State register
    always_ff @ (posedge CLK) begin
        if(RST) begin
            PS <= ST_INIT;   // on reset, go to ST_INIT
        end
        else begin
            PS <= NS;        // usually just have present-state be the next state.
        end 
    end

    // Next-State Logic
    always_comb begin
        // intialize all outputs to 0's to remove latches.
        PCWRITE = 0;
        regWRITE = 0;
        memWE2 = 0;
        memRDEN1 = 0;
        memRDEN2 = 0;
        reset = 0;

        // We'll mess around with these flags in a future HW ...
        csr_WE = 0;
        int_taken = 0;
        mret_exec = 0;

        case(PS)
            ST_INIT: begin // on init, we reset everything (PC) and go to NS
               reset = 1;
               NS = ST_FETCH; 
            end
            ST_FETCH: begin // on fetch, we are JUST getting the next instruction!
                reset = 0;
                memRDEN1 = 1;
                PCWRITE = 0; // don't write to PC!
                regWRITE = 0;
                memWE2 = 0;
                memRDEN2 = 0;

                NS = ST_EXEC;
            end
            ST_EXEC: begin
                reset = 0;
                NS = ST_FETCH;
                case(OPCODE) 
                    // Let's go in the order of opcode size ...
                    7'b0000011: begin // lb, lbu, lh, lhu, lw
                        PCWRITE =   0; // again, not yet ...
                        regWRITE =  0; // not yet ...
                        memWE2 =    0; // don't want to write to any memory whatsoever. 
                        memRDEN1 =  1; // not needed, but makes sure we're still having the IR.
                        memRDEN2 =  1; // to load, you need to read. 

                        NS = ST_WRITEBACK;
                    end
                    7'b0010011: begin // addi, andi, ... (all immediate ones)
                        // always
                        PCWRITE =   1;
                        regWRITE =  1;
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b0110011: begin // add, and, or, sll, slt, sltu, sra, srl, sub, xor
                        PCWRITE =   1;
                        regWRITE =  1;
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b0110111: begin // only for lui
                        PCWRITE =   1;
                        regWRITE =  1;
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b0010111: begin // only for auipc
                        PCWRITE =   1;
                        regWRITE =  1;
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b1100011: begin // beq, bge, bgeu, blt, bltu, and bne
                        PCWRITE =   1;
                        regWRITE =  0; // no reg writes here
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b1101111: begin // just jal
                        PCWRITE =   1;
                        regWRITE =  1;
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b1100111: begin // just jalr
                        PCWRITE =   1;
                        regWRITE =  1;
                        memWE2 =    0;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0;
                    end
                    7'b0100011: begin // sb, sh, sw
                        PCWRITE =   1;
                        regWRITE =  0; // not used, so keep off...
                        memWE2 =    1;
                        memRDEN1 =  1; // optional
                        memRDEN2 =  0; // don't need as we are storing, not reading
                    end
                    7'b1110011: begin // csrrw, mret. DO NOT DO RIGHT NOW
                        // ... (TODO)
                    end
                    default: begin // this default shouldn't happen, but just set all 0's.
                        PCWRITE = 0;
                        regWRITE = 0;
                        memWE2 = 0;
                        memRDEN1 = 0;
                        memRDEN2 = 0;
                        reset = 0;
                        csr_WE = 0;
                        int_taken = 0;
                        mret_exec = 0;

                        NS = ST_INIT; // by default ...
                    end 
                endcase
            end
            ST_WRITEBACK: begin
                // We assume that we did a load instruction. See lb, lbu, ... above.
                reset = 0;
                PCWRITE =   1;
                regWRITE =  1;
                memWE2 =    0; // still don't really want to write to memory
                memRDEN1 =  1; // again, not needed but will help
                memRDEN2 =  1; // necessary as we are reading from memory here

                NS = ST_FETCH;
            end
            default: begin      // if we have some weird state, just reset!
                PCWRITE =   0;
                regWRITE =  0;
                memWE2 =    0;
                memRDEN1 =  0; 
                memRDEN2 =  0;
                NS = ST_INIT; 
            end
        endcase
    end

endmodule
