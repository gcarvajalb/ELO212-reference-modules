module PB_Debouncer_FSM#(
    parameter DELAY=15,                     // Number of clock pulses to check stable button pressing
    parameter DELAY_WIDTH = $clog2(DELAY)   // Determine the size of the clock cycles counter
    )
(
	input 	logic clk,                  // base clock
	input 	logic rst,                  // global reset
	input 	logic PB,                   // raw asynchronous input from mechanical PB         
	output 	logic PB_pressed_status,    // clean and synchronized pulse for button pressed
	output  logic PB_pressed_pulse,    // high if button is pressed
	output  logic PB_released_pulse    // clean and synchronized pulse for button released
 );
	
	logic PB_sync_aux, PB_sync;

// Double flopping stage for synchronizing async. PB input signal
// PB_sync is the synchronized signal
 always_ff @(posedge clk) begin
     if (rst) begin
         PB_sync_aux <= 1'b0;
         PB_sync     <= 1'b0;
     end
     else begin
         PB_sync_aux <= PB;
         PB_sync     <= PB_sync_aux;
     end
 end
/////////////////
    
    enum logic[2:0] {PB_IDLE, PB_COUNT, PB_PRESSED, PB_STABLE, PB_RELEASED} state, state_next;
    
    logic [DELAY_WIDTH-1:0]     hold_state_delay;  //timer para retener la maquina de estados en un estado
    logic                       hold_state_reset;  //resetear el timer para retener estado
  
    // Combinational logic for FSM
    // Calcula hacia donde me debo mover en el siguiente ciclo de reloj basado en las entradas
    always_comb begin
        //default assignments
        state_next          = PB_IDLE;
        PB_pressed_status   = 1'b0;
        PB_pressed_pulse    = 1'b0;
        PB_released_pulse   = 1'b0;
        hold_state_reset    = 1'b1;
                
        case (state)
            PB_IDLE:        begin
                                if(PB_sync) begin   // si se inicia una operacion, empieza lectura de datos
                                    state_next= PB_COUNT;
                                end
                            end

            PB_COUNT:       begin
                                hold_state_reset = 1'b0;
                                // Verifica si el timer alcanzo el valor predeterminado para este estado
                                if ((PB_sync && (hold_state_delay >= DELAY-1))) begin
                                    state_next = PB_PRESSED;
                                    hold_state_reset = 1'b1;
                                end 
                                else if (PB_sync)
                                    state_next = PB_COUNT;
                            end
                         
             PB_PRESSED:    begin
                                PB_pressed_pulse = 1'b1;
                                if (PB_sync)
                                    state_next = PB_STABLE;
                            end
             
             PB_STABLE:     begin
                                PB_pressed_status=1'b1;
                                state_next = PB_STABLE;
                         
                                if (~PB_sync)
                                    state_next = PB_RELEASED;
                            end

              PB_RELEASED:  begin
                                PB_released_pulse = 1'b1;
                                state_next = PB_IDLE;
                            end    
 
        endcase
    end    

    // sequential block for FSM. When clock ticks, update the state
    always@(posedge clk) begin
        if(rst) 
            state <= PB_IDLE;
        else 
            state <= state_next;
    end
    
    
    always_ff @(posedge clk) begin
       if (rst || hold_state_reset) 
           hold_state_delay <= 8'd0;
       else
           hold_state_delay <= hold_state_delay + 8'd1;       
    end

endmodule