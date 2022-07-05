/*
 * uart_basic.v
 * 2017/02/01 - Felipe Veas <felipe.veasv at usm.cl>
 * 2022/07/04 - Mauricio Solis: Add some comments abd headers.
 * @brief
 * Universal Asynchronous Receiver/Transmitter.
 * 
 * This mudule implements a full duplex UART. 
 *
 * @param clk         The FPGA clock
 * @param reset       The reset
 * @param rx          The reception signal
 * @param rx_data     The reception data
 * @param rx_ready    To advice when a new rx data is available
 * @param tx          The tx signal
 * @param tx_start    To start the rx data transmission
 * @param tx_data     The data to transmit
 * @param tx_busy     To advice the uart is or not sending data.
 */

`timescale 1ns / 1ps

module uart_basic
#(
	parameter CLK_FREQUENCY = 100_000_000,
	parameter BAUD_RATE = 115_200
)(
	input clk,
	input reset,
	input rx,
	output [7:0] rx_data,
	output reg rx_ready,
	output tx,
	input tx_start,
	input [7:0] tx_data,
	output tx_busy
);

	wire baud8_tick;
	wire baud_tick;

	reg rx_ready_sync;
	wire rx_ready_pre;

  /*This instance is used to generate the RX tick clock with 8 oversampling*/
	uart_baud_tick_gen #(
		.CLK_FREQUENCY(CLK_FREQUENCY),
		.BAUD_RATE(BAUD_RATE),
		.OVERSAMPLING(8)
	) baud8_tick_blk (
		.clk(clk),
		.enable(1'b1),
		.tick(baud8_tick)
	);

  /*This instance implements the uart reception*/
	uart_rx uart_rx_blk (
		.clk(clk),
		.reset(reset),
		.baud8_tick(baud8_tick),
		.rx(rx),
		.rx_data(rx_data),
		.rx_ready(rx_ready_pre)
	);

  /*To generate a pulse when the rx_ready_pre is triggered*/
	always @(posedge clk) begin
		rx_ready_sync <= rx_ready_pre;
		rx_ready <= ~rx_ready_sync & rx_ready_pre;
	end

  /*This instance is used  to generate the TX tick clock with 1 oversampling */
	uart_baud_tick_gen #(
		.CLK_FREQUENCY(CLK_FREQUENCY),
		.BAUD_RATE(BAUD_RATE),
		.OVERSAMPLING(1)
	) baud_tick_blk (
		.clk(clk),
		.enable(tx_busy), /*Enabled only when it is necessary to send data*/
		.tick(baud_tick)
	);

  /*This instance implements the uart transmission*/
	uart_tx uart_tx_blk (
		.clk(clk),
		.reset(reset),
		.baud_tick(baud_tick),
		.tx(tx),
		.tx_start(tx_start),
		.tx_data(tx_data),
		.tx_busy(tx_busy)
	);

endmodule
