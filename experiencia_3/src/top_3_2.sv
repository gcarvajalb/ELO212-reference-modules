// Displays the hexadecimal representation of a 16-bit number on 7-segment
// displays.

module top_3_2(
		input logic clk,

		input logic btnc, // Used as reset signal

		input logic [15:0] sw,

		output logic [6:0] disp_seg,
		output logic[7:0] disp_an
	);

	seven_seg_display_hex display_driver(
		.clk(clk),
		.reset(btnc),
		.values(sw),
		.display_enable(8'h0F),
		.segments(disp_seg),
		.enable(disp_an)
	);
	defparam display_driver.DISPLAY_COUNT = 8;
endmodule
