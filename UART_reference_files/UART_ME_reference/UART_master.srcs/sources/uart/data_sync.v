/*
 * data_sync.v
 * 2017/05/13 - Felipe Veas <felipe.veasv at usm.cl>
 * 2022/07/04 - Mauricio Solis: Add some comments abd headers.
 * @brief
 * This module synchronizes the input with respect the clock signal
 * and filters short spikes on the input line.
 *
 * Basicaly the "in" signal is passed through a register to synchronize it with the clk,
 * then if the "in" signal is HIGH, a module 4 counter starts to count up to 2'b11
 * in order to filter short spikes, once the counter is at 2'b11, the output is put on HIGH.
 * Otherwise if the "in" signal is LOW, the counter is decreased, once the couter is at 2'b00
 * the output is put on LOW.
 * 
 * @param clk         It should ve the FPGA clock.
 * @param in          The raw input signal.
 * @param stable_out  The synchronized and filtered signal.
 */

`timescale 1ns / 1ps

module data_sync
(
	input clk,
	input in,
	output reg stable_out
);

	/* Clock synchronized input */
	reg [1:0] in_sync_sr;
	wire in_sync = in_sync_sr[0];

	always @(posedge clk)
		in_sync_sr <= {in, in_sync_sr[1]};

	/* Filter out short spikes on the input line */
	reg [1:0] sync_counter = 'b11, sync_counter_next;
	reg stable_out_next;

	always @(*) begin
		if (in_sync == 1'b1 && sync_counter != 2'b11)
			sync_counter_next = sync_counter + 'd1;
		else if (in_sync == 1'b0 && sync_counter != 2'b00)
			sync_counter_next = sync_counter - 'd1;
		else
			sync_counter_next = sync_counter;
	end

	always @(*) begin
		case (sync_counter)
		2'b00:
			stable_out_next = 1'b0;
		2'b11:
			stable_out_next = 1'b1;
		default:
			/* Keep the previous value if the counter is not on its boundaries */
			stable_out_next = stable_out;
		endcase
	end

	always @(posedge clk) begin
		stable_out <= stable_out_next;
		sync_counter <= sync_counter_next;
	end

endmodule
