`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2020 04:59:17 PM
// Design Name: 
// Module Name: logica_simple
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


module fib_continuous (
	input logic  a, b, c, d,
	output logic f
	);
	
	assign f =  (~a && ~c) || (~b && ~c) || (~b && ~d);
	
endmodule