`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: California Polytechnic State, University, San Luis Obispo
// Engineer: Brian Mere
// 
// Create Date: 01/30/2023 04:44:31 PM
// Design Name: IMMED_GEN
// Module Name: IMMED_GEN
// Project Name: HW4_ALU_and_IMMED
// Target Devices: Basys 3 Board
// Description: Generates the imm values from the various types of instructions for ALU.
// 
// Dependencies: None
//
//////////////////////////////////////////////////////////////////////////////////


module IMMED_GEN(
    input [31:7] INSTRUCT,
    output logic [31:0] U_TYPE,
    output logic [31:0] I_TYPE,
    output logic [31:0] S_TYPE,
    output logic [31:0] J_TYPE,
    output logic [31:0] B_TYPE
    );

    // USE COMBINATIONAL!
    always_comb begin
        U_TYPE = INSTRUCT[31:12]; // Will shift the bits 12 places left after these operations.
        // I_TYPE = INSTRUCT[]
        // S_TYPE = 
        // J_TYPE = 
        // B_TYPE = 
    end

endmodule
