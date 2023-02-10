`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Sim for HW 5
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );

    // BEGIN BRANCH_ADDR_GEN TEST

    logic[31:0] J_TYPE, B_TYPE, I_TYPE, RS1, PC;
    logic[31:0] JAL, JALR, BRANCH;

    BRANCH_ADDR_GEN mdle(
        .PC(PC),
        .J_TYPE(J_TYPE),
        .B_TYPE(B_TYPE),
        .I_TYPE(I_TYPE),
        .RS1(RS1),
        .JALR(JALR),
        .JAL(JAL),
        .BRANCH(BRANCH)
    );

    initial begin
        J_TYPE = 32'h00048020;
        B_TYPE = 32'h00000026;
        I_TYPE = 32'h00000020;
        RS1 = 32'hFFFFFFFF;
        PC = 32'h000000CC;

        #1 test_case(32'h000AA82E, 
            32'h0000002A, 
            32'h0000002F, 
            32'h12345678, 
            32'h000000D0);
        #1 test_case(32'h000FF000, 
            32'h00000000, 
            32'h00000000, 
            32'h00000000, 
            32'h000000D4);
        #1 test_case(32'h000E400C, 
            32'h00000010, 
            32'h0000000C, 
            32'h000000F12, 
            32'h000000D8);
        #1 test_case(32'h0005800C, 
            32'h00000804, 
            32'h0000000C, 
            32'h12345678, 
            32'h000000DC);
        #1 test_case(32'h00088024, 
            32'h00000028, 
            32'h00000024, 
            32'hFFFFFFFF, 
            32'h000000E8);
        #1 test_case(32'h00000000, 
            32'h00000000, 
            32'h00000000, 
            32'hFFFFFFFF, // not used in simulation 
            32'h000000EC);
        #1 test_case(32'h000FFFFE, 
            32'h00000FE0, 
            32'h000007FF, 
            32'hFFFFFFFF, // not used in sim.
            32'h00000000);
    end

    function void test_case(int j, int b, int i, int r1, int pc);
        J_TYPE = j;
        B_TYPE = b;
        I_TYPE = i;
        RS1 = r1;
        PC = pc;
    endfunction

    // END BRANCH_ADDR_GEN TEST

    // BEGIN COND_GEN TEST

    // logic[31:0] RS1, RS2;
    // logic EQ, LT, LTU;

    // BRANCH_COND_GEN mdle(
    //     .RS1(RS1),
    //     .RS2(RS2),
    //     .BR_EQ(EQ),
    //     .BR_LT(LT),
    //     .BR_LTU(LTU)
    // );

    // initial begin
    //     // br_eq
    //     RS1 = 32'h0A010BC0;
    //     RS2 = 32'h0A010BC0;
    //     #1 test_case(32'h0A010BC0, 32'h1A010BC0);
    //     #1 test_case(32'h00000000, 32'h1A010BC0);
    //     #1 test_case(32'h00000000, 32'h00000000);

    //     // br_lt
    //     #1 test_case(32'h80000000, 32'h7FFFFFFF);
    //     #1 test_case(32'h8FFFFFFF, 32'h80000000);
    //     #1 test_case(32'h00000000, 32'h00000000);
    //     #1 test_case(32'h81234567, 32'h00000000);
    //     #1 test_case(32'h71234567, 32'h00000000);

    //     // br_ltu
    //     #1 test_case(32'h80000000, 32'h7FFFFFFF);
    //     #1 test_case(32'h8FFFFFFF, 32'h80000000);
    //     #1 test_case(32'h00000000, 32'h00000000);
    //     #1 test_case(32'h81234567, 32'h80000000);
    //     #1 test_case(32'h71234567, 32'h80000000);
    //     #1 test_case(32'h10000000, 32'h20000000);
    // end

    // function void test_case(int r1, int r2);
    //     RS1 = r1;
    //     RS2 = r2;
    // endfunction

    // END COND_GEN TEST

endmodule
