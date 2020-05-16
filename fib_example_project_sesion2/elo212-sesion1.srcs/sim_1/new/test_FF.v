`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2020 08:47:37 PM
// Design Name: 
// Module Name: test_FF
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


module test_FF( );

    logic  clk, reset, A, y;
    logic [3:0] count;

    //counter_4bit DUT(.clk(clk), .reset(reset), .count(count));

    flip_flops FF_inst(
        .A(A),
        .clk(clk),
        .reset(reset),
        .y(y)
        );
        
    always #5 clk = ~clk;  //Generacion senal de reloj

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #3 
        A=1;
        #8
        A=0;
    end
endmodule
