`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Generated Sim File for HW 4
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );

    // BEGIN IMMED_GEN SIM

    // logic [31:7] INST;
    // logic [31:0] U, I, S, B, J;

    // IMMED_GEN imm(
    //     .INSTRUCT(INST),
    //     .U_TYPE(U),
    //     .I_TYPE(I),
    //     .S_TYPE(S),
    //     .B_TYPE(B),
    //     .J_TYPE(J)
    // );

    // initial begin
    //     INST = 32'h02048313;
    //     #1 INST = 32'h02FAA523;
    //     #1 INST = 32'h000FF063;
    //     #1 INST = 32'hFFFFF8b7;
    //     #1 INST = 32'h006000EF;
    // end

    // END IMMED_GEN SIM

    // BEGIN ALU SIM

    logic [31:0] srcA, srcB;
    logic [3:0] alu_fun;
    logic [31:0] result;
    
    ALU alu(
        .srcA(srcA),
        .srcB(srcB),
        .alu_fun(alu_fun),
        .result(result)
    );

    initial begin
        // initial case (ADD)
        srcA = 32'hA50F96C3;
        srcB = 32'h5AF0693C;
        alu_fun = 4'b0000;

        // at this point result should be 0xFFFFFFFF;
        #1 test_case(32'h84105F21, 32'h7B105FDE, 4'b0000);
        #1 test_case(32'hFFFFFFFF, 32'h00000001, 4'b0000);

        // SUB
        #1 test_case(32'h00000000, 32'h00000001, 4'b1000);
        #1 test_case(32'hAA806355, 32'h550162AA, 4'b1000);
        #1 test_case(32'h550162AA, 32'hAA806355, 4'b1000);

        // AND
        #1 test_case(32'hA55A00FF, 32'h5A5AFFFF, 4'b0111);
        #1 test_case(32'hC3C3F966, 32'hFF669F5A, 4'b0111);

        // OR
        #1 test_case(32'h9A9AC300, 32'h65A3CC0F, 4'b0110);
        #1 test_case(32'hC3C3F966, 32'hFF669F5A, 4'b0110);

        // XOR
        #1 test_case(32'hAA5500FF, 32'h5AA50FF0, 4'b0100);
        #1 test_case(32'hA5A56C6C, 32'hFF00C6FF, 4'b0100);

        // SRL
        #1 test_case(32'h805A6CF3, 32'h00000010, 4'b0101);
        #1 test_case(32'h705A6CF3, 32'h00000005, 4'b0101);
        #1 test_case(32'h805A6CF3, 32'h00000000, 4'b0101);
        #1 test_case(32'h805A6CF3, 32'h00000100, 4'b0101);

        // SLL
        #1 test_case(32'h805A6CF3, 32'h00000010, 4'b0001);
        #1 test_case(32'h805A6CF3, 32'h00000005, 4'b0001);
        #1 test_case(32'h805A6CF3, 32'h00000100, 4'b0001);

        // SRA 
        #1 test_case(32'h805A6CF3, 32'h00000010, 4'b1101);
        #1 test_case(32'h705A6CF3, 32'h00000005, 4'b1101);
        #1 test_case(32'h805A6CF3, 32'h00000000, 4'b1101);
        #1 test_case(32'h805A6CF3, 32'h00000100, 4'b1101);

        // SLT
        #1 test_case(32'h7FFFFFFF, 32'h80000000, 4'b0010);
        #1 test_case(32'h80000000, 32'h00000001, 4'b0010);
        #1 test_case(32'h00000000, 32'h00000000, 4'b0010);
        #1 test_case(32'h55555555, 32'h55555555, 4'b0010);

        // SLTU
        #1 test_case(32'h7FFFFFFF, 32'h80000000, 4'b0010);
        #1 test_case(32'h80000000, 32'h00000001, 4'b0010);
        #1 test_case(32'h00000000, 32'h00000000, 4'b0010);
        #1 test_case(32'h55AA55AA, 32'h55AA55AA, 4'b0010);

        // LUI-COPY
        #1 test_case(32'h01234567, 32'h76543210, 4'b1001);
        #1 test_case(32'hFEDCBA98, 32'h89ABCDEF, 4'b1001);
        
    end

    function void test_case(logic [31:0] A, logic[31:0] B, logic[3:0] fun);
        srcA = A;
        srcB = B;
        alu_fun = fun;
    endfunction

    // END ALU SIM

    
endmodule

