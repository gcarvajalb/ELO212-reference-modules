// Driver for time multiplexed seven segment display
//
// Generates the control signals and and multiplexes values for use in a seven
// segment display. The display count can be adjusted using parameter
// DISPLAY_COUNT.
//
// Hans Lehnert
// Universidad Técnica Federico Santa María

module seven_seg_display(
		input logic clk,
		// Input clock

		input logic reset,
		// Reset signal

		input logic [DATA_SIZE*DISPLAY_COUNT-1:0] values,
		// An array of values to multiplex. The number of btis of each value
		// can be adjusted using the DATA_SIZE parameter. This module
		// multiplexes this values on the selected output

		input logic [DISPLAY_COUNT-1:0] display_enable,
		// Select which displays to enable. Disabled displays are turned off.

		output logic [DATA_SIZE-1:0] selected,
		// The currently enabled value. Should be decoded to seven segment
		// format.

		output logic [DISPLAY_COUNT-1:0] enable
		// Generated time multiplexed enable signal for the displays.
	);

	parameter DISPLAY_COUNT = 4;
	// Sets the amount of displays.

	parameter DATA_SIZE = 4;
	// values of bits

	parameter SOURCE_FREQ = 100_000_000;
	// Frequency of the input clock signal. Used to calculate clock divider.

	logic clk_disp;

	// Counter used to select which display to enable
	localparam COUNTER_WIDTH = $clog2(DISPLAY_COUNT);
	logic [COUNTER_WIDTH-1:0] count;

	// To generate the enable signal, a single 1 is shifted by the value of
	// the counter.
	assign enable = ~((1 << count) & display_enable);

	assign selected = values[count*DATA_SIZE+:DATA_SIZE];

	// Clock divider for the display multiplexing.
	// A multiplexing frequency of 100 Hz per display is used to avoid
	// flickering.
	clock_divider clk_display (
		.clk_in(clk),
		.clk_out(clk_disp),
		.reset(reset)
	);
	defparam clk_display.SOURCE_FREQ = SOURCE_FREQ;
	defparam clk_display.TARGET_FREQ = 100 * DISPLAY_COUNT;

	// Counter logic
	always_ff @(posedge clk_disp or posedge reset) begin
		if (reset) begin
			count <= 0;
		end
		else begin
			if (count < (DISPLAY_COUNT - 1))
				count <= count + 1;
			else
				count <= 0;
		end
	end
endmodule
