`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2018 06:13:43 PM
// Design Name: 
// Module Name: BCD_to_sevenSeg
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


module BCD_to_sevenSeg(
    output  logic [6:0] sevenSeg,
    input   logic [3:0] P
    );
    
always_comb begin
    case(P)
            4'd0:       sevenSeg = 7'b1111110;
            4'd1:       sevenSeg = 7'b0110000; 
            4'd2:       sevenSeg = 7'b1101101;
            4'd3:       sevenSeg = 7'b1111001;
            4'd4:       sevenSeg = 7'b0110011;
            4'd5:       sevenSeg = 7'b1011011;
            4'd6:       sevenSeg = 7'b1011111;
            4'd7:       sevenSeg = 7'b1110000;
            4'd8:       sevenSeg = 7'b1111111;
            4'd9:       sevenSeg = 7'b1110011;
            default:    sevenSeg = 7'b0000000;
        endcase
    end 
endmodule
