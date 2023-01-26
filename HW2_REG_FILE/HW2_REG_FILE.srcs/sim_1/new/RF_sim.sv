`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Generated sim file testbench
//////////////////////////////////////////////////////////////////////////////////

module RF_sim(
    );

    logic [4:0] RF_ADR1, RF_ADR2, RF_WA;
    logic RF_EN, CLK;
    logic [31:0] RF_WD, RF_RS1, RF_RS2; 

    REG_FILE reg_file(
        .RF_ADR1(RF_ADR1),
        .RF_ADR2(RF_ADR2),
        .RF_WA(RF_WA),
        .RF_EN(RF_EN),
        .CLK(CLK),
        .RF_WD(RF_WD),
        .RF_RS1(RF_RS1),
        .RF_RS2(RF_RS2)
    );

    initial begin
        RF_ADR1 = 0;
        RF_ADR2 = 0;
        RF_WA = 0;
        RF_EN = 0;
        RF_WD = 0;
        CLK = 0;

        // begin test cases
        
        // currently all read values should be 0's

        test_case(0,0,0,0,0); // 0
        #1 tick_clk();

        test_case(0,13,13,'h255,0);
        #1 tick_clk();

        test_case(31,2,7,'h31, 1); //2 
        #1 tick_clk();

        test_case(31,2,7,'h31, 1);
        #1 tick_clk();

        test_case(7,2,2,'hFFFFFFFF, 1); //4
        #1 tick_clk();

        test_case(7,2,2,'hFFFFFFFF, 1);
        #1 tick_clk();

        test_case(0,2,0,'hFFFFFAFF, 1); // 6
        #1 tick_clk();

        test_case(0,2,0,'hFFFFFAFF, 1);
        #1 tick_clk();

        test_case(2,0,2,'h123, 0); // 8
        #1 tick_clk();

        test_case(4,2,2,'h124, 1);
        #1 tick_clk();

    end

    function test_case(int adr1, int adr2, int wa, int wd, int en);
        RF_ADR1 = adr1;
        RF_ADR2 = adr2;
        RF_WD = wd;
        RF_WA = wa;
        RF_EN = en;
    endfunction

    function tick_clk();
        CLK = ~CLK;
    endfunction

endmodule
