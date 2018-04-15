`timescale 1ns / 1ps

// El parametro indica el numero de bits en el contador.
// Hay que elegir un valor adecuado de manera que el tiempo de espera para que el 
// boton se estabilice sea de un par de milisegundos.
module PB_debouncer #(parameter N = 4) 
(
    input clock,
	input reset,
	input PB,
	output reg PB_pressed_state,
	output reg PB_pressed_pulse,
	output reg PB_released_pulse
	);
	
	reg [1:0]PB_sync;		//Flip Flops para sincronizar.
	reg [1:0]PB_sync_next;	//Etapa combinacional
	
	reg [2:0] button_state, button_state_next;
	
	reg [N-1:0]PB_cnt, PB_cnt_next;
	
	wire PB_cnt_max = &PB_cnt;	//se hace el AND de todos los bits, es lo mismo que poner
								// PB_cnt_mac = (PB_cnt == 16'hFFFF)
	
/////////////////////////  Etapa de sincronizacion del pulso de boton con un reloj //////
// Asumir que funciona. No es necesario entenderla en detalle. La senal que se usa como entrada
// para la maquina de estado es PB_sync[1].
	always@(*)
		{PB_sync_next} = {PB_sync[0], PB};
	
	always@(posedge clock or posedge reset)
		if(reset)
			PB_sync <= 2'b00;
		else
			PB_sync <= PB_sync_next;
			
///////////////////////////////////////////////////////////////////////////////////////
///   Desde aca en adelante se debera utilizar PB_sync[1] como si fuera el boton.  ////
	
	localparam  PB_IDLE 	= 3'b001,
				PB_COUNT	= 3'b010,
				PB_PE		= 3'b011,
				PB_STABLE	= 3'b100,
				PB_NE		= 3'b101;
	
	/////// Etapa combinacional para el cambio de estado //////////
	always@(*)
	begin
		button_state_next = PB_IDLE;//default value
		case (button_state)
			PB_IDLE:	button_state_next = (PB_sync[1] == 1'b1)?PB_COUNT:PB_IDLE;
							
			PB_COUNT:	button_state_next = (PB_sync[1] == 1'b0)?PB_IDLE:
											(PB_cnt_max == 1'b1)?PB_PE:PB_COUNT;
											
			PB_PE:		button_state_next = PB_STABLE;
							
			PB_STABLE:	button_state_next = (PB_sync[1] == 1'b0)?PB_NE:PB_STABLE;
			
			PB_NE:		button_state_next = PB_IDLE;
			
		endcase
	end
	
	//Etapa combinacional de las Salidas y Contador. 
	always@(*)
	begin
		PB_pressed_state = ((button_state == PB_STABLE) || (button_state == PB_PE));
		PB_released_pulse = (button_state == PB_NE);
		PB_pressed_pulse= (button_state == PB_PE);
		PB_cnt_next = (button_state == PB_COUNT)?PB_cnt +1'b1:{N{1'b0}};
	end
	
	// Esta es una variante que utiliza un always block por cada salida
	// notar que las salidas estan registradas.
	// Esto es util para el boton, pero no estrictamente necesario para sus
	// disenos.
	
	//registrando el estado
	always@(posedge clock or posedge reset)
		if(reset)
			button_state <= PB_IDLE;
		else
			button_state <= button_state_next;
	
	//registrando el contador
	always@(posedge clock or posedge reset)
		if(reset)
			PB_cnt <= {N{1'd0}};
		else
			PB_cnt <= PB_cnt_next;
	
endmodule