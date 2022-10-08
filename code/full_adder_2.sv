/**
 *  Full adder that has 2 `always_comb` blocks.
 */
module full_adder_2 (
	output logic s, co,
	input  logic a, b, ci
);

always_comb
	s = a ^ b ^ ci;

always_comb
	co = (a & b) | (a & ci) | (b & ci);

endmodule

/*?{{
logic s, co, a, b, ci;

full_adder_2 full_adder_2_inst(.*);

initial begin
	#10ns a = 0; b = 0; ci = 0;
	#10ns a = 0; b = 0; ci = 1;
	#10ns a = 0; b = 1; ci = 0;
	#10ns a = 0; b = 1; ci = 1;
	#10ns a = 1; b = 0; ci = 0;
	#10ns a = 1; b = 0; ci = 1;
	#10ns a = 1; b = 1; ci = 0;
	#10ns a = 1; b = 1; ci = 1;
	#10ns ;
end
}}*/
