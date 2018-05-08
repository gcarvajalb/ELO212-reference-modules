// Displays the hexadecimal representation of a 16-bit number on 7-segment
// displays.

module top_3_3(
		input logic clk,

		input logic btnc, // Used as reset signal

		input logic [1:0] sw,

		output logic [6:0] disp_seg,
		output logic [7:0] disp_an
	);


	logic clk_count;
	logic [31:0] count;

	// Divided clock signal for 4 Hz count
	clock_divider counter_clock(
		.clk_in(clk),
		.clk_out(clk_count),
		.reset(btnc)
	);
	defparam counter_clock.TARGET_FREQ = 4;

	counter display_counter(
		.clk(clk),
		.reset(sw[0]),
		.enable(clk_count),
		.count(count)
	);
	defparam display_counter.MAX = 'hFFFFFFFF;
	// Maximum value that can be displayed

	seven_seg_display_hex display_driver(
		.clk(clk),
		.reset(btnc),
		.values(count),
		.display_enable(8'hFF),
		.segments(disp_seg),
		.enable(disp_an)
	);
	defparam display_driver.DISPLAY_COUNT = 8;
endmodule
