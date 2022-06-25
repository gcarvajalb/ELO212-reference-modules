`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2018 07:09:36 PM
// Design Name: 
// Module Name: pb_debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pb_debouncer
#(
	parameter COUNTER_WIDTH = 16
)(
	input  logic   clk,
	input  logic   rst,
	input  logic   pb,
	output logic   pb_state,
	output logic   pb_negedge,
	output logic   pb_posedge
);

    enum logic [2:0] {PB_IDLE, PB_COUNT, PB_PE, PB_STABLE, PB_NE} button_state, button_state_next;    

	localparam COUNTER_MSB = COUNTER_WIDTH - 1;

	logic [COUNTER_MSB:0] pb_cnt, pb_cnt_next;

	logic [1:0] pb_sync_sr; /* Flip Flops para sincronizar. */
	logic pb_sync;
	assign pb_sync = pb_sync_sr[0];

	logic pb_cnt_max;
    assign pb_cnt_max = &pb_cnt;

	always_ff @(posedge clk)
		pb_sync_sr <= {pb, pb_sync_sr[1]};

	/* Etapa combinacional para el cambio de estado. */
	always_comb begin
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
	always_comb begin
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
	always_ff @(posedge clk)
		if (rst)
			button_state <= PB_IDLE;
		else
			button_state <= button_state_next;

	/* Registrando el contador. */
	always_ff @(posedge clk)
		if (rst)
			pb_cnt <= 'd0;
		else
			pb_cnt <= pb_cnt_next;

endmodule

