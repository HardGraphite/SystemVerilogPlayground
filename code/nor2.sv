/**
 * 2 input NOR gate.
 */
module nor2(
	output logic y,
	input  logic a, b
);

always_comb begin
	y = a ^ b;
end

endmodule
