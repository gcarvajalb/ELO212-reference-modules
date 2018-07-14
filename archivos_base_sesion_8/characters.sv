`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Mauricio Solis
// 
// Create Date:    17:09:55 05/23/2015 
// Design Name: 
// Module Name:    caracters 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module characters(
	input [7:0] select ,
	input [2:0]coor_x,
	input [2:0]coor_y,
	output pixel
	);
	
	logic [39:0] vec_char;
	
	logic [39:0]vect_char_a;//97
	logic [39:0]vect_char_b;
	logic [39:0]vect_char_c;
	logic [39:0]vect_char_d;
	logic [39:0]vect_char_e;
	logic [39:0]vect_char_f;
	logic [39:0]vect_char_g;
	logic [39:0]vect_char_h;
	logic [39:0]vect_char_i;
	logic [39:0]vect_char_j;
	logic [39:0]vect_char_k;
	logic [39:0]vect_char_l;
	logic [39:0]vect_char_m;
	logic [39:0]vect_char_n;
	logic [39:0]vect_char_o;
	logic [39:0]vect_char_p;
	logic [39:0]vect_char_q;
	logic [39:0]vect_char_r;
	logic [39:0]vect_char_s;
	logic [39:0]vect_char_t;
	logic [39:0]vect_char_u;
	logic [39:0]vect_char_v;
	logic [39:0]vect_char_w;
	logic [39:0]vect_char_x;
	logic [39:0]vect_char_y;
	logic [39:0]vect_char_z;
	logic [39:0]vect_char_nn;
	
	logic [39:0]vect_num_0;//48
	logic [39:0]vect_num_1;
	logic [39:0]vect_num_2;
	logic [39:0]vect_num_3;
	logic [39:0]vect_num_4;
	logic [39:0]vect_num_5;
	logic [39:0]vect_num_6;
	logic [39:0]vect_num_7;
	logic [39:0]vect_num_8;
	logic [39:0]vect_num_9;
	logic [39:0]vect_num_p;//punto
	logic [39:0]vect_space;//espacio
	
	assign vect_char_a = {5'b00000,5'b11110,5'b10001,5'b11110,5'b10000,5'b01110,5'b00000,5'b00000};
	assign vect_char_b = {5'b00000,5'b01111,5'b10001,5'b10001,5'b10011,5'b01101,5'b00001,5'b00001};
	assign vect_char_c = {5'b00000,5'b01110,5'b10001,5'b00001,5'b00001,5'b01110,5'b00000,5'b00000};
	assign vect_char_d = {5'b00000,5'b11110,5'b10001,5'b10001,5'b11001,5'b10110,5'b10000,5'b10000};
	assign vect_char_e = {5'b00000,5'b01110,5'b00001,5'b11111,5'b10001,5'b01110,5'b00000,5'b00000};
	assign vect_char_f = {5'b00000,5'b00010,5'b00010,5'b00010,5'b00111,5'b00010,5'b10010,5'b01100};
	assign vect_char_g = {5'b00000,5'b01110,5'b10000,5'b11110,5'b10001,5'b10001,5'b11110,5'b00000};
	assign vect_char_h = {5'b00000,5'b10001,5'b10001,5'b10001,5'b10011,5'b01101,5'b00001,5'b00001};
	assign vect_char_i = {5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00110,5'b00000,5'b00100};
	assign vect_char_j = {5'b00000,5'b00110,5'b01001,5'b01000,5'b01000,5'b01100,5'b00000,5'b01000};
	assign vect_char_k = {5'b00000,5'b01001,5'b00101,5'b00011,5'b00101,5'b01001,5'b00001,5'b00001};
	assign vect_char_l = {5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00100,5'b00100,5'b00110};
	assign vect_char_m = {5'b00000,5'b10001,5'b10001,5'b10101,5'b10101,5'b01011,5'b00000,5'b00000};
	assign vect_char_n = {5'b00000,5'b10001,5'b10001,5'b10001,5'b10011,5'b01101,5'b00000,5'b00000};
	assign vect_char_o = {5'b00000,5'b01110,5'b10001,5'b10001,5'b10001,5'b01110,5'b00000,5'b00000};
	//COMPLETAR EL RESTO DE LAS LETRAS

	assign vect_num_0 = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
	assign vect_num_1 = {5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00100,5'b00110,5'b00100};
	assign vect_num_2 = {5'b00000,5'b11111,5'b00010,5'b00100,5'b01000,5'b10000,5'b10001,5'b01110};
	assign vect_num_3 = {5'b00000,5'b01110,5'b10001,5'b10000,5'b01000,5'b00100,5'b01000,5'b11111};
	assign vect_num_4 = {5'b00000,5'b01000,5'b01000,5'b11111,5'b01001,5'b01010,5'b01100,5'b01000};
	//COMPLETAR EL RESTO DE LOS NUMEROS


	always_comb
		case(select)
			"0":    vec_char=vect_num_0;
			"1":    vec_char=vect_num_1;
			"2":    vec_char=vect_num_2;
			"3":    vec_char=vect_num_3;
			"4":    vec_char=vect_num_4;
			"5":    vec_char=vect_num_5;
			"6":    vec_char=vect_num_6;
			"7":    vec_char=vect_num_7;
			"8":    vec_char=vect_num_8;
			"9":    vec_char=vect_num_9;
			8'd46:  vec_char=vect_num_p;
			//8'd32:vec_char=vect_char_space;
			8'd97:  vec_char=vect_char_a;
			8'd98:  vec_char=vect_char_b;
			8'd99:  vec_char=vect_char_c;
			8'd100: vec_char=vect_char_d;
			8'd101: vec_char=vect_char_e;
			8'd102: vec_char=vect_char_f;
			8'd103: vec_char=vect_char_g;
			8'd104: vec_char=vect_char_h;
			8'd105: vec_char=vect_char_i;
			8'd106: vec_char=vect_char_j;
			8'd107: vec_char=vect_char_k;
			8'd108: vec_char=vect_char_l;
			8'd109: vec_char=vect_char_m;
			8'd110: vec_char=vect_char_n;
			8'd111: vec_char=vect_char_o;
			8'd112: vec_char=vect_char_p;
			8'd113: vec_char=vect_char_q;
			8'd114: vec_char=vect_char_r;
			8'd115: vec_char=vect_char_s;
			8'd116: vec_char=vect_char_t;
			8'd117: vec_char=vect_char_u;
			8'd118: vec_char=vect_char_v;
			8'd119: vec_char=vect_char_w;
			8'd120: vec_char=vect_char_x;
			8'd121: vec_char=vect_char_y;
			8'd122: vec_char=vect_char_z;
			8'd164: vec_char=vect_char_nn;//??
			default:vec_char=vect_num_p;//punto
	endcase
	
	
	logic [4:0]character_to_show[0:7];
	logic [4:0]row;
	
	assign { character_to_show[7], character_to_show[6], character_to_show[5], character_to_show[4],
				character_to_show[3], character_to_show[2], character_to_show[1], character_to_show[0] } = 
				vec_char;
	assign row = character_to_show[coor_y];
	assign pixel = row[coor_x];
	
endmodule




