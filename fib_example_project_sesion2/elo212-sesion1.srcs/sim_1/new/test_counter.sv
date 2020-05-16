`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2020 09:02:40 PM
// Design Name: 
// Module Name: test_counter
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


module test_counter( );

    logic           clk, reset;
    logic           switch, fib, displayON;
    logic   [7:0]   sevenSeg;

    fib_top fib_top_inst(
    .clock      (clk), 
    .reset      (reset), 
    .switch     (switch),
    .fib        (fib),
    .sevenSeg   (sevenSeg),
    .displayON  (displayON)
    );

    always #5 clk = ~clk;  //Generacion senal de reloj

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
    end


endmodule
