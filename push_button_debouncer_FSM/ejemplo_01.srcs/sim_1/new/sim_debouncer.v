`timescale 1ns / 1ps

module sim_debouncer();

	reg clock;
	reg reset;
	reg data_in;
	
	wire sequence_detected;
	
	sequence_detector uut(
        .clock (clock),
        .reset (reset),
        .data_in (data_in),
        .sequence_detected (sequence_detected)
        );
	
	always  #5 clock=~clock;
	
	initial begin
		clock = 1'b0;
		reset = 1'b1;
		data_in = 1'b1;
		#100;
		
		reset = 1'b0;
		#30 data_in = 1'b0;
		
		#200 data_in = 1'b1;
		
	end

endmodule