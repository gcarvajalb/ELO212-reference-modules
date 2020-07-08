//Implementation of the traffic light example from Chapter 3 of the book
// Digital Design and Computer Architecture, Harris & Harris

module semaforo_FSM(
	input  logic       clock,
	input  logic       reset, TA, TB,
	output logic [1:0] LA, LB
    );
    
    enum logic[3:0] {STATE_0, STATE_1, STATE_2, STATE_3} state, next_state;
    
    //output encoding
    localparam GREEN    = 2'b00;
    localparam YELLOW   = 2'b01;
    localparam RED      = 2'b10;
    
    // one combinational block computes the next_state and outputs for the
    // current state
    always_comb begin
        //using default assignments here allows us to save space, helps on readability,
        //and reduces the chance of unintentional errors
        next_state = state;
    	LA = RED;
    	LB = RED;
    	
    	case (state)
    		STATE_0: begin
    			     LA = GREEN;
    			     if(TA == 1'b0) begin
    			 	   next_state = STATE_1;
    		         end
    		    end

            STATE_1: begin
                    LA = YELLOW;
                    next_state = STATE_2;
                end
            
            STATE_2: begin
                    LB = GREEN;
                    if(TB == 1'b0) begin
                        next_state = STATE_3;
                    end
                end

            STATE_3: begin
                    LB = YELLOW;
                    next_state = STATE_0;
                end                
    	endcase
    end	

    //when clock ticks, update the state
    always_ff@(posedge clock)
    	if(reset)
    		state <= STATE_0;
    	else
    		state <= next_state;
endmodule
