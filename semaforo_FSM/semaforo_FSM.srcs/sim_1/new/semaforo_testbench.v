`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// testbenches requires a module without inputs or outputs
// It's only a "virtual" module. We cannot implement hardware with this!!!
module testbench();
  
    // We need to give values at the inputs, so we define them as registers  
	reg clock;
	reg reset;
	reg TA, TB;
	
	//The outputs are wires. We don't connect them to anything, but we need to 
	// declare them to visualize them in the output timing diagram
	wire [1:0] LA, LB;
	
	// an instance of the Device Under Test
	semaforo_FSM DUT(
        .clock (clock),
        .reset (reset),
        .TA (TA),
        .TB (TB),
        .LA (LA),
        .LB (LB)
        );
            
	// generate a clock signal that inverts its value every five time units
	always  #25 clock=~clock;
	
	//here we assign values to the inputs
	initial begin
		clock = 1'b0;
		reset = 1'b0;
		TA = 1'b1;
		TB = 1'b0;
		#40 TB = 1'b1;
		#60 reset = 1'b1;
		#10 reset = 1'b0;
		
		
		#38 TA = 1'b0;
		    
		
		#206 TB = 1'b0;
		#302 TA = 1'b1;
		#40 TB = 1'b1;
	end

endmodule
