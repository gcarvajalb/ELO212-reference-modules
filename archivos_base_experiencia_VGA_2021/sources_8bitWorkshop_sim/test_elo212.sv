`include "hvsync_generator.v"
`include "characters.sv"

module top(clk, reset, hsync, vsync, rgb, switches_p1, switches_p2);

  input clk, reset;
  output hsync, vsync;
  output [2:0] rgb;
  input [7:0] switches_p1;
  input [7:0] switches_p2; 
  
  parameter COLOR_RED = 3'b100;
  parameter COLOR_GREEN = 3'b010;
  parameter COLOR_BLUE = 3'b001;
  parameter COLOR_YELLOW = 3'b110;
  parameter COLOR_CYAN = 3'b011;
  parameter COLOR_MAGENTA = 3'b101;
  parameter COLOR_BLACK = 3'b000;
  parameter COLOR_WHITE = 3'b111;
  
  
  wire display_on;
  wire [8:0] hc_visible;


  wire [8:0] vc_visible;

  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(display_on),
    .hpos(hc_visible),
    .vpos(vc_visible)
  );
  logic d_up, d_down, d_left, d_right, space;
  
  assign {space, d_down, d_up, d_right, d_left} = switches_p1[4:0];
  /*
  logic c_fg, c_bg;
  show_one_char #(.CHAR_X_LOC(190), .CHAR_Y_LOC(30), .ancho_pixel(3)) 
  ch_d0(.clk(clk), .rst(1'b0), .hc_visible(hc_visible), .vc_visible(vc_visible[7:0]), .the_char_in("1"), 
        .in_square(c_bg), .in_character(c_fg));
        */
  
  logic [2:0]rgb_inv;
  always_comb
    begin
      if((hc_visible == 'd0) || (vc_visible == 'd0))
        rgb_inv = {3'd0};
      else
      begin
        if((hc_visible == 9'd1) || (hc_visible == 9'd256))
          rgb_inv = COLOR_RED;
        else if((vc_visible == 9'd1) || (vc_visible == 9'd240))
          rgb_inv = COLOR_YELLOW;
        else if(hc_visible == vc_visible)
          rgb_inv = COLOR_CYAN;
        else if (hc_visible == (240 - vc_visible))
          rgb_inv = COLOR_MAGENTA;
        /*
        else if (c_fg == 1'b1)
          rgb_inv = COLOR_GREEN;
          */
        else if(space == 1'b1)
          rgb_inv = COLOR_BLUE;
        else
          rgb_inv = COLOR_WHITE;
    	end
    end

  assign rgb = {rgb_inv[0], rgb_inv[1], rgb_inv[2]};
endmodule
