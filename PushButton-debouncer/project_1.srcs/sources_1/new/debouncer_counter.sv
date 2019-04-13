module PB_Debouncer_counter#(
    parameter DELAY=15,                     // Number of clock pulses to check stable button pressing
    parameter DELAY_WIDTH = $clog2(DELAY)   // Determine the size of the clock cycles counter
    )
(
	input 	logic clk,                  // base clock
	input 	logic rst,                  // global reset
	input 	logic PB,                   // raw asynchronous input from mechanical PB         
	output 	logic PB_pressed_status,    // clean and synchronized pulse for button pressed
	output  logic PB_pressed_pulse,    // high if button is pressed
	output  logic PB_released_pulse    // clean and synchronized pulse for button released
 );
	
	
	logic PB_sync_aux, PB_sync;

// Double flopping stage for synchronizing async. PB input signal
// PB_sync is the synchronized signal used for other circuits
    always_ff @(posedge clk) begin
        if (rst) begin
            PB_sync_aux <= 1'b0;
            PB_sync     <= 1'b0;
        end
        else begin
            PB_sync_aux <= PB;
            PB_sync     <= PB_sync_aux;
        end
    end
/////////////////

    logic [DELAY_WIDTH-1:0] PB_cnt;
    logic PB_IDLE;
    logic PB_COUNT_MAX;
// When the push-button is pushed or released, increment the counter
// The counter has to be maxed out before we decide that the push-button state has changed

    assign PB_IDLE      = (PB_pressed_status==PB_sync);
    assign PB_COUNT_MAX = &PB_cnt;	// true when all bits of PB_cnt are 1's (counter has maxed out)

    always_ff @(posedge clk) begin
        if (rst) begin
            PB_pressed_status <= 1'b0;
        end
        else
            if(PB_IDLE)
                PB_cnt <= 0;  // nothing's going on
            else begin
                PB_cnt <= PB_cnt + 'd1;  // something's going on, increment the counter
                if(PB_COUNT_MAX) PB_pressed_status <= ~PB_pressed_status;  // if the counter is maxed out, PB changed!
            end
     end

// logic to generate pressed and released pulses
assign PB_pressed_pulse  = ~PB_IDLE & PB_COUNT_MAX & ~PB_pressed_status; 
assign PB_released_pulse = ~PB_IDLE & PB_COUNT_MAX &  PB_pressed_status;

endmodule