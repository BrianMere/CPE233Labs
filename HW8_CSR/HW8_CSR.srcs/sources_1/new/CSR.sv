`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: California Polytechnic State University, San Luis Obispo
// Engineer: Brian Mere 
// 
// Create Date: 03/06/2023 04:45:59 PM
// Design Name: Otter_MCU
// Module Name: CSR
// Project Name: OTTER_MCU
// Target Devices: Basys 3 Board
// Description: The CSR handles storing/sending data to various components in the
//              OTTER_MCU. It handles:
//
//              INT_TAKEN:
//              1) Saving the current PC count internally (to MEPC)
//              2) Copying the MTVEC to the PC on an interrupt. 
//              3) Copy MIE (bit 3 of MSTATUS) to MPIE (bit 7) and clear MIE to 0. 
//
//              INT_RETURNED (mret):
//              1) Send the value in MEPC back to PC
//              2) Copy back the value from MPIE to MIE and clear MPIE to 0. 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CSR(
    input CSR_RST,                      // reset the internal registers
    input CSR_mret_exec,                // dictates a mret instruction execution
    input CSR_INT_TAKEN,                // dictates an interrupt taken 
    input [31:20] CSR_ADDR,             // read the address from this value
    input CSR_WR_EN,                    // enable writing to CSR
    input [31:0] CSR_PC,                // current PC value to store for later use
    input [31:0] CSR_WD,                // data to write to CSR
    input CSR_CLK,                      // clk used
    output logic CSR_MSTATUS_B3,        // MSTATUS bit 3. Alias mie. Enable interrupts.
    output logic [31:0] CSR_MEPC,       // current value of MEPC in CSR (return PC)
    output logic [31:0] CSR_MTVEC,      // value of MTVEC in CSR (ISR addr)
    output logic [31:0] CSR_RD          // value of selected address of data
    );

    // the CSR is essentially another REG_FILE so I'm designing it as such
    logic[31:0] csr_regs[0:4095]; // since ADDR is 12 bits, we can access 2^12 registers

    // like with REG_FILE we'll just reset everything to 0's on boot.
    initial begin
        int i;
        for(i = 0; i < 4095; i=i+1) begin
            csr_regs[i] = 0; //reset selected register to 0.
        end
    end

    // write operations. Like with REG_FILE always synch
    always_ff @ (posedge CSR_CLK) begin
        if(CSR_WR_EN) begin
            csr_regs[CSR_ADDR[31:20]] <= CSR_WD;
        end

        if(CSR_MSTATUS_B3) begin        // check for intterupts now!
            // when we do an INT_TAKEN
            if(CSR_INT_TAKEN) begin
                // save current PC count
                CSR_MEPC <= CSR_PC;
                // copy mtvec to PC. PC source helps read mtvec, so nothing here
                //TODO: FINISH
            end
            else if (CSR_mret_exec) begin // mret
                
            end
        end
    end

    // read operations. Like with REG_FILE always asynch
    always_comb begin
        // always be putting out what's currently being read in the ADDR register.
        CSR_RD = csr_regs[CSR_ADDR[31:20]];

        // the following are always just output and have constant addresses per the manual.
        CSR_MSTATUS_B3 = csr_regs[12'h300][3];     // MSTATUS at    0x300. Access bit 3.
        CSR_MEPC = csr_regs[12'h341];              // MEPC at       0x341
        CSR_MTVEC = csr_regs[12'h305];             // MTVEC at      0x305              
    end

endmodule
