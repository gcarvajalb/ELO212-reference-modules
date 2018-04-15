`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/01/2017 12:03:08 AM
// Design Name: 
// Module Name: debouncer
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


module debouncer(

    );
endmodule


module PushButton_Debouncer(
	input clk,
	input PB,  // "PB" is the glitchy, asynchronous to clk, active low push-button signal
	
	// from which we make three outputs, all synchronous to the clock
	output reg PB_state,  // 1 as long as the push-button is active (down)
	output PB_down,  // 1 for one clock cycle when the push-button goes down (i.e. just pushed)
	output PB_up   // 1 for one clock cycle when the push-button goes up (i.e. just released)
);
	
	// First use two flip-flops to synchronize the PB signal the "clk" clock domain
	reg PB_sync_0, PB_sync_1;  

always @(posedge clk) 
    PB_sync_0 <= ~PB;  // invert PB to make PB_sync_0 active high

always @(posedge clk) 
    PB_sync_1 <= PB_sync_0;

// Next declare a 16-bits counter
reg [15:0] PB_cnt;

// When the push-button is pushed or released, we increment the counter
// The counter has to be maxed out before we decide that the push-button state has changed

wire PB_idle = (PB_state==PB_sync_1);
wire PB_cnt_max = &PB_cnt;	// true when all bits of PB_cnt are 1's

always @(posedge clk)
if(PB_idle)
    PB_cnt <= 0;  // nothing's going on
else begin
    PB_cnt <= PB_cnt + 16'd1;  // something's going on, increment the counter
    if(PB_cnt_max) PB_state <= ~PB_state;  // if the counter is maxed out, PB changed!
end

assign PB_down = ~PB_idle & PB_cnt_max & ~PB_state;
assign PB_up   = ~PB_idle & PB_cnt_max &  PB_state;

endmodule



module PushButton_Debouncer2(
	input clk,
	input rst,
	input PB,
	output reg PB_state,
	output reg PB_negedge,
	output reg PB_posedge);
	
	parameter N = 15;
	parameter n = N-1;
	reg PB_state_next;
	reg PB_negedge_next;
	reg PB_posedge_next;
	
	reg [1:0]PB_sync;		//Flip Flops para sincronizar.
	reg [1:0]PB_sync_next;	//Etapa combinacional
	
	reg [1:0] button_state, button_state_next;
	
	reg [n:0]PB_cnt, PB_cnt_next;
	
	wire PB_cnt_max = &PB_cnt;	//se hace el AND de todos los bits, es lo mismo que poner
								// PB_cnt_mac = (PB_cnt == 16'hFFFF)
	
/////////////////////////   sincronizando la entrada con un reloj.   //////////////////
	always@(*)
		{PB_sync_next} = {PB_sync[0], PB};
	
	always@(posedge clk or posedge rst)
		if(rst)
			PB_sync <= 2'b00;
		else
			PB_sync <= PB_sync_next;
///////////////////////////////////////////////////////////////////////////////////////
///   Desde aca en adelante se debera utilizar PB_sync[1] como si fuera el boton.  ////
	
	localparam  PB_IDLE = 2'b01,
				PB_COUNT = 2'b10,
				PB_STABLE = 2'b11;
	
	/////// Etapa combinacional para el cambio de estado //////////
	always@(*)
	begin
		button_state_next = PB_IDLE;//default value
		case (button_state)
			PB_IDLE:	if(PB_sync[1] == 1'b1)
							button_state_next = PB_COUNT;
						else
							button_state_next = PB_IDLE;
							
			PB_COUNT:	if(PB_cnt_max == 1'b1)
							button_state_next = PB_STABLE;
						else if(PB_sync[1] == 1'b0)
							button_state_next = PB_IDLE;
						else
							button_state_next = PB_COUNT;
							
			PB_STABLE:	if(PB_sync[1] == 1'b0)
							button_state_next = PB_IDLE;
						else
							button_state_next = PB_STABLE;
		endcase
	end
	
	//Etapa combinacional de las Salidas y Contador. 
	always@(*)
	begin
		PB_state_next = (button_state_next == PB_STABLE);
		PB_negedge_next = ((button_state == PB_STABLE) &&(button_state_next == PB_IDLE));
		PB_posedge_next = ((button_state == PB_COUNT) &&(button_state_next == PB_STABLE));
		PB_cnt_next = (button_state == PB_COUNT)?PB_cnt +1'b1:{N{1'b0}};
	end
	
	//registrando el estado
	always@(posedge clk or posedge rst)
		if(rst)
			button_state <= PB_IDLE;
		else
			button_state <= button_state_next;
	
	//registrando las salidas
	always@(posedge clk or posedge rst)
		if(rst)
		begin
			PB_state <= 1'b0;
			PB_negedge <= 1'b0;
			PB_posedge <= 1'b0;
			PB_cnt <= {N{1'd0}};
		end
		else
		begin
			PB_state <= PB_state_next;
			PB_negedge <= PB_negedge_next;
			PB_posedge <= PB_posedge_next;
			PB_cnt <= PB_cnt_next;
		end
	
endmodule