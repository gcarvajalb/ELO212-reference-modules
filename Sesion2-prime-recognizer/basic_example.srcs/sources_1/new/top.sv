`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 06:25:18 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input  logic        CLK100MHZ, reset,
    output logic [6:0]  sevenSeg,
    output logic        AN_0,
    output logic        DP
    );

logic [3:0] P;

assign AN_0 = 1'b1;
    
count_4bit count_4bit_inst (
    .clk(CLK100MHZ),
    .reset(reset),
    .P (P));

BCD_to_sevenSeg BCD_to_sevenSeg_inst (
    .P(P),
    .sevenSeg(sevenSeg));
    
prime_rec prime_rec_inst (
    .P(P),
    .DP(DP));
        
endmodule
