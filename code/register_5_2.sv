/**
 * An n-bit register that is triggered on the rising edge of the clock and
 * that has an asynchronous active low reset and a synchronous enable signal.
 * It fulfills the requirements of the "For you to do" part in lecture 5.2.
 */
module register_5_2 #(
	parameter N = 1
) (
	output logic [N-1:0] y,
	input  logic         clk,
	input  logic         n_reset,
	input  logic         enable,
	input  logic         a
);

always_ff @(posedge clk, negedge n_reset) begin
	if (!n_reset)
		y <= '0;
	else if (enable)
		y <= a;
end

endmodule
