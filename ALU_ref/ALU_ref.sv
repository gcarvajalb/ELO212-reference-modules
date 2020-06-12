module tb_alu_ref #(parameter C_WIDTH = 8)
(
	input logic [C_WIDTH-1:0] A,
	input logic [C_WIDTH-1:0] B,
	input logic [1:0] OpCode,

	output logic [C_WIDTH-1:0] Result,
	output logic [3:0] Status
);
	logic N, Z, C, V;

	always_comb begin
		case(OpCode)
			2'd0: begin
				{C, Result} = A + B;
				V = (Result[C_WIDTH-1] & ~A[C_WIDTH-1] & ~B[C_WIDTH-1]) | (~Result[C_WIDTH-1] & A[C_WIDTH-1] & B[C_WIDTH-1]);
			end

			2'd1: begin
				{C, Result} = A - B;
				V = (Result[C_WIDTH-1] & ~A[C_WIDTH-1] & B[C_WIDTH-1]) | (~Result[C_WIDTH-1] & A[C_WIDTH-1] & ~B[C_WIDTH-1]);
			end

			2'd2: begin
				Result = A | B;
				C = 1'b0;
				V = 1'b0;
			end

			2'd3: begin
				Result = A & B;
				C = 1'b0;
				V = 1'b0;
			end
		endcase

		N = Result[C_WIDTH-1];
		Z = (Result == '0);

		Status = {N, Z, C, V};
	end
endmodule