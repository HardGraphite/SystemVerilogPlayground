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

/*?{{
logic y, a, b, c;

nand3 nand3_inst(.*);

initial begin
	#10ns a = 0; b = 0; c = 0;
	#10ns a = 0; b = 0; c = 1;
	#10ns a = 0; b = 1; c = 0;
	#10ns a = 0; b = 1; c = 1;
	#10ns a = 1; b = 0; c = 0;
	#10ns a = 1; b = 0; c = 1;
	#10ns a = 1; b = 1; c = 0;
	#10ns a = 1; b = 1; c = 1;
	#10ns ;
end
}}*/
