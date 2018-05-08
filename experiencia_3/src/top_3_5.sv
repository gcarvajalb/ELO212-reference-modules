// Displays four different strings on the seven segment display, selected using
// switches

module top_3_5(
		input logic clk,

		input logic btnc, // Used as reset signal

		input [1:0] sw,

		output logic [6:0] disp_seg,
		output logic[7:0] disp_an
	);

	logic [63:0] str;

	always_comb begin
		case(sw)
		0: str = "ELO212";
		1: str = "Hans";
		2: str = "Lehnert";
		3: str = "UTFSM";
		endcase
	end

	seven_seg_display_ascii display_driver(
		.clk(clk),
		.reset(btnc),
		.values(str),
		.display_enable(8'hFF),
		.segments(disp_seg),
		.enable(disp_an)
	);
	defparam display_driver.DISPLAY_COUNT = 8;
endmodule
