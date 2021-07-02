
`ifndef HVSYNC_GENERATOR_H
`define HVSYNC_GENERATOR_H

/*
Video sync generator, used to drive a simulated CRT.
To use:
- Wire the hsync and vsync signals to top level outputs
- Add a 3-bit (or more) "rgb" output to the top level
*/

module hvsync_generator(clk, reset, hsync, vsync, display_on, hpos, vpos);
  input clk;
  input reset;
  output hsync, vsync;
  output display_on;
  output [8:0] hpos;
  output [8:0] vpos;

  localparam hpixels = 9'd319;  // --Value of pixels in a horizontal line      320
  localparam vlines  = 9'd260;  // --Number of horizontal lines in the display 259

  localparam hfp  = 9'd7;      // --Horizontal front porch                       8
  localparam hsc  = 9'd24;      // --Horizontal sync                            24
  localparam hbp  = 9'd32;      // --Horizontal back porch                      32
	
  localparam vfp  = 9'd4;       // --Vertical front porch                        3
  localparam vsc  = 9'd10;       // --Vertical sync                             10
  localparam vbp  = 9'd6;      // --Vertical back porch                          6
	
  logic [8:0]hc_visible;
  logic [8:0]vc_visible;
  //wire hs,vs;
	
  logic [8:0] hc, hc_next, vc, vc_next;             // --These are the Horizontal and Vertical counters    
	
  assign hc_visible = ((hc < (hpixels - hfp)) && (hc >= (hsc + hbp)))?(hc - (hsc + hbp) + 'd1):9'd0;
  assign vc_visible = ((vc < (vlines - vfp))  && (vc >= (vsc + vbp)))?(vc - (vsc + vbp) + 'd1):9'd0;
	
  //assign {hsync, vsync} = {hs, vs};
  assign display_on = ((hc_visible > 0) && (vc_visible > 0));
  assign hpos = hc_visible;
  assign vpos = vc_visible;
	
	// --Runs the horizontal counter

  always_comb
    if(hc == (hpixels - 1))				// --If the counter has reached the end of pixel count
      hc_next = 9'd0;			// --reset the counter
    else
      hc_next = hc + 9'd1;		// --Increment the horizontal counter

	
	// --Runs the vertical counter
  always_comb
    if(hc == 9'd0)
      if(vc == (vlines - 1))
        vc_next = 9'd0;
      else
        vc_next = vc + 9'd1;
    else
      vc_next = vc;
	
  always_ff@(posedge clk)
    {hc, vc} <= {hc_next, vc_next};
		
  assign hsync = (hc < hsc) ? 1'b1 : 1'b0;   // --Horizontal Sync Pulse
  assign vsync = (vc < vsc) ? 1'b1 : 1'b0;   // --Vertical Sync Pulse
	
endmodule

`endif
