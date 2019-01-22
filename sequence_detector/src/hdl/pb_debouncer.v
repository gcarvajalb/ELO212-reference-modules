`timescale 1ns / 1ps

module pb_debouncer
#(
	parameter COUNTER_WIDTH = 16
)(
	input clk,
	input rst,
	input pb,
	output reg pb_state,
	output reg pb_negedge,
	output reg pb_posedge
);

	localparam PB_IDLE   = 3'b000;
	localparam PB_COUNT  = 3'b001;
	localparam PB_PE     = 3'b010;
	localparam PB_STABLE = 3'b011;
	localparam PB_NE     = 3'b100;

	localparam COUNTER_MSB = COUNTER_WIDTH - 1;

	reg [2:0] button_state, button_state_next = PB_IDLE;
	reg [COUNTER_MSB:0] pb_cnt, pb_cnt_next;

	reg [1:0] pb_sync_sr; /* Flip Flops para sincronizar. */
	wire pb_sync = pb_sync_sr[0];

	wire pb_cnt_max = &pb_cnt;

	always @(posedge clk)
		pb_sync_sr <= {pb, pb_sync_sr[1]};

	/* Etapa combinacional para el cambio de estado. */
	always @(*) begin
		button_state_next = button_state;

		case (button_state)
		PB_IDLE:
			if (pb_sync == 1'b1)
				button_state_next = PB_COUNT;
		PB_COUNT:
			if (pb_sync == 1'b0)
				button_state_next = PB_IDLE;
			else if (pb_cnt_max == 1'b1)
				button_state_next = PB_PE;
		PB_PE:
			button_state_next = PB_STABLE;
		PB_STABLE:
			if (pb_sync == 1'b0)
				button_state_next = PB_NE;
		PB_NE:
			button_state_next = PB_IDLE;
		default:
			button_state_next = PB_IDLE;
		endcase
	end

	/* Etapa combinacional de las salidas y contador. */
	always @(*) begin
		pb_state = 1'b0;
		pb_negedge = 1'b0;
		pb_posedge = 1'b0;
		pb_cnt_next = 'd0;

		case (button_state)
		PB_STABLE:
			pb_state = 1'b1;
		PB_COUNT:
			pb_cnt_next = pb_cnt + 'd1;
		PB_PE: begin
			pb_state = 1'b1;
			pb_posedge = 1'b1;
		end
		PB_NE:
			pb_negedge = 1'b1;
		endcase
	end

	/* Registrando el estado. */
	always @(posedge clk)
		if (rst)
			button_state <= PB_IDLE;
		else
			button_state <= button_state_next;

	/* Registrando el contador. */
	always @(posedge clk)
		if (rst)
			pb_cnt <= 'd0;
		else
			pb_cnt <= pb_cnt_next;

endmodule
