/**
 * A parallel-in, serial-out shift register.
 */
module piso #(
	parameter N = 8
) (
	output logic         s,
	input  logic         clk,
	input  logic [N-1:0] p,
	input  logic         p_load
);

logic [N-1:0] p_data;

always_ff @(posedge clk) begin
	if (p_load)
		p_data <= p;
	else
		p_data <= {p_data[N - 2 : 0], 1'b0};
	s <= p_data[N - 1];
end

endmodule
