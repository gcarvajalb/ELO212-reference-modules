// Wrapper for seven segment display and ASCII decoder
//
// Hans Lehnert
// Universidad Técnica Federico Santa María

module seven_seg_display_ascii(
		input logic clk,
		// Input clock

		input logic reset,
		// Reset signal

		input logic [8*DISPLAY_COUNT-1:0] values,
		// An array of 8-bit ASCII characters to decode and multiplex.

		input logic [DISPLAY_COUNT-1:0] display_enable,
		// Select which displays to enable. Disabled displays are turned off.

		output logic [6:0] segments,
		// Seven segment decoded value

		output logic [DISPLAY_COUNT-1:0] enable
		// Generated time multiplexed enable signal for the displays.
	);

	parameter DISPLAY_COUNT = 4;
	// Sets the amount of displays.

	parameter SOURCE_FREQ = 100_000_000;
	// Frequency of the input clock signal. Used to calculate clock divider.

    logic [7:0] char_value;
    logic [6:0] segments_inv;

    assign segments = ~segments_inv;

    seven_seg_display display_driver(
        .clk(clk),
        .reset(reset),
        .values(values),
        .display_enable(display_enable),
        .selected(char_value),
        .enable(enable)
    );
    defparam display_driver.DISPLAY_COUNT = DISPLAY_COUNT;
    defparam display_driver.SOURCE_FREQ = SOURCE_FREQ;
    defparam display_driver.DATA_SIZE = 8;

    seven_seg_ascii_decoder decoder(
        .val(char_value),
        .seg(segments_inv)
    );

endmodule
