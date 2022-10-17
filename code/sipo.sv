/**
 * A serial-in, parallel-out shift register.
 */
module sipo #(
	parameter N = 8
)(
	output logic [N-1:0] p,
	input  logic         clk,
	input  logic         s
);

always_ff @(posedge clk)
	p <= {p[N - 2 : 0], s};

endmodule
