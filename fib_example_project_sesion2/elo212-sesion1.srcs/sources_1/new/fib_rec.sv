`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 08:26:01 PM
// Design Name: 
// Module Name: fib_rec
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

module fib_rec(
        input logic [3:0]   number,
        output logic        fib
    );
    
     always_comb begin
        if (number == 0 || number == 1 || number == 2 || number == 4 || number == 5 || number == 8 ||
		    number == 9 || number == 10)
            fib = 0;
        else
            fib = 1;
 end

endmodule
