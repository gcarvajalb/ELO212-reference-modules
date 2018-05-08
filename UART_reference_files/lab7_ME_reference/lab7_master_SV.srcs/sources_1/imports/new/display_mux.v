/*
 * display_mux.v
 * 2016/12/01 - Felipe J. Veas <felipe at veas.me>
 *
 * 8 x 7-segment display multiplexor
 */

`timescale 1ns / 1ps

module display_mux
(
	input clk,
	input clk_enable,
	input [31:0] bcd,
	input [7:0] dots,
	input is_negative,
	input turn_off,
	output [7:0] ss_value,
	output [7:0] ss_select
);
	/*
	 * Using one-hot coding is particularly useful since the state itself can be
	 * connected to the selector bus directly.
	 */
	localparam DIG_0 = 8'b00000001;
	localparam DIG_1 = 8'b00000010;
	localparam DIG_2 = 8'b00000100;
	localparam DIG_3 = 8'b00001000;
	localparam DIG_4 = 8'b00010000;
	localparam DIG_5 = 8'b00100000;
	localparam DIG_6 = 8'b01000000;
	localparam DIG_7 = 8'b10000000;

	reg [7:0] ss_select_q;
	wire [7:0] ss_select_d;

	wire dot_enable;
	wire [3:0] bcd_nibble;
	wire [6:0] ss_digits;
	reg [6:0] ss_digits_mux;

	always @(*) begin
		if (ss_select_q == DIG_7)
			ss_digits_mux = (is_negative) ? 7'b0111111 : 7'b1111111;
		else
			ss_digits_mux = ss_digits;
	end

	assign dot_enable = |(ss_select_q & dots);
	assign ss_value = {~dot_enable, ss_digits_mux};
	assign ss_select = ~ss_select_q;

	/* Convert a 4-bit nibble into BCD notation */
	bcd_to_ss to_ss (
		.bcd_in(bcd_nibble),
		.out(ss_digits)
	);

	/* Choose the appropriate nibble for a specific digit */
	assign bcd_nibble =
		(ss_select_q == DIG_0) ? bcd[3:0] :
		(ss_select_q == DIG_1) ? bcd[7:4] :
		(ss_select_q == DIG_2) ? bcd[11:8] :
		(ss_select_q == DIG_3) ? bcd[15:12] :
		(ss_select_q == DIG_4) ? bcd[19:16] :
		(ss_select_q == DIG_5) ? bcd[23:20] :
		(ss_select_q == DIG_6) ? bcd[27:24] : bcd[31:28];

	/* Compute the next state */
	assign ss_select_d =
		(ss_select_q == DIG_0) ? DIG_1 :
		(ss_select_q == DIG_1) ? DIG_2 :
		(ss_select_q == DIG_2) ? DIG_3 :
		(ss_select_q == DIG_3) ? DIG_4 :
		(ss_select_q == DIG_4) ? DIG_5 :
		(ss_select_q == DIG_5) ? DIG_6 :
		(ss_select_q == DIG_6) ? DIG_7 : DIG_0;

	/* Assign the next state */
	always @(posedge clk)
		if (clk_enable)
			ss_select_q <= (turn_off) ? 8'd0 : ss_select_d;

endmodule