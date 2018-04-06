`timescale 1ns / 1ps

module test_simple(); // creacion modulo "dummy"

logic [6:0] sevenSeg; // definicion de conexiones virtuales
logic       clk, reset, DP;

top DUT(.sevenSeg(sevenSeg),    //instancia del modulo a testear
        .DP(DP),
        .clk(clk),
        .reset(reset)
        );

always #5 clk = ~clk;

initial begin       //aca se asignan valores de prueba
    clk = 0;
    reset = 1;
    #10 reset =0;
end

endmodule