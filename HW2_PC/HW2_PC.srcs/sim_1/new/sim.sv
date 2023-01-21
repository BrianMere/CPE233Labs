`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Simulation Test Bench
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );

    // BEGIN mux SIM

    // logic [31:0] PC_P4, JALR, BRANCH, JAL, MTVEC, MEPC;
    // logic[2:0] PC_SOURCE;
    // logic[31:0] PC_DOUT;

    // mux6sel mux(
    //         .PC_P4(PC_P4),
    //         .JALR(JALR),
    //         .BRANCH(BRANCH),
    //         .JAL(JAL),
    //         .MTVEC(MTVEC),
    //         .MEPC(MEPC),
    //         .PC_SOURCE(PC_SOURCE),
    //         .PC_DOUT(PC_DOUT)
    //     );

    // initial begin
    //     PC_P4 = 'h10000000;
    //     JALR = 'h01000000;
    //     BRANCH = 'h00100000;
    //     JAL = 'h00010000;
    //     MTVEC = 'h00001000;
    //     MEPC = 'h00000100;

    //     test_case(0);
    //     #1 test_case(1);
    //     #1 test_case(2);
    //     #1 test_case(3);
    //     #1 test_case(4);
    //     #1 test_case(5);
    //     #1 test_case(6);
    //     #1 test_case(7);

    // end

    // function void test_case(int source);
    //     PC_SOURCE = source;
    // endfunction

    // END mux SIM

    // BEGIN Adder SIM

    // logic [31:0] operand;
    // logic [31:0] adder_out;

    // add4adder adder(
    //     .operand(operand),
    //     .added_out(adder_out)
    // );

    // initial begin
    //     operand = 0;
    //     #1 test_case(0);
    //     #1 test_case(25);
    //     #1 test_case('hFFFFFFFF);
    //     #1 test_case('hFFFFFFFC);
    // end 

    // function void test_case(int oper);
    //     operand = oper;
    // endfunction

    // END Adder SIM

    // Begin PC simulation file

    // logic [31:0] PC_DIN, PC_COUNT;

    // logic PC_WRITE, PC_RST, CLK;

    // program_counter counter(
    //     .PC_WRITE(PC_WRITE),
    //     .PC_RST(PC_RST),
    //     .CLK(CLK),
    //     .PC_DIN(PC_DIN),
    //     .PC_COUNT(PC_COUNT)
    // );

    // initial begin
    //     PC_WRITE = 0;
    //     PC_RST = 1;
    //     PC_DIN = 0;
    //     CLK = 0; // intial clock is high based on the function below
    //     test_case(1, 0, 0);
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    //     #1 test_case(0,0,0);
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    //     #1 test_case(0,1,1);
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    //     #1 test_case(0,0,0);
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    //     #1 test_case(0,1,4294967295); // = 0xFFFFFFFF
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    //     #1 test_case(1,1,4294967295);
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    //     #1 test_case(0,0,4294967295);
    //     #1 cycleCLK();
    //     #1 cycleCLK();
    // end

    // // assume that clk starts high, goes low, sets values, then goes high again
    // function void test_case(int pc_r, int pc_w, int pc_d);
    //     PC_WRITE = pc_w;
    //     PC_RST = pc_r;
    //     PC_DIN = pc_d;
    // endfunction

    // function void cycleCLK();
    //     CLK = ~CLK;
    // endfunction

endmodule
