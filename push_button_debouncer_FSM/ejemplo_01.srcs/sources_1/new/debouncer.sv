module PushButton_Debouncer#(
 parameter N=15;)
(
	input 	logic clk,
	input 	logic rst,
	input 	logic PB,
	output 	logic PB_state,
	output  logic PB_negedge,
	output  logic PB_posedge);
	
	logic PB_state_next;
	logic PB_negedge_next;
	logic PB_posedge_next;
	
	logic [1:0]PB_sync;		//Flip Flops para sincronizar.
	logic [1:0]PB_sync_next;	//Etapa combinacional
	
	logic [1:0] button_state, button_state_next;
	logic [N-1:0]PB_cnt, PB_cnt_next;
	
	logic PB_cnt_max;
	
	assign PB_cnt_max = &PB_cnt;	//se hace el AND de todos los bits, es lo mismo que poner
									// PB_cnt_mac = (PB_cnt == 16'hFFFF)
	
	/////////////////////////   sincronizando la entrada con un reloj.   //////////////////
	always_comb
		{PB_sync_next} = {PB_sync[0], PB};
	
	always_ff@(posedge clk)
		if(rst)
			PB_sync <= 2'b00;
		else
			PB_sync <= PB_sync_next;
///////////////////////////////////////////////////////////////////////////////////////
///   Desde aca en adelante se debera utilizar PB_sync[1] como si fuera el boton.  ////
	
	enum logic[1:0] {PB_IDLE, PB_COUNT, PB_STABLE};
	
	/////// Etapa combinacional para el cambio de estado //////////
	always_comb
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
	always_comb
	begin
		PB_state_next = (button_state_next == PB_STABLE);
		PB_negedge_next = ((button_state == PB_STABLE) &&(button_state_next == PB_IDLE));
		PB_posedge_next = ((button_state == PB_COUNT) &&(button_state_next == PB_STABLE));
		PB_cnt_next = (button_state == PB_COUNT)?PB_cnt +1'b1:{N{1'b0}};
	end
	
	//registrando el estado
	always_ff @(posedge clk)
		if(rst)
			button_state <= PB_IDLE;
		else
			button_state <= button_state_next;
	
	//registrando las salidas
	always_ff @(posedge clk)
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