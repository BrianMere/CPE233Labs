`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Generated Sim File ...
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );

    logic clk, btnc;
    logic [15:0] switches, leds;
    logic [7:0] cathodes;
    logic [3:0] anodes;

    OTTER_Wrapper otter(
        .CLK(clk),
        .BTNC(btnc),
        .SWITCHES(switches),
        .LEDS(leds),
        .CATHODES(cathodes),
        .ANODES(anodes)
    );

    initial begin
        clk = 0;
        switches = 16'b010;
        forever begin
        #1 clk = ~clk;
        end
    end

endmodule
