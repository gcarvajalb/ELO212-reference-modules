`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2020 06:08:29 PM
// Design Name: 
// Module Name: nexyst4_vga
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


module nexyst4_vga(
	input CLK100MHZ,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B,
	output VGA_HS,
	output VGA_VS

    );
    
    logic clk_vga;
    
    
    logic [9:0] hc_visible, vc_visible;
    
    clk_wiz_0 clk_wiz
    
     (// Clock in ports
      // Clock out ports
      .clk_out1(clk_vga),
      // Status and control signals
      .reset(1'b0),
      //.locked,
      .clk_in1(CLK100MHZ)
     );
    
    
    driver_vga_640x480 dv_01(
     	
        .clk_vga(clk_vga),                      // 23.75 MHz !
     	.rst(1'b0),
     	.hs(VGA_HS),
     	.vs(VGA_VS),
     	.hc_visible(hc_visible),
     	.vc_visible(vc_visible)
     	); 
    
    logic [11:0]rgb;
    
    always_comb
    begin
    	if((hc_visible == 'd0) || (vc_visible == 'd0))
    		rgb = {12'd0};
    	else
    	begin
    		if((hc_visible == 10'd1) || (hc_visible == 10'd640))
    			rgb = 12'hF00;
    		else if((vc_visible == 10'd1) || (vc_visible == 10'd480))
    			rgb = 12'hFF0;
    		else if(hc_visible == vc_visible)
    			rgb = 12'h0FF;
    		else 
    			rgb = 12'h000;
    	end
    end
    
    assign {VGA_R, VGA_G, VGA_B} = rgb;
endmodule

















