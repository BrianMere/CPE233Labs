`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// HW 1 sim file to test assembly code
//////////////////////////////////////////////////////////////////////////////////


module HW1Sim(
    );
    
    logic progClk;
    logic [31:0] prog_addr, instruct;
    
    ProgRom rom(.PROG_CLK(progClk),
	.PROG_ADDR(prog_addr),
	.INSTRUCT(instruct)
	);
    
    initial begin
        progClk = 0;
        prog_addr = 32'b0;
        instruct = 32'b0;
        forever begin
            #4 progClk = ~progClk;
            prog_addr = prog_addr + 32'b100;
            #1 progClk = ~progClk;
        end  
    end
endmodule
