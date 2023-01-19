`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Califronia Polytechnic State University, San Luis Obispo
// Engineer: Brian Mere
// 
// Create Date: 01/18/2023 04:01:05 PM
// Design Name: mux6sel
// Module Name: N/A (no top module)
// Project Name: HW2: PC
// Target Devices: Basys 3
// Description: A 6-input select mux to handle selection of inputs to the PC. 
// 
// Dependencies: None
// 
//////////////////////////////////////////////////////////////////////////////////

module mux6sel(
        input[31:0] PC_P4,          // whatever value the PC has +4
        input[31:0] JALR,           // new address input from a jalr instruction
        input[31:0] BRANCH,         // new address input from a BRANCH (beq, for example) instruction
        input[31:0] JAL,            // new address input from 
        input[31:0] MTVEC,
        input[31:0] MEPC,
        input[2:0] PC_SOURCE,
        output logic[31:0] PC_DOUT
    );
endmodule
