// Displays an string on the seven segment display

module top_3_4(
		input logic clk,

		input logic btnc, // Used as reset signal

		output logic [6:0] disp_seg,
		output logic[7:0] disp_an
	);

	seven_seg_display_ascii display_driver(
		.clk(clk),
		.reset(btnc),
		.values("HL HL HL"),
		.display_enable(8'hFF),
		.segments(disp_seg),
		.enable(disp_an)
	);
	defparam display_driver.DISPLAY_COUNT = 8;
endmodule
