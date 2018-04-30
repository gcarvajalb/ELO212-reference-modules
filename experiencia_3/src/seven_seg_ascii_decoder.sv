// Seven segment display decoder
//
// Converts a 8-bit character to 7-segment using ascii encoding. Only numbers
// and letters supported.
// Output is in {A, B, C, D, E, F, G} order.
//
// Hans Lehnert
// Universidad Técnica Federico Santa María

module seven_seg_ascii_decoder(
		input logic [7:0] val,
		output logic [6:0] seg
	);

	always_comb begin
		case (val)
		"0": seg = 7'b1111110;
		"1": seg = 7'b0110000;
		"2": seg = 7'b1101101;
		"3": seg = 7'b1111001;
		"4": seg = 7'b0110011;
		"5": seg = 7'b1011011;
		"6": seg = 7'b1011111;
		"7": seg = 7'b1110000;
		"8": seg = 7'b1111111;
		"9": seg = 7'b1111011;
		"A", "a": seg = 7'b1110111;
		"B", "b": seg = 7'b0011111;
		"C", "c": seg = 7'b0001101;
		"D", "d": seg = 7'b0111101;
		"E", "e": seg = 7'b1001111;
		"F", "f": seg = 7'b1000111;
		"G", "g": seg = 7'b1011110;
		"H", "h": seg = 7'b0110111;
		"I", "i": seg = 7'b0010000;
		"J", "j": seg = 7'b1111100;
		"K", "k": seg = 7'b1010111;
		"L", "l": seg = 7'b0001110;
		"M", "m": seg = 7'b1010100;
		"N", "n": seg = 7'b0010101;
		"O", "o": seg = 7'b0011101;
		"P", "p": seg = 7'b1100111;
		"Q", "q": seg = 7'b1110011;
		"R", "r": seg = 7'b0000101;
		"S", "s": seg = 7'b1011011;
		"T", "t": seg = 7'b0001111;
		"U", "u": seg = 7'b0111110;
		"V", "v": seg = 7'b0011100;
		"W", "w": seg = 7'b0101010;
		"X", "x": seg = 7'b0110110;
		"Y", "y": seg = 7'b0111011;
		"Z", "z": seg = 7'b1101101;
		default: seg = 'b0;
		endcase
	end
endmodule
