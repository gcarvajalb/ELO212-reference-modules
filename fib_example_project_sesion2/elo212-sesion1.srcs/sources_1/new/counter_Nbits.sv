`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2020 08:44:02 PM
// Design Name: 
// Module Name: counter_Nbits
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


module counter_Nbits
#(parameter N=4) // si no se especifica parametros durante la instanciacion, entonces se usa el valor por defecto
(
    input  logic            clk, reset,
    output logic [N-1:0] 	count
    );

    always_ff @(posedge clk) begin
        if (reset)
            count <= 'b0;  //al no especificar ancho de bits, la herramienta lo infiere de la señal a la que se esta asignando. Usar con cuidado.
        else
            count <= count+1;
    end
endmodule

