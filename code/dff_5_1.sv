/**
 * A D flip-flop fulfilling 5.1/For you to do.
 */
module dff_5_1 (
	output logic q,
	input  logic clk,
	input  logic d,
	input  logic reset
);

always_ff @(negedge clk, posedge reset) begin
	if (reset)
		q <= 'd1;
	else
		q <= d;
end

endmodule
