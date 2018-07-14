`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Mauricio Solis
// 
// Create Date: 05/21/2017 05:35:53 PM
// Design Name: 
// Module Name: templates
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


module templates(

    );
endmodule


module template_6x4_600x400(
	input clk,
	input [10:0] hc,
	input [10:0] vc,
	output logic[2:0]matrix_x = 3'd0,//desde 0 hasta 5
	output logic[1:0]matrix_y = 2'd0,//desde 0 hasta 3
	output logic lines
	);

	localparam d_col = 8'b1_1001;		//25 ....agregar 2 ceros //25 * 6 = 150
	localparam d_row = 7'b1_1001;		//25 ....agregar 2 ceros //25 * 4 = 100
	localparam zeros_col = 2'd0;
	localparam zeros_row = 2'd0;
	
	logic [7:0]col = d_col;	
	logic [6:0]row = d_row;		
	logic [7:0]col_next;
	logic [6:0]row_next;
	
	logic [2:0]matrix_x_next;
	logic [1:0]matrix_y_next;
	
	logic [10:0]hc_template, vc_template;
	
	
	parameter GRID_XI = 		212;
	parameter GRID_XF = 		812;
	
	parameter GRID_YI = 		184;
	parameter GRID_YF = 		584;
	
	assign hc_template = ( (hc > GRID_XI) && (hc <= GRID_XF) )?hc - GRID_XI: 11'd0;
	assign vc_template = ( (vc > GRID_YI) && (vc <= GRID_YF) )?vc - GRID_YI: 11'd0;
	
	
	
	always_comb
		if(hc_template == 'd0)//fuera del rango visible
			{col_next, matrix_x_next} = {d_col, 3'd0};
		else if(hc_template > {col, zeros_col})
			{col_next, matrix_x_next} = {col + d_col, matrix_x + 3'd1};
		else
			{col_next,matrix_x_next} = {col, matrix_x};
	
	always_comb
		if(vc_template == 'd0)
			{row_next,matrix_y_next} = {d_row, 2'd0};
		else if(vc_template > {row, zeros_row})
			{row_next, matrix_y_next} = {row + d_row, matrix_y + 2'd1};
		else
			{row_next, matrix_y_next} = {row, matrix_y};
	
	//para generar las l??neas divisorias.
	logic lin_v, lin_v_next;
	logic lin_h, lin_h_next;
	
	always_comb
	begin
		if(hc_template > {col, zeros_col})
			lin_v_next = 1'b1;
		else
			lin_v_next = 1'b0;
			
		if(vc_template > {row, zeros_row})
			lin_h_next = 1'b1;
		else if(hc == GRID_XF)
			lin_h_next = 1'b0;
		else
			lin_h_next = lin_h;
	end
	
	
	always_ff@(posedge clk)
		{col, row, matrix_x, matrix_y} <= {col_next, row_next, matrix_x_next, matrix_y_next};
	
	always_ff@(posedge clk)
		{lin_v, lin_h} <= {lin_v_next, lin_h_next};
		
	
	always_comb
		if( (hc == (GRID_XI + 11'd1)) || (hc == GRID_XF) ||
		  (vc == (GRID_YI + 11'd1)) || (vc == GRID_YF) )
			lines = 1'b1;
		else if( (lin_v == 1'b1) || (lin_h == 1'b1))
			lines = 1'b1;
		else
			lines = 1'b0;

endmodule
