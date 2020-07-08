// Module header:-----------------------------
module module_name
#(parameter
	param1 = < value > ,
	param2 = < value > )
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
 always_ff @(posedge clk) begin
	if 		(rst) pr_state < = A;
	else 	pr_state < = nx_state;
end
	
 //FSM combinational logic:
 always_comb begin
	case (pr_state)
		A:
			if (condition) begin
				outp1  = <value> ;
				outp2  = <value> ;
				...
				nx_state  = B;
			end
			else if (condition) begin
				outp1  = <value> ;
				outp2  = <value> ;
				...
				nx_state  = ...;
			end
			else begin
				outp1  = <value> ;
				outp2  = <value> ;
				...
				nx_state = A;
			end
 
		B:
			if (condition) begin
				outp1 = <value> ;
				outp2 = <value> ;
				...
				nx_state = C;
			end
			else if (condition) begin
				outp1 = <value> ;
				outp2 = <value> ;
				...
				nx_state = ...;
			end
			else begin
				outp1 = <value> ;
				outp2 = <value> ;
				...
				nx_state = B;
			end
		C: 	...
			...
	endcase
end

 //Optional registered outputs (if required). It simply delays the outputs to prevent propagation of glitches
	always_ff @(posedge clk) begin
		if (rst) begin //rst might be not needed here
			new_outp1 <= ...;
			new_outp2 <= ...; ...
		end
		else begin
			new_outp1 <= outp1;
			new_outp2 <= outp2; ...
		end
end

 endmodule