`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module testbench();

    //parameter N = 4;
	reg clock;
	reg reset;
	reg PB;
	
    wire PB_pressed_state, PB_pressed_pulse, PB_released_pulse;
	
	PushButton_Debouncer DUT (
        .clk (clock),
        .rst (reset),
        .PB (PB),
        .PB_state (PB_pressed_state),
        .PB_pressed_pulse (PB_pressed_pulse),
        .PB_released_pulse (PB_released_pulse)
        );
 
            
	always  #5 clock=~clock;
	
	initial begin
		clock = 1'b0;
		reset = 1'b0;
		PB = 1'b0;
		#100;
		
		#1 reset = 1'b1;
		#10 reset = 1'b0;
		
		#30 PB = 1'b1;
		#70 PB = 1'b0;
		
		#30 PB = 1'b1;
		#500 PB = 1'b0;
	
	end

endmodule
