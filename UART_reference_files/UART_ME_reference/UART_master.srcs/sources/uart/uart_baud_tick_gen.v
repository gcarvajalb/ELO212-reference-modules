/*
* uart_baud_tick_gen.v
* 2017/02/01 - Felipe Veas <felipe.veasv at usm.cl>
* 2022/07/04 - Mauricio Solis: Add some comments abd headers.
*
* @brief 
* Baud clock generator for UART, original code from:
* http://fpga4fun.com/SerialInterface.html
*
* @param clk:      The FPGA clock.
* @param enable:   To enable/disable the tick generator.
* @param tick:     The tick base time output.
*/

`timescale 1ns / 1ps

module uart_baud_tick_gen
#(
parameter CLK_FREQUENCY = 25_000_000,
parameter BAUD_RATE = 115_200,
parameter OVERSAMPLING = 1
)
(
    input clk,
    input enable,
    output tick
);

    /*Base 2 Logarithm function*/
    function integer clog2;
    input integer value;
    begin
        value = value - 1;
        for (clog2 = 0; value > 0; clog2 = clog2 + 1)
            value = value >> 1;
    end
    endfunction

    localparam ACC_WIDTH = clog2(CLK_FREQUENCY / BAUD_RATE) + 8;                      /* The Accumulator width*/
    localparam SHIFT_LIMITER = clog2(BAUD_RATE * OVERSAMPLING >> (31 - ACC_WIDTH));   /* The Shift limiter to prevent overflow in calculus*/
    localparam INCREMENT =
            ((BAUD_RATE * OVERSAMPLING << (ACC_WIDTH - SHIFT_LIMITER)) +
            (CLK_FREQUENCY >> (SHIFT_LIMITER + 1))) / (CLK_FREQUENCY >> SHIFT_LIMITER);   /* The accumulator increment*/

    (* keep = "true" *)
    reg [ACC_WIDTH:0] acc = 0;
    
    always @(posedge clk)
        if (enable)
            acc <= acc[ACC_WIDTH-1:0] + INCREMENT[ACC_WIDTH:0];
        else
            acc <= INCREMENT[ACC_WIDTH:0];
    
    assign tick = acc[ACC_WIDTH];

endmodule
