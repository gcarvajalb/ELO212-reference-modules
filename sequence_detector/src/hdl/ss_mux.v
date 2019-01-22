/*
 * ss_mux.v
 * 2017/04/17 - Felipe Veas <felipe.veasv [at] usm.cl>
 *
 * Multiplexor para un display de 8x7 segmentos
 */

`timescale 1ns / 1ps

module ss_mux
(
	input clk,
	input [31:0] bcd,
	input [7:0] dots,
	output [7:0] ss_value,
	output [7:0] ss_select
);
	/*
	 * Los siguientes parámetros locales representan el "estado" de nuestro módulo,
	 * en el cual cada uno de ellos está asociado a la activación de un solo dígito
	 * del display. Nótese que convenientemente están representados con una codificación
	 * "one-hot", pues se usarán como salida en la señal ss_select.
	 */
	localparam DIG_0 = 8'b00000001;
	localparam DIG_1 = 8'b00000010;
	localparam DIG_2 = 8'b00000100;
	localparam DIG_3 = 8'b00001000;
	localparam DIG_4 = 8'b00010000;
	localparam DIG_5 = 8'b00100000;
	localparam DIG_6 = 8'b01000000;
	localparam DIG_7 = 8'b10000000;

	reg [7:0] ss_select_q; // Contiene el estado actual
	reg [7:0] ss_select_d; // Contiene el estado siguiente

	/* dot_enable nos indica si hay que encender el LED del punto (DP) según el estado actual */
	wire dot_enable;
	assign dot_enable = |(ss_select_q & dots);

	/*
	 * Instanciamos el conversor de BCD a 7 segmentos
	 */
	reg [3:0] bcd_nibble;
	wire [6:0] ss_digits;

	bcd_to_ss to_ss (
		.bcd_in(bcd_nibble),
		.out(ss_digits)
	);

	/* Salidas del módulo, en lógica inversa (active LOW) */
	assign ss_value = {~dot_enable, ss_digits};
	assign ss_select = ~ss_select_q;

	/*
	 * En el siguiente bloque combinacional, asignamos el estado siguiente (ss_select_d)
	 * y el valor a mostrar, según el estado actual (ss_select_q)
	 */
	always @(*) begin
		case (ss_select_q)
		DIG_0: begin
			// En este caso (DIG_0) haremos que el conversor a 7 segmentos tome y
			// muestre el primer dígito (bcd[3:0]) en el display, y luego defina el
			// estado siguiente (DIG_1)
			bcd_nibble = bcd[3:0];
			ss_select_d = DIG_1;
		end
		DIG_1: begin
			bcd_nibble = bcd[7:4];
			ss_select_d = DIG_2;
		end
		DIG_2: begin
			bcd_nibble = bcd[11:8];
			ss_select_d = DIG_3;
		end
		DIG_3: begin
			bcd_nibble = bcd[15:12];
			ss_select_d = DIG_4;
		end
		DIG_4: begin
			bcd_nibble = bcd[19:16];
			ss_select_d = DIG_5;
		end
		DIG_5: begin
			bcd_nibble = bcd[23:20];
			ss_select_d = DIG_6;
		end
		DIG_6: begin
			bcd_nibble = bcd[27:24];
			ss_select_d = DIG_7;
		end
		DIG_7: begin
			// En este caso (DIG_7), se muestra el último dígito (de más a la izquierda) y
			// para el estado siguiente comience nuevamente a mostrar primer dígito (DIG_0)
			bcd_nibble = bcd[31:28];
			ss_select_d = DIG_0;
		end
		default: begin
			// Por razones de buenas prácticas se tiene un estado por defecto, pese a que
			// aparentemente "no debería" ocurrir en este diseño :)
			bcd_nibble = bcd[31:28];
			ss_select_d = DIG_0;
		end
		endcase
	end

	/* Actualizamos al estado siguiente si la señal clk_enable está en alto */
	always @(posedge clk)
		ss_select_q <= ss_select_d;

endmodule
