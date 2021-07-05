`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2020 06:10:13 PM
// Design Name: 
// Module Name: nexys4_vga_sim
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


module nexys4_vga_sim(
    );
    
    logic clk_vga_t, rst_t, hs_t, vs_t;
    logic [9:0] hc_visible_t, vc_visible_t;
    
    driver_vga_640x480 uut(
    	
    	.clk_vga (clk_vga_t),
    	.rst(rst_t),
    	.hs(hs_t), .vs(vs_t), 
    	.hc_visible(hc_visible_t),
    	.vc_visible(vc_visible_t)
    	); 
    
    always #1clk_vga_t = ~clk_vga_t;
    
    initial begin
    	clk_vga_t = 0;
    	rst_t = 1;
    	#2 rst_t = 0;
    end
    
endmodule
