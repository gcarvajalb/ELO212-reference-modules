`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2018 07:05:14 PM
// Design Name: 
// Module Name: ME_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ME_top
(
	input  logic               clk_100M,
	input  logic               reset_n,

	input  logic               uart_rx,
	output logic               uart_tx,
	output logic               uart_tx_busy,
	output logic               uart_tx_usb,
	
	input  logic               button_c,
	input  logic    [15:0]     switches,
	output logic    [1:0]      leds,
	
	output  logic   [7:0]      ss_value,
    output  logic   [7:0]      ss_select
);
	/*
	 * Convertir la señal del botón reset_n a 'active HIGH'
	 * y sincronizar con el reloj.
	 */
	logic [7:0]    tx_data; 
	logic [7:0]    rx_data; 
	logic [15:0]   result16;
	logic [31:0]   bcd;
	
	logic [1:0]    reset_sr;
	logic reset;
	assign reset = reset_sr[1];
	
	always_ff @(posedge clk_100M)
		reset_sr <= {reset_sr[0], ~reset_n};

    assign uart_tx_usb = uart_tx;
    assign uart_rx = uart_rx;
    assign uart_tx = uart_tx;
    assign uart_tx_busy = tx_busy;
    //assign leds = result16;

	/* Debouncer */
	pb_debouncer #(
		.COUNTER_WIDTH(16)
	) pb_deb0 (
		.clk(clk_100M),
		.rst(reset),
		.pb(button_c),
		.pb_state(),
		.pb_negedge(),
		.pb_posedge(button_c_posedge)
	);

// Logica de control para transmitir las secuencias por la UART
UART_tx_control_wrapper 
#(  .INTER_BYTE_DELAY (100000),
    .WAIT_FOR_REGISTER_DELAY (100)
    
    ) UART_control_inst (
	.clock(clk_100M),
    .reset(reset),
    .PB(button_c_posedge),
    .SW(switches),
    .tx_data(tx_data),
    .tx_start(tx_start),
    .stateID (leds[1:0])
    );


	/* Módulo UART a 115200/8 bits datos/No paridad/1 bit stop */
	uart_basic #(
		.CLK_FREQUENCY(100000000), // reloj base de entrada
		.BAUD_RATE(115200)
	) uart_basic_inst (
		.clk(clk_100M),
		.reset(reset),
		.rx(uart_rx),
		.rx_data(rx_data),
		.rx_ready(rx_ready),
		.tx(uart_tx),
		.tx_start(tx_start),
		.tx_data(tx_data),
		.tx_busy(tx_busy)
	);

// Logica de control para recibir los bytes desde la UART
// Notar el uso de un registro de desplazamiento para armar un numero de 16 bits
// a partir de la recepcion de 2 bytes

    always_ff @(posedge clk_100M) begin
        if(reset)
            result16 <= 16'd0;
        else 
        if (rx_ready)
            result16 <= {rx_data, result16[15:8]};
    end
    
/////////////////////////////////
// Los modulos siguientes son solo para las tareas de display de los datos recibidos
// No afecta la UART
    unsigned_to_bcd u32_to_bcd_inst (
        .clk(clk_100M),
        .trigger(1'b1),
        .in({16'd0, result16}),
        .idle(),
        .bcd(bcd)
);

	logic clk_ss;
	clk_divider #(.O_CLK_FREQ(480)
	) clk_div_ss_display (
		.clk_in(clk_100M),
		.reset(1'b0),
		.clk_out(clk_ss)
);

	/* Multiplexor para display de 7 segmentos */
	display_mux display_mux_inst (
		.clk(clk_ss),
		.clk_enable(1'b1),
		.bcd(bcd),
		.dots(1'b0),
		.is_negative(1'b0),
		.turn_off(1'b0),
		.ss_value(ss_value),
		.ss_select(ss_select)
);

endmodule