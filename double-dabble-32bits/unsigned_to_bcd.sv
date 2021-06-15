/*
 * unsigned_to_bcd.v
 * 2017/04/18 - Felipe Veas <felipe.veasv [at] usm.cl>
 * 2021/06/10 - Patricio Henriquez <patricio.henriqueze [at] sansano.usm.cl>
 *
 *
 * Este módulo es una implementación del algoritmo double dabble,
 * comienza a convertir un número en binario cuando recibe un pulso
 * en su entrada 'trigger'. La salida idle pasa a LOW si el módulo se
 * encuentra realizando una conversión.
 */

// -- Plantilla de instanciación
//	unsigned_to_bcd u32_to_bcd_inst (
//		.clk(clk),
//		.reset(reset)
//		.trigger(1'b1),
//		.in(in),
//		.idle(idle),
//		.bcd(bcd)
//	);

`timescale 1ns / 1ps

module unsigned_to_bcd
(
	input  logic 		clk, 	 // Reloj
				reset,   // Reset
	input  logic 		trigger, // Inicio de conversión
	input  logic [31:0] 	in,      // Número binario de entrada
	output logic  		idle,    // Si vale 0, indica una conversión en proceso
	output logic [31:0] 	bcd 	 // Resultado de la conversión
);

	/*
	 * Por "buenas prácticas" parametrizamos las constantes numéricas de los estados
	 * del módulo y evitamos trabajar con números "mágicos" en el resto del código.
	 *
	 * https://en.wikipedia.org/wiki/Magic_number_(programming)
	 * http://stackoverflow.com/questions/47882/what-is-a-magic-number-and-why-is-it-bad
	 */
	 
	 
	localparam COUNTER_MAX = 32;
	
	(* fsm_encoding = "one_hot" *) enum logic [2:0] {S_IDLE, S_SHIFT, S_ADD3} state, state_next;

	logic [31:0] shift, shift_next;
	logic [31:0] bcd_next;
	logic [5:0] counter, counter_next; /* Contador 6 bit para las iteraciones */

	always_comb begin
		/*
		 * Por defecto, los estados futuros mantienen el estado actual. Esto nos
		 * ayuda a no tener que ir definiendo cada uno de los valores de las señales
		 * en cada estado posible.
		 */
		
		{state_next, shift_next, bcd_next, counter_next} = {state, shift, bcd, counter};
		idle = 1'b0; /* LOW para todos los estados excepto S_IDLE */

		case (state)
		S_IDLE: begin
			counter_next = 'd1;
			shift_next = 'd0;
			idle = 1'b1;

			if (trigger) begin
				state_next = S_SHIFT;
			end
		end
		S_ADD3: begin
			/*
			 * Sumamos 3 a cada columna de 4 bits si el valor de esta es
			 * mayor o igual a 5
			 */
			if (shift[31:28] >= 5)
				shift_next[31:28] = shift[31:28] + 4'd3;

			if (shift[27:24] >= 5)
				shift_next[27:24] = shift[27:24] + 4'd3;

			if (shift[23:20] >= 5)
				shift_next[23:20] = shift[23:20] + 4'd3;

			if (shift[19:16] >= 5)
				shift_next[19:16] = shift[19:16] + 4'd3;

			if (shift[15:12] >= 5)
				shift_next[15:12] = shift[15:12] + 4'd3;

			if (shift[11:8] >= 5)
				shift_next[11:8] = shift[11:8] + 4'd3;

			if (shift[7:4] >= 5)
				shift_next[7:4] = shift[7:4] + 4'd3;

			if (shift[3:0] >= 5)
				shift_next[3:0] = shift[3:0] + 4'd3;

			state_next = S_SHIFT;
		end
		S_SHIFT: begin
			/* Desplazamos un bit de la entrada en el registro shift */
			shift_next = {shift[30:0], in[COUNTER_MAX - counter_next]};

			/*
			 * Si el contador actual alcanza la cuenta máxima, actualizamos la salida y
			 * terminamos el proceso.
			 */
			if (counter == COUNTER_MAX) begin
				bcd_next = shift_next;
				state_next = S_IDLE;
			end else
				state_next = S_ADD3;

			/* Incrementamos el contador (siguiente) en una unidad */
			counter_next = counter + 'd1;
		end
		default: begin
			state_next = S_IDLE;
		end
		endcase
	end

	always @(posedge clk) begin
		if(reset) begin
			{shift, bcd, counter} <= 'd0;
			state <= S_IDLE;
		end
		else
			{state, shift, bcd, counter} <= {state_next, shift_next, bcd_next, counter_next};
	end

endmodule
