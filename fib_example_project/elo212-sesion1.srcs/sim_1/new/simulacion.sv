`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2020 05:31:19 PM
// Design Name: 
// Module Name: simulacion
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


module testbench_simple();
	logic a_t, b_t, c_t, d_t;  //internal signals for stimulus
	logic [3:0] num_in;
	logic f_logic, f_proc;  // internal signals for outputs

// one instance of the fibinary recognizer described with continuous assignments
fib_continuous DUT_fib_continuous(
	.a(a_t),
	.b(b_t),
	.c(c_t),
	.d(d_t),
	.f(f_logic)
	);

// one instance of the fibinary recognizer described with procedural statements
fib_procedural DUT_fib_procedural(
	.BCD_in(num_in),
	.f(f_proc)
	);

initial begin
	a_t = 1'b0;  b_t = 1'b0; c_t = 1'b0 ; d_t = 1'b0;
	num_in= 4'd0;
	#3
	a_t = 1'b0;  b_t = 1'b0; c_t = 1'b0 ; d_t = 1'b1;
	num_in= 4'd1;
	#3
	a_t = 1'b0;  b_t = 1'b0; c_t = 1'b1 ; d_t = 1'b0;
	num_in= 4'd2;
	#3
	a_t = 1'b0;  b_t = 1'b0; c_t = 1'b1 ; d_t = 1'b1;
	num_in= 4'd3;
	#3
	a_t = 1'b0;  b_t = 1'b1; c_t = 1'b0 ; d_t = 1'b0;
	num_in= 4'd4;
	#3
	a_t = 1'b0;  b_t = 1'b1; c_t = 1'b0 ; d_t = 1'b1;
	num_in= 4'd5;
	#3
	a_t = 1'b0;  b_t = 1'b1; c_t = 1'b1 ; d_t = 1'b0;
	num_in= 4'd6;
	#3
	a_t = 1'b0;  b_t = 1'b1; c_t = 1'b1 ; d_t = 1'b1;
	num_in= 4'd7;
	#3
	a_t = 1'b1;  b_t = 1'b0; c_t = 1'b0 ; d_t = 1'b0;
	num_in= 4'd8;
	#3
	a_t = 1'b1;  b_t = 1'b0; c_t = 1'b0 ; d_t = 1'b1;
	num_in= 4'd9;
	#3
	a_t = 1'b1;  b_t = 1'b0; c_t = 1'b1 ; d_t = 1'b0;
	num_in= 4'd10;
	#3
	a_t = 1'b1;  b_t = 1'b0; c_t = 1'b1 ; d_t = 1'b1;
	num_in= 4'd11;
	#3
	a_t = 1'b1;  b_t = 1'b1; c_t = 1'b0 ; d_t = 1'b0;
	num_in= 4'd12;
	#3
	a_t = 1'b1;  b_t = 1'b1; c_t = 1'b0 ; d_t = 1'b1;
	num_in= 4'd13;
	#3
	a_t = 1'b1;  b_t = 1'b1; c_t = 1'b1 ; d_t = 1'b0;
	num_in= 4'd14;
	#3
	a_t = 1'b1;  b_t = 1'b1; c_t = 1'b1 ; d_t = 1'b1;
	num_in= 4'd15;
end
endmodule