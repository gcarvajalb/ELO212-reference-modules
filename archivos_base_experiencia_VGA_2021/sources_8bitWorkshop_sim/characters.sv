`ifndef CHARACTERS_H
`define CHARACTERS_H
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
// Revision 0.02 - Modified to use two vectors of 20 bits instead one of 40 bits.
// Additional Comments: 
// 2020-07-10: It was modified to use it in https://8bitworkshop.com/
//
//////////////////////////////////////////////////////////////////////////////////
module characters(
  input [7:0] select_in,
  input [2:0]coor_x,
  input [2:0]coor_y,
  output pixel
  );
  
  logic [10:0]select;/*Here I think there is an issue, because if you don't add some bits, the simulator shows an error*/
  assign select = {3'd0, select_in};
  
  
  logic [19:0] vec_char_0;
  logic [19:0] vec_char_1;
	
  logic [19:0]vect_num_00;
  logic [19:0]vect_num_01;
  
  logic [19:0]vect_num_10;
  logic [19:0]vect_num_11;

  logic [19:0]vect_num_20;
  logic [19:0]vect_num_21;
  
  logic [19:0]vect_num_30;
  logic [19:0]vect_num_31;
  
  logic [19:0]vect_num_40;
  logic [19:0]vect_num_41;
  
  logic [19:0]vect_num_50;
  logic [19:0]vect_num_51;
  
  logic [19:0]vect_num_60;
  logic [19:0]vect_num_61;
  
  logic [19:0]vect_num_70;
  logic [19:0]vect_num_71;
  
  logic [19:0]vect_num_80;
  logic [19:0]vect_num_81;
  
  logic [19:0]vect_num_90;
  logic [19:0]vect_num_91;
  

  logic [19:0]vect_char_a0;
  logic [19:0]vect_char_a1;
  
  logic [19:0]vect_char_b0;
  logic [19:0]vect_char_b1;
  
  logic [19:0]vect_char_c0;
  logic [19:0]vect_char_c1;
  
  logic [19:0]vect_char_d0;
  logic [19:0]vect_char_d1;
  
  logic [19:0]vect_char_e0;
  logic [19:0]vect_char_e1;
  
  logic [19:0]vect_char_f0;
  logic [19:0]vect_char_f1;
  
  logic [19:0]vect_char_plus0;
  logic [19:0]vect_char_plus1;
  
  logic [19:0]vect_char_and0;
  logic [19:0]vect_char_and1;
  
  logic [19:0]vect_char_mult0;
  logic [19:0]vect_char_mult1;
  
  logic [19:0]vect_char_minus0;
  logic [19:0]vect_char_minus1;
  
  
  logic [19:0]vect_char_or0;
  logic [19:0]vect_char_or1;
  
  logic [19:0]vect_char_space0;
  logic [19:0]vect_char_space1;
 
  
  assign {vect_num_01, vect_num_00} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_11, vect_num_10} =   {5'b00000,5'b01110,5'b00100,5'b00100,5'b00100,5'b00100,5'b00110,5'b00100};
  assign {vect_num_21, vect_num_20} =   {5'b00000,5'b11111,5'b00010,5'b00100,5'b01000,5'b10000,5'b10001,5'b01110};

  assign {vect_num_31, vect_num_30} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_41, vect_num_40} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_51, vect_num_50} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_61, vect_num_60} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_71, vect_num_70} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_81, vect_num_80} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_num_91, vect_num_90} =   {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};

  assign {vect_char_a1, vect_char_a0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_b1, vect_char_b0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_c1, vect_char_c0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_d1, vect_char_d0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_e1, vect_char_e0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_f1, vect_char_f0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  
  
  
  assign {vect_char_and1, vect_char_and0} = {5'b00000,5'b10110,5'b01001,5'b10101,5'b00010,5'b00101,5'b01001,5'b00110};
  assign {vect_char_mult1, vect_char_mult0} = {5'b00000,5'b00000,5'b00100,5'b10101,5'b01110,5'b10101,5'b00100,5'b00000};
  assign {vect_char_plus1, vect_char_plus0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_minus1, vect_char_minus0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_or1, vect_char_or0} = {5'b00000,5'b01110,5'b10001,5'b10011,5'b10101,5'b11001,5'b10001,5'b01110};
  assign {vect_char_space1, vect_char_space0}=40'd0;
  
 
  always_comb
  begin
    case(select)
      48:  {vec_char_1, vec_char_0} = {vect_num_01, vect_num_00} ;
      49:  {vec_char_1, vec_char_0} = {vect_num_11, vect_num_10} ;
      50:  {vec_char_1, vec_char_0} = {vect_num_21, vect_num_20} ; 
      51:  {vec_char_1, vec_char_0} = {vect_num_31, vect_num_30} ; 
      52:  {vec_char_1, vec_char_0} = {vect_num_41, vect_num_40} ;
      53:  {vec_char_1, vec_char_0} = {vect_num_51, vect_num_50} ;
      54:  {vec_char_1, vec_char_0} = {vect_num_61, vect_num_60} ;
      55:  {vec_char_1, vec_char_0} = {vect_num_71, vect_num_70} ;
      56:  {vec_char_1, vec_char_0} = {vect_num_81, vect_num_80} ;
      57:  {vec_char_1, vec_char_0} = {vect_num_91, vect_num_90} ;
      97:  {vec_char_1, vec_char_0} = {vect_char_a1, vect_char_a0};
      98:  {vec_char_1, vec_char_0} = {vect_char_b1, vect_char_b0};
      99:  {vec_char_1, vec_char_0} = {vect_char_c1, vect_char_c0};
      100: {vec_char_1, vec_char_0} = {vect_char_d1, vect_char_d0};
      101: {vec_char_1, vec_char_0} = {vect_char_e1, vect_char_e0};
      102: {vec_char_1, vec_char_0} = {vect_char_f1, vect_char_f0};
      43:  {vec_char_1, vec_char_0} = {vect_char_plus1, vect_char_plus0};
      45:  {vec_char_1, vec_char_0} = {vect_char_minus1, vect_char_minus0};
      42:  {vec_char_1, vec_char_0} = {vect_char_mult1, vect_char_mult0};
      124: {vec_char_1, vec_char_0} = {vect_char_or1, vect_char_or0};
      38:  {vec_char_1, vec_char_0} = {vect_char_and1, vect_char_and0};
      
      
      default: {vec_char_1, vec_char_0} = {vect_char_f1, vect_char_f0};
    endcase
  end 

    
  logic [4:0]character_to_show[0:7];
  logic [4:0]row;
  
  assign { character_to_show[7], character_to_show[6], character_to_show[5], character_to_show[4],
  			character_to_show[3], character_to_show[2], character_to_show[1], character_to_show[0] } = 
  			{vec_char_1, vec_char_0};
  assign row = character_to_show[coor_y];
  assign pixel = row[coor_x];
  
endmodule



/* @brief Este Modulo sirve para dibujar en pantalla un caracter aislado
 *
 * @param clk = pixel clock
 * @param rst = reset
 * @param hc_visible = contador pixeles horizontales del modulo driver_vga
 * @param vc_visible = contador pixeles verticales del modulo driver_vga
 * @param the_char = El caracter a dibujar
 * @param in_square = indica si está en el cuadro que rodea al caracter (Background)
 * @param in_character = se pone en alto si hay que pintar el pixel (foregraund)
*/

module show_one_char(
  input clk, 
  input rst, 
  input [8:0]hc_visible,
  input [7:0]vc_visible,
  input [7:0] the_char_in,
  output logic in_square,
  output logic in_character
  );

  parameter n =                      3;           //numero de bits necesario para contar los pixeles definidos por ancho_pixel
                                                  // n = log_2 (ancho_pixel)
  parameter ancho_pixel =            'd7;         //ancho y alto de cada pixel que compone a un caracter.
  parameter CHAR_X_LOC =             9'd70;
  parameter CHAR_Y_LOC =             9'd150;
  localparam CHARACTER_WIDTH =       8'd5;
  localparam CHARACTER_HEIGHT =      8'd8;
  localparam MAX_CHARACTER_LINE =    1;          //habran 1 caracteres por linea
  localparam MAX_NUMBER_LINES =      1;          //numero de lineas
  localparam MENU_WIDTH =            ( CHARACTER_WIDTH + 8'd1 ) * MAX_CHARACTER_LINE * ancho_pixel + ancho_pixel;
  localparam MENU_HEIGHT =           (CHARACTER_HEIGHT) * MAX_NUMBER_LINES * ancho_pixel  + ancho_pixel;
  localparam CHAR_X_TOP =            CHAR_X_LOC + MENU_WIDTH;
  localparam CHAR_Y_TOP =            CHAR_Y_LOC + MENU_HEIGHT; 
  
  logic [7:0]the_char;
  assign the_char={the_char_in};
  
  logic [7:0]push_menu_minimat_x;                //se incremente a incrementos de ancho de caracter
  logic [7:0]push_menu_minimat_y;                //se incremente a incrementos de largo de caracter
  logic [7:0]push_menu_minimat_x_next;
  logic [7:0]push_menu_minimat_y_next;
  
  
  logic [2:0]pixel_x_to_show;                    //indica la coordenada x del pixel que se debe dibujar
  logic [2:0]pixel_y_to_show;                    //indica la coordenada y del pixel que se debe dibujar
  logic [2:0]pixel_x_to_show_next;
  logic [2:0]pixel_y_to_show_next;
  
  logic [8:0]hc_visible_menu;                    //para fijar la posicion x en la que aparecera el cuadro de texto
  logic [8:0]vc_visible_menu;                    //para fijar la posicion y en la que aparecera el cuadro de texto
  
  logic in_square_hc;
  logic in_square_vc;
  	
  assign in_square = (hc_visible_menu > 0) && (vc_visible_menu > 0);
  assign in_square_hc = in_square && (hc_visible_menu > ancho_pixel); // para comenzar a pintar a una distancia igual a ancho_pixel del borde
  assign in_square_vc = (vc_visible_menu > ancho_pixel); // para comenzar a pintar a una distancia igual a ancho_pixel del borde
  
  assign hc_visible_menu = ( (hc_visible >= CHAR_X_LOC) && (hc_visible <= CHAR_X_TOP) )? hc_visible - CHAR_X_LOC:9'd0;
  assign vc_visible_menu = ( (vc_visible >= CHAR_Y_LOC) && (vc_visible <= CHAR_Y_TOP) )? vc_visible - CHAR_Y_LOC:9'd0;
  
  
  logic [n-1:0]contador_pixels_horizontales;    //este registro cuenta de 0 a 2
  logic [n-1:0]contador_pixels_verticales;      //este registro cuenta de 0 a 2
  
  logic [n-1:0]contador_pixels_horizontales_next;
  logic [n-1:0]contador_pixels_verticales_next;
  //1 pixel por pixel de letra
  
  //contando cada 3 pixeles
  always_comb
    if(in_square_hc)
      if(contador_pixels_horizontales == (ancho_pixel - 'd1))
        contador_pixels_horizontales_next = 3'd0;
      else
	contador_pixels_horizontales_next = contador_pixels_horizontales + 'd1;
    else
      contador_pixels_horizontales_next = 'd0;
			
  always_ff@(posedge clk)
      contador_pixels_horizontales <= contador_pixels_horizontales_next;
//////////////////////////////////////////////////////////////////////////////			
	
//contando cada tres pixeles verticales
  always_comb
    if(in_square_vc)
      if(hc_visible_menu == MENU_WIDTH)
        if(contador_pixels_verticales == (ancho_pixel - 'd1))
          contador_pixels_verticales_next = 'd0;
        else
          contador_pixels_verticales_next = contador_pixels_verticales + 'd1;
      else
        contador_pixels_verticales_next = contador_pixels_verticales;
    else
      contador_pixels_verticales_next = 'd0;
			
  always_ff@(posedge clk)

      contador_pixels_verticales <= contador_pixels_verticales_next;
/////////////////////////////////////////////////////////////////////////////
	
//Calculando en que caracter est?? el haz y qu?? pixel hay que dibujar
  logic pixel_limit_h = contador_pixels_horizontales == (ancho_pixel - 'd1);//cuando se lleg?? al m??ximo.
  logic hor_limit_char = push_menu_minimat_x == ((CHARACTER_WIDTH + 8'd1) - 8'd1);//se debe agregar el espacio de separaci??n

  always_comb
  begin
    case({in_square_hc, pixel_limit_h, hor_limit_char})
      3'b111: push_menu_minimat_x_next = 8'd0;
      3'b110: push_menu_minimat_x_next = push_menu_minimat_x + 8'd1;
      3'b100, 3'b101: push_menu_minimat_x_next = push_menu_minimat_x;
      default: push_menu_minimat_x_next = 8'd0;
    endcase
		
    case({in_square_hc,pixel_limit_h,hor_limit_char})
      3'b111: pixel_x_to_show_next = 3'd0;
      3'b110: pixel_x_to_show_next = pixel_x_to_show + 3'd1;
      3'b100,3'b101:pixel_x_to_show_next = pixel_x_to_show;
      default:pixel_x_to_show_next = 3'd0;
    endcase
  end
	
  always_ff@(posedge clk)
  begin
    push_menu_minimat_x <= push_menu_minimat_x_next;
    pixel_x_to_show <= pixel_x_to_show_next;
  end

  logic pixel_limit_v;
  logic ver_limit_char;
  
  assign pixel_limit_v = (contador_pixels_verticales == (ancho_pixel - 'd1) && (hc_visible_menu == MENU_WIDTH)); //cuando se llega al maximo.
  assign ver_limit_char = push_menu_minimat_y == (CHARACTER_HEIGHT - 8'd1);  
  
  always_comb
  begin
    case({in_square_vc, pixel_limit_v, ver_limit_char})
      3'b111:push_menu_minimat_y_next = 8'd0;
      3'b110:push_menu_minimat_y_next = push_menu_minimat_y + 8'd1;
      3'b100,3'b101:push_menu_minimat_y_next = push_menu_minimat_y;
      default:push_menu_minimat_y_next = 8'd0;
    endcase
  	
    case({in_square_vc, pixel_limit_v, ver_limit_char})
      3'b111:pixel_y_to_show_next = 3'd0;
      3'b110:pixel_y_to_show_next = pixel_y_to_show + 3'd1;
      3'b100,3'b101:pixel_y_to_show_next = pixel_y_to_show;
      default:pixel_y_to_show_next = 3'd0;
    endcase
  end
  
  always_ff@(posedge clk)
  begin
    push_menu_minimat_y <= push_menu_minimat_y_next;
    pixel_y_to_show <= pixel_y_to_show_next;
  end
  
  //logic [8 * MAX_CHARACTER_LINE - 1:0] tex_row_tmp;
  logic [7:0]tex_row_tmp;
  
  logic [7:0]select;
  assign tex_row_tmp = the_char;
  assign select = tex_row_tmp;
  
  logic pix;
  characters m_ch(select[7:0], pixel_x_to_show, pixel_y_to_show, pix);
  
  always_comb
    if(in_square_hc && in_square_vc)
      if(pixel_x_to_show == 5)
        in_character = 1'd0;
      else
        in_character = pix;
    else
      in_character = 1'd0;
endmodule


`endif
