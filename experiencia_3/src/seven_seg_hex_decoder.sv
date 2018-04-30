// Seven segment display decoder
//
// Converts a 4-bit binary number into it's seven segment hex representation.
// Output is in {A, B, C, D, E, F, G} order.
//
// Hans Lehnert
// Universidad Técnica Federico Santa María

module seven_seg_hex_decoder(
		input logic [3:0] hex,
		output logic [6:0] seg
	);

	always_comb begin
		case (hex)
		4'h0: seg = 7'b1111110;
		4'h1: seg = 7'b0110000;
		4'h2: seg = 7'b1101101;
		4'h3: seg = 7'b1111001;
		4'h4: seg = 7'b0110011;
		4'h5: seg = 7'b1011011;
		4'h6: seg = 7'b1011111;
		4'h7: seg = 7'b1110000;
		4'h8: seg = 7'b1111111;
		4'h9: seg = 7'b1111011;
		4'hA: seg = 7'b1110111;
		4'hB: seg = 7'b0011111;
		4'hC: seg = 7'b0001101;
		4'hD: seg = 7'b0111101;
		4'hE: seg = 7'b1001111;
		4'hF: seg = 7'b1000111;
		endcase
	end
endmodule
