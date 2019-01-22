/*
 *
 */

`timescale 1ns / 1ps

module top_level
(
	input clk_100M,
	input reset_n,
	input [1:0] button, /* Left, right */
	output [7:0] ss_select,
	output [7:0] ss_value,
	output detected,
	output [2:0] leds
);
	/*
	 * Convertir la señal del botón reset_n a 'active HIGH'
	 * y sincronizar con el reloj.
	 */
	reg [1:0] reset_sr;
	wire reset = reset_sr[1];
	always @(posedge clk_100M)
		reset_sr <= {reset_sr[0], ~reset_n};

	/* Reloj para el display de 7 segmentos. */
	wire clk_ss;

	/* Salida del Double Dabble (número en formato BCD) */
	wire [31:0] bcd;

	/* Salida del detector */
	wire det_out;

	/* Pulsos de los botones */
	wire [1:0] button_posedge;

	/* Lógica para la entrada del detector */
	reg det_tick;
	reg det_in;
	always @(*) begin
		case (button_posedge)
		'b01: begin // Se presiona el botón derecho
			det_in = 1'b0;
			det_tick = 1'b1;
		end
		'b10: begin // Se presiona el botón izquierdo
			det_in = 1'b1;
			det_tick = 1'b1;
		end
		default: begin
			det_in = 1'b0;
			det_tick = 1'b0;
		end
		endcase
	end

	/*
	 * Lógica del contador
	 * Se incrementa cuando det_out pasa de 0 a 1, luego espera a que regrese a 0.
	 */
	localparam C_WAIT = 'b001;
	localparam C_ADD1 = 'b010;
	localparam C_HOLD = 'b100;
	reg [2:0] counter_state, counter_state_next;
	reg [31:0] counter, counter_next = 'd0;

	always @(*) begin
		counter_next = counter;
		counter_state_next = counter_state;

		case (counter_state)
		C_WAIT:
			if (det_out == 1'b1)
				counter_state_next = C_ADD1;
		C_ADD1: begin
			counter_next = counter + 'd1;
			counter_state_next = C_HOLD;
		end
		C_HOLD:
			if (det_out == 1'b0)
				counter_state_next = C_WAIT;
		default:
			counter_state_next = C_WAIT;
		endcase
	end

	always @(posedge clk_100M) begin
		if (reset) begin
			counter <= 'd0;
			counter_state <= C_WAIT;
		end else begin
			counter <= counter_next;
			counter_state <= counter_state_next;
		end
	end

	/*
	 * Salida del detector
	 */
	assign detected = det_out;

	/* Detector de secuencia: 1011, continua. */
	detector_secuencia det_inst (
		.clk(clk_100M),
		.reset(reset),
		.in(det_in),
		.tick(det_tick),
		.current_state(leds),
		.out(det_out)
	);

	/* Double Dabble */
	unsigned_to_bcd u32_to_bcd_inst (
		.clk(clk_100M),
		.trigger(1'b1), // Conversión continua
		.in(counter),
		.idle(), // Ignoramos estado del módulo
		.bcd(bcd)
	);

	/* Divisor de reloj, con frecuencia de salida de 480 [Hz] */
	clk_divider #(
		.O_CLK_FREQ(480)
	) clk_div_ss_display (
		.clk_in(clk_100M),
		.reset(1'b0),
		.clk_out(clk_ss)
	);

	/* Multiplexor para display de 7 segmentos. */
	ss_mux ss_mux_inst (
		.clk(clk_ss),
		.bcd(bcd),
		.dots(8'h00),
		.ss_value(ss_value),
		.ss_select(ss_select)
	);

	/* Debouncers */
	pb_debouncer #(
		.COUNTER_WIDTH(20)
	) pb_deb0 (
		.clk(clk_100M),
		.rst(reset),
		.pb(button[0]),
		.pb_state(),
		.pb_negedge(),
		.pb_posedge(button_posedge[0])
	);

	pb_debouncer #(
		.COUNTER_WIDTH(20)
	) pb_deb1 (
		.clk(clk_100M),
		.rst(reset),
		.pb(button[1]),
		.pb_state(),
		.pb_negedge(),
		.pb_posedge(button_posedge[1])
	);

endmodule