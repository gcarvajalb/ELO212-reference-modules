// Clock divider module
//
// Generates a divided clock signal of a desired frequency (approximation)
// by setting target (output) and source (input) frequencies.
//
// Hans Lehnert
// Universidad Técnica Federico Santa María

module clock_divider(
		input logic clk_in,
		// Input clock signal. Frequency should match SOURCE_FREQ

		input logic reset,
		// Reset signal.

		output logic clk_out,
		// Divided clock signal. Frequency matches TARGET_FREQ.

		output logic rise,
		// Signals positive edge of the generated clock.

		output logic fall
		// Signals negative edge if the generated clock.
	);

	parameter SOURCE_FREQ = 100_000_000;
	// The frequency of the input clock (clk_in)

	parameter TARGET_FREQ = 6_250_000;
	// The desired frqcuency of the divided clock (clk_out)

	parameter MODE = 0;
	// Select between:
	// 0: The generated clock will only be high for a single cycle of the
	//    original clock signal
	// 1: The generated clock approximates a 50% DC square signal.

	// Defines for operation modes
	localparam MODE_SINGLESHOT = 0;
	localparam MODE_SQUARE = 1;

	localparam CLK_COUNT = SOURCE_FREQ / TARGET_FREQ; // Divided clock period
	localparam N = $clog2(CLK_COUNT - 1); // Width of the clock count

	logic [N-1:0] count;

	counter period_counter(
		.clk(clk_in),
		.reset(reset),
		.enable(1'b1),
		.count(count)
	);
	defparam period_counter.MAX = CLK_COUNT - 1;

	always_ff @(posedge clk_in or posedge reset) begin
		if (reset) begin
			clk_out <= 0;
			rise <= 0;
			fall <= 0;
		end
		else begin
			// Output signal generation. Signals to be used as clock should be
			// synchronous to avoid glitches.
			if ((MODE == MODE_SINGLESHOT && count == 0) ||
				(MODE == MODE_SQUARE && count < CLK_COUNT / 2)) begin
				clk_out <= 1'b1;

				// Set the rise signal if transitioning from low to high
				if (clk_out == 0)
					rise <= 1'b1;
				else
					rise <= 0;
			end
			else begin
				clk_out <= 1'b0;

				// Set the fall signal if transitioning from high to low
				if (clk_out == 1'b1)
					fall <= 1'b1;
				else
					fall <= 0;
			end
		end
	end
endmodule
