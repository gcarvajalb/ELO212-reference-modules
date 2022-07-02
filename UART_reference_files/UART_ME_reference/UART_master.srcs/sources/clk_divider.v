/*
 * clk_divider.v
 * 2017/04/17 - Felipe Veas <felipe.veasv [at] usm.cl>
 *
 * Divisor de reloj basado en un contador para una frecuencia de entrada
 * de 100 [MHz]
 *
 * Recibe como par�metro opcional la frecuencia de salida que debe entregar.
 *
 * Valores por defecto:
 *     O_CLK_FREQ:   1  [Hz] (reloj de salida)
 *
 * Rango de operaci�n:
 *     1 <= clk_out <= 50_000_000 [Hz]
 */

`timescale 1ns / 1ps

module clk_divider
#(
	parameter O_CLK_FREQ = 1
)(
	input clk_in,
	input reset,
	output reg clk_out
);

	/*
	 * Calculamos el valor m�ximo que nuestro contador debe alcanzar en funci�n
	 * de O_CLK_FREQ
	 */
	localparam COUNTER_MAX = 'd100_000_000/(2 * O_CLK_FREQ) - 1;

	reg [26:0] counter = 'd0;

	/*
	 * Bloque procedural que resetea el contador e invierte el valor del reloj de salida
	 * cada vez que el contador llega a su valor m�ximo.
	 */
	always @(posedge clk_in) begin
		if (reset == 1'b1) begin
			// Se�al reset sincr�nico, setea el contador y la salida a un valor conocido
			counter <= 'd0;
			clk_out <= 0;
		end else if (counter == COUNTER_MAX) begin
			// Se resetea el contador y se invierte la salida
			counter <= 'd0;
			clk_out <= ~clk_out;
		end else begin
			// Se incrementa el contador y se mantiene la salida con su valor anterior
			counter <= counter + 'd1;
			clk_out <= clk_out;
		end
	end

endmodule