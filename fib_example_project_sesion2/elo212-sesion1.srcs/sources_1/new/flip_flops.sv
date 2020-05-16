`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2020 08:48:12 PM
// Design Name: 
// Module Name: flip_flops
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


module flip_flops(
    input logic A, clk, reset,
    output logic y
    );
    
    always_ff @(posedge clk) begin
        if (reset)
            y <= 0;
        else
            y <= A;
    end
    
endmodule
