`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 07:49:28 PM
// Design Name: 
// Module Name: fib_top
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

module fib_top(
    input  logic        clock, reset,
    input  logic        switch, 
    output logic        fib,
    output logic [7:0]  sevenSeg,
    output logic        displayON
    );

    localparam COUNTER_WIDTH = 4;
    
    logic [COUNTER_WIDTH-1:0] count; 
 
     assign displayON = switch;
     
    // Para modulos con parametros, estos se indican antes del nombre de la instancia
    // Si no se especifican parametros cuando se instancia, se usa el valor por defecto
    // especificado dentro del modulo.  Buscar como instanciar modulos con mas de 1 parametro.
    counter_Nbits #(.N(COUNTER_WIDTH)) 
    contador_inst (
    .clk    (clock), 
    .reset  (reset), 
    .count  (count));    
    
    fib_rec fib_rec_inst(
       .number  (count),
	   .fib       (fib)
	);
    
    BCD_to_7seg BCD_to_7seg_inst(
        .BCD_in     (count),
        .SEG        (sevenSeg)
    );
    
endmodule
