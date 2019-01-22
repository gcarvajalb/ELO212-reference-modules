/*
 *
 */

`timescale 1ns / 1ps

module detector_secuencia
(
	input clk,
	input reset,
	input in,
	input tick,
	output [2:0] current_state,
	output reg out
);

	/* Estados del detector */
	localparam S0 = 'b000;
	localparam S1 = 'b001;
	localparam S2 = 'b010;
	localparam S3 = 'b011;
	localparam S4 = 'b100;

	reg [2:0] state, state_next = S0;

	assign current_state = state;

	/* Lógica combinacional para el estado siguiente */
	always @(*) begin
		case (state)
		S0:
			if (in == 1'b1)
				state_next = S1;
			else
				state_next = S0;
		S1:
			if (in == 1'b0)
				state_next = S2;
			else
				state_next = S1;
		S2:
			if (in == 1'b1)
				state_next = S3;
			else
				state_next = S0;
		S3:
			if (in == 1'b1)
				state_next = S4;
			else
				state_next = S2;
		S4:
			if (in == 1'b0)
				state_next = S2;
			else
				state_next = S1;
		default:
			state_next = S0;
		endcase
	end

	/* Lógica combinacional para la salida */
	always @(*) begin
		if (state == S4)
			out = 1'b1;
		else
			out = 1'b0;
	end

	/* Lógica secuencial */
	always @(posedge clk) begin
		if (reset)
			state <= S0;
		else if (tick)
			state <= state_next;
		else
			state <= state;
	end

endmodule
