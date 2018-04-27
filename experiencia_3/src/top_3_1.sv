// Displays the value of switches on LEDs

module top_3_1(
		input [15:0] sw,
		output [15:0] led
	);

	assign led = sw;
endmodule
