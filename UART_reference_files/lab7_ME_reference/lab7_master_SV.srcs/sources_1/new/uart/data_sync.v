/*
 * data_sync.v
 * 2017/05/13 - Felipe Veas <felipe.veasv at usm.cl>
 *
 * This module synchronizes the input with respect the clock signal
 * and filters short spikes on the input line.
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
