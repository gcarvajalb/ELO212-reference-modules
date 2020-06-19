module PB_Debouncer_FSM #(
    parameter DELAY=15                 // Number of clock pulses to check stable button pressing
    )
(
	input 	logic clk,                 // base clock
	input 	logic rst,                 // global reset
	input 	logic PB,                  // raw asynchronous input from mechanical PB         
	output 	logic PB_pressed_status,   // clean and synchronized pulse for button pressed
	output  logic PB_pressed_pulse,    // high if button is pressed
	output  logic PB_released_pulse    // clean and synchronized pulse for button released
 );

	logic    PB_sync_aux, PB_sync;

// Double flopping stage for synchronizing asynchronous PB input signal
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
/////////////// FSM Description
	
	localparam DELAY_WIDTH = $clog2(DELAY);
	
	logic [DELAY_WIDTH-1:0]    delay_timer; 
    
    enum logic[5:0] {PB_IDLE, PB_COUNT, PB_PRESSED, PB_STABLE, PB_RELEASED} state, next_state;

 //Timer keeps track of how many cycles the FSM remains in a given state
 //Automatically resets the counter "delay_timer" when changing state
  always_ff @(posedge clk) begin
	if (rst) delay_timer <= 0;
	else if (state != next_state) delay_timer <= 0; //reset the timer when state changes
	else delay_timer <= delay_timer + 1;
  end


    // Combinational logic for FSM
    // Calcula hacia donde me debo mover en el siguiente ciclo de reloj basado en las entradas
    always_comb begin
        //default assignments
        next_state          = PB_IDLE;
        PB_pressed_status   = 1'b0;
        PB_pressed_pulse    = 1'b0;
        PB_released_pulse   = 1'b0;
                
        case (state)
            PB_IDLE:        begin
                                if(PB_sync) begin   // si se inicia una operacion, empieza lectura de datos
                                    next_state= PB_COUNT;
                                end
                            end

            PB_COUNT:       begin
                                // Verifica si el timer alcanzo el valor predeterminado para este estado
                                if ((PB_sync && (delay_timer >= DELAY-1))) begin
                                    next_state = PB_PRESSED;
                                end 
                                else if (PB_sync)
                                    next_state = PB_COUNT;
                            end
                         
             PB_PRESSED:    begin
                                PB_pressed_pulse = 1'b1;
                                if (PB_sync)
                                    next_state = PB_STABLE;
                            end
             
             PB_STABLE:     begin
                                PB_pressed_status=1'b1;
                                next_state = PB_STABLE;
                         
                                if (~PB_sync)
                                    next_state = PB_RELEASED;
                            end

              PB_RELEASED:  begin
                                PB_released_pulse = 1'b1;
                                next_state = PB_IDLE;
                            end    
         endcase
    end    

    // sequential block for FSM. When clock ticks, update the state
    always@(posedge clk) begin
        if(rst) 
            state <= PB_IDLE;
        else 
            state <= next_state;
    end
    
endmodule