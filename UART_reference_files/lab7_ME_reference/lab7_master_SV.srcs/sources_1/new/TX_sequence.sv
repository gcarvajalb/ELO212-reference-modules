`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2018 07:25:45 PM
// Design Name: 
// Module Name: TX_sequence
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


module TX_sequence 
(
	input  logic           clock,
	input  logic           reset,
	input  logic           PB,       //PushButton
	output logic           send16,   // Si esta alto, se deben transmitir 16 bits (2 bytes)
	input  logic           busy,     // Si esta alto, la UART se encuentra transmitiendo un dato
	output logic [1:0]     stateID   // Indica en que estado de la secuencia esta para mostrarlo en los LEDs
    );
    
    //reg[1:0] next_state, state; 

enum logic [1:0] {IDLE, TX_OPERAND01, TX_OPERAND02, TX_ALU_CTRL} next_state, state;  
    //state encoding

    assign stateID = state;
    
    // combo logic of FSM
    always_comb begin
        //default assignments
        next_state = state;
        send16 = 1'b1;
    	
    	case (state)
    		IDLE: 	begin
						if(PB & ~busy) begin
							next_state=TX_OPERAND01;
						end
					end

            TX_OPERAND01: begin
							if(PB & ~busy) begin
								next_state=TX_OPERAND02;
							end								
						end
						
            TX_OPERAND02: begin
							if(PB & ~busy) begin
								next_state=TX_ALU_CTRL;
							end								
						end

            TX_ALU_CTRL: begin
                            send16 = 1'b0;
                            if(~busy) begin
                                next_state=IDLE;
                            end
						end	
    	endcase
    end	

    //when clock ticks, update the state
    always_ff @(posedge clock) begin
    	if(reset)
    		state <= IDLE;
    	else
    		state <= next_state;
	end
	
endmodule
