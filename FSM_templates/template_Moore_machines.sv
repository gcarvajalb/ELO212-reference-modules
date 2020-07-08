// Module header:-----------------------------
module module_name
#(parameter
	param1 = <value> ,
	param2 = <value> )
(
	input 	logic clk, rst, ...
	input 	logic [7:0] inp1, inp2, ...
	output 	logic [15:0] outp1, outp2, ...);

 //Declarations:------------------------------

 //FSM states type:
 typedef enum logic [10:0] {A, B, C, ...} state;
 state pr_state, nx_state;

 //Statements:--------------------------------

 //FSM state register:
 always_ff @(posedge clk)
	if (rst) pr_state < = A;
	else pr_state < = nx_state;

 //FSM combinational logic:
 always_comb
	case (pr_state)
		A: begin
			outp1 = <value> ;
			outp2 = <value> ;
			...
			if (condition) nx_state = B;
			else if (condition) nx_state = ...;
			else nx_state = A;
		end
 
		B: begin
			outp1 = <value> ;
			outp2 = <value> ;
			...
			if (condition) nx_state = C;
			else if (condition) nx_state = ...;
			else nx_state = B;
		end
 
		C: begin
			...
			end
			...
	endcase

 //Optional output register (if required). It simply delays the combinational outputs to prevent propagation of glitches.
	always_ff @(posedge clk)
		if (rst) begin //rst might be not needed here
			new_outp1 <= ...;
			new_outp2 <= ...; ...
		end
		else begin
			new_outp1 <= outp1;
			new_outp2 <= outp2; ...
		end

 endmodule