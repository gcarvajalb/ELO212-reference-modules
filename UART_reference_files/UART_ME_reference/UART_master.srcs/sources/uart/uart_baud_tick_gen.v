/*
 * uart_baud_tick_gen.v
 * 2017/02/01 - Felipe Veas <felipe.veasv at usm.cl>
 *
 * Baud clock generator for UART, original code from:
 * http://fpga4fun.com/SerialInterface.html
 */

`timescale 1ns / 1ps

module uart_baud_tick_gen
#(
	parameter CLK_FREQUENCY = 25000000,
	parameter BAUD_RATE = 115200,
	parameter OVERSAMPLING = 1
)(
	input clk,
	input enable,
	output tick
);

	function integer clog2;
		input integer value;
		begin
			value = value - 1;
			for (clog2 = 0; value > 0; clog2 = clog2 + 1)
				value = value >> 1;
		end
	endfunction

	localparam ACC_WIDTH = clog2(CLK_FREQUENCY / BAUD_RATE) + 8;
	localparam SHIFT_LIMITER = clog2(BAUD_RATE * OVERSAMPLING >> (31 - ACC_WIDTH));
	localparam INCREMENT =
			((BAUD_RATE * OVERSAMPLING << (ACC_WIDTH - SHIFT_LIMITER)) +
			(CLK_FREQUENCY >> (SHIFT_LIMITER + 1))) / (CLK_FREQUENCY >> SHIFT_LIMITER);

	(* keep = "true" *)
	reg [ACC_WIDTH:0] acc = 0;

	always @(posedge clk)
		if (enable)
			acc <= acc[ACC_WIDTH-1:0] + INCREMENT[ACC_WIDTH:0];
		else
			acc <= INCREMENT[ACC_WIDTH:0];

	assign tick = acc[ACC_WIDTH];

endmodule
