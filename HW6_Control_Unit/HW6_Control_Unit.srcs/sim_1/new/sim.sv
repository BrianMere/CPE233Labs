`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Generated sim file
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );

    logic reset, clk;
//    logic intr, IOBUS_wr;
//    logic [31:0] IOBUS_in, IOBUS_out, IOBUS_addr;

    Otter_MCU MCU(
        .RST(reset),
        .CLK(clk)
//        .INTR(intr),
//        .IOBUS_IN(IOBUS_in),
//        .IOBUS_OUT(IOBUS_out),
//        .IOBUS_ADDR(IOBUS_addr),
//        .IOBUS_WR(IOBUS_wr)
    );

    initial begin
        reset = 1;
        clk = 0;
        //intr = 0; // can keep low
        #1 switch_clk();
        #1 switch_clk();
        reset = 0;
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        #1 switch_clk();
        
        
    end
    
    function void switch_clk();
        clk = ~clk;
    endfunction

endmodule
