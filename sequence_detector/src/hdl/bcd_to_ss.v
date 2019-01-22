/*
 * bcd_to_ss.v
 * 2017/04/17 - Felipe Veas <felipe.veasv [at] usm.cl>
 *
 * Conversor de un nibble BCD a 7 segmentos
 */

`timescale 1ns / 1ps

module bcd_to_ss
(
	input [3:0] bcd_in,
	output reg [6:0] out
);

	always @(*) begin
		case (bcd_in)
		4'h0: out = 7'b1000000;
		4'h1: out = 7'b1111001;
		4'h2: out = 7'b0100100;
		4'h3: out = 7'b0110000;
		4'h4: out = 7'b0011001;
		4'h5: out = 7'b0010010;
		4'h6: out = 7'b0000010;
		4'h7: out = 7'b1111000;
		4'h8: out = 7'b0000000;
		4'h9: out = 7'b0010000;
		4'hA: out = 7'b0001000;
		4'hB: out = 7'b0000011;
		4'hC: out = 7'b1000110;
		4'hD: out = 7'b0100001;
		4'hE: out = 7'b0000110;
		default:
			out = 7'b0001110; /* bcd_in == 4'hF */
		endcase
	end
endmodule
