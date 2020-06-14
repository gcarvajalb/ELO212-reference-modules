// ALU de referencia.  Descrita por Oscar Rojas.

module ALU_ref #(parameter C_WIDTH = 8)
(
	input logic [C_WIDTH-1:0] A,
	input logic [C_WIDTH-1:0] B,
	input logic [1:0] OpCode,

	output logic [C_WIDTH-1:0] Result,
	output logic [3:0] Status
);
	logic N, Z, C, V; // ALU Flags

	always_comb begin
		case(OpCode)
			2'd0: begin
			    /* El operador {} se usa para concatenar bits que pueden venir de distintos buses.
			       Notar que se esta guardando el resultado de la suma en un elemento que tiene un bit mas de ancho que los operandos,
			       lo cual forzara a la herramienta a que extienda en un bit el ancho de los operandos, como si fuera un sumador de 9 bits.
			       Es importante notar que el bit extra se usa para el carry flag y no es parte del resultado de la operacion. 
			       Hay varias formas de describir esta operacion. Con practica iran aprendiendo trucos.
			    */ 
				{C, Result} = A + B; 
				V = (Result[C_WIDTH-1] & ~A[C_WIDTH-1] & ~B[C_WIDTH-1]) | (~Result[C_WIDTH-1] & A[C_WIDTH-1] & B[C_WIDTH-1]);
			    // Hay overflow si el resultado es positivo y los operandos son negativos, o si el resultado es positivo y los operandos son negativos
			end

			2'd1: begin
				{C, Result} = A - B;
				V = (Result[C_WIDTH-1] & ~A[C_WIDTH-1] & B[C_WIDTH-1]) | (~Result[C_WIDTH-1] & A[C_WIDTH-1] & ~B[C_WIDTH-1]);
			   // Hay overflow si A es negativo, B es positivo, y Result es positivo; o bien si A es positivo, B es negativo, y Result es negativo.
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

		N = Result[C_WIDTH-1]; // el flag N cablea directo al MSB de Result
		Z = (Result == '0);    // revisa si el resultado es 0

		// se usa la concatenacion para agrupar bits independiente en un bus.
		Status = {N, Z, C, V};
	end
endmodule