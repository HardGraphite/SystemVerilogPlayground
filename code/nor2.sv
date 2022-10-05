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

/*?{{
logic y, a, b;

nor2 nor2_inst(.*);

initial begin
	#10ns a = 0; b = 0;
	#10ns a = 0; b = 1;
	#10ns a = 1; b = 0;
	#10ns a = 1; b = 1;
	#10ns ;
end
}}*/
