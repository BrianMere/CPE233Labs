`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Generated SIM File
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );

    logic CLK, BTNL, BTNC;
    logic [15:0] SWITCHES, LEDS;
    logic [7:0] CATHODES;
    logic [3:0] ANODES;

    const int LOW_DELAY = 20000; // num clk's/2 to then press the button
    const int HIGH_DELAY = 200000;
    int i;
    int flag; // gives the state we're in. Low for low state, and vice versa.

    OTTER_Wrapper otter(
        .CLK(CLK),
        .BTNL(BTNL),
        .BTNC(BTNC),
        .SWITCHES(SWITCHES),
        .LEDS(LEDS),
        .CATHODES(CATHODES),
        .ANODES(ANODES)
    );

    initial begin
        CLK = 0;
        BTNL = 0;           // INTR
        SWITCHES = 16'b1;   // enable interrupts on boot.

        i = 0;
        flag = 0;
        BTNC = 1;
        #1 CLK = ~CLK;
        #1 CLK = ~CLK;
        BTNC = 0;
        forever begin
            #1 CLK = ~CLK;
            i++;
            if(~flag && i == LOW_DELAY) begin
                BTNL = ~BTNL;
                i = 0;
            end
            else if (i == HIGH_DELAY) begin
                BTNL = ~BTNL;
                i = 0;
            end

        end
    end

endmodule
