// Wrapper for seven segment display and hex decoder
//
// Hans Lehnert
// Universidad Técnica Federico Santa María

module seven_seg_display_hex(
		input logic clk,
		// Input clock

		input logic reset,
		// Reset signal

		input logic [4*DISPLAY_COUNT-1:0] values,
		// An array of 4-bit values to decode multiplex.

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

    logic [3:0] hex_value;
    logic [6:0] segments_inv;

    assign segments = ~segments_inv;

    seven_seg_display display_driver(
        .clk(clk),
        .reset(reset),
        .values(values),
        .display_enable(display_enable),
        .selected(hex_value),
        .enable(enable)
    );
    defparam display_driver.DISPLAY_COUNT = DISPLAY_COUNT;
    defparam display_driver.SOURCE_FREQ = SOURCE_FREQ;
    defparam display_driver.DATA_SIZE = 4;

    seven_seg_hex_decoder decoder(
        .hex(hex_value),
        .seg(segments_inv)
    );

endmodule
