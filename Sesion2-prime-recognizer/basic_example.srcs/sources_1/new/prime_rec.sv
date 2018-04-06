module prime_rec (
	input  logic [3:0] P,
	output logic       DP
	);

	always_comb begin
		if(P==4'd3 || P==4'd5 || P==4'd7 || P==4'd11 || P==4'd13)
				DP = 1;
    else
				DP = 0;
  end
endmodule