/**
 * 3 input NAND gate.
 */
module nand3(
	output logic y,
	input  logic a, b, c
);

always_comb begin
	y = ~(a & b & c);
end

endmodule
