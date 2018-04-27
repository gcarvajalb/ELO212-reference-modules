// Simple counter

module counter(
        input logic clk,
        // Input clock

        input logic reset,
        // Reset signal

        input logic enable,
        // The counte only increments when this signal is high

        output logic [WIDTH-1:0] count
        // Actual count value
    );

    parameter MAX = 3;
    // Maximum value of the counter. When this value is reached, the counter
    // resets to 0 on the next clock (if enabled is high).

    localparam WIDTH = $clog2(MAX);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end
        else begin
        	if (enable) begin
				if (count < MAX)
					count <= count + 'b01;
				else
					count <= 0;
			end
        end
    end
endmodule
