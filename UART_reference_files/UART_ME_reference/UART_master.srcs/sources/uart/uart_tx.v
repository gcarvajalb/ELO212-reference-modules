/*
 * uart_tx.v
 * 2017/02/01 - Felipe Veas <felipe.veasv at usm.cl>
 * 2022/07/04 - Mauricio Solis: Add some comments abd headers.
 *
 * @brief Asynchronous Transmitter.
 * 1. The parent module set the tx_data and rise tx_start.
 * 2. The transmitter send the start bit.
 * 3. The transmitter send the tx_data bit per bit.
 * 4. The transmitter send the stop bit.
 *
 * @param clk           The FPGA clock
 * @param reset         The reset.
 * @param baud_tick     A pulse that is triggered 1 times per baud to sent.
 * @param tx_start      To start the transmission process.
 * @param tx_data       The byte to sent.
 * @param tx            The transmission signal.
 * @param tx_busy       To indicate a transmission is in progress.
 */

`timescale 1ns / 1ps

module uart_tx
(
	input clk,
	input reset,
	input baud_tick,
	input tx_start,
	input [7:0] tx_data,
	output reg tx,
	output reg tx_busy
);

	localparam TX_IDLE  = 2'b00;    /*Transmission process is idle*/
	localparam TX_START = 2'b01;    /*Transmission process has been started*/
	localparam TX_SEND  = 2'b10;    /*Transmission process is sending the data bit per bit*/
	localparam TX_STOP  = 2'b11;    /*Transmission process is sending the STOP bit.*/

	reg [1:0] state = TX_IDLE, state_next;
	reg [2:0] counter = 3'd0, counter_next;   /*The bit counter: To know what bit must be sent.*/
  reg [7:0] tx_data_reg;                    /*A local copy of the byte to be transmitted.*/
    
  always @(posedge clk) begin
    if (reset)
      tx_data_reg <= 'd0;
    else if (state == TX_IDLE && tx_start)  /*The parent module rised the tx_start signal while the process was in IDLE*/
      tx_data_reg <= tx_data;               /*Registering the data to be transmitted.*/
    end

	always @(*) begin
		tx = 1'b1;
		tx_busy = 1'b1;
		state_next = state;
		counter_next = counter;

		case (state)
      TX_IDLE: begin
        tx_busy = 1'b0;
        state_next = (tx_start) ? TX_START : TX_IDLE;
      end
      
      TX_START: begin
        tx = 1'b0;  /*Transmitting the Start bit*/
        state_next = (baud_tick) ? TX_SEND : TX_START;
        counter_next = 'd0;
      end
      
      TX_SEND: begin
        tx = tx_data_reg[counter];  /*Transmitting a single data bit*/
        if (baud_tick) begin
          state_next = (counter == 'd7) ? TX_STOP : TX_SEND;
          counter_next = counter + 'd1;
        end
      end
      
      TX_STOP:
        /*Transmitting the tx default value = 1'b1*/
        state_next = (baud_tick) ? TX_IDLE : TX_STOP;
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			state <= TX_IDLE;
			counter <= 'd0;
		end else begin
			state <= state_next;
			counter <= counter_next;
		end
	end

endmodule
