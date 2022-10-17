module three_state_mux (
	output wire  y,
	input  logic a, b, c, d,
	input  logic [1:0] s
);

assign y = s == 0 ? a : 'bz;
assign y = s == 1 ? b : 'bz;
assign y = s == 2 ? c : 'bz;
assign y = s == 3 ? d : 'bz;

endmodule

/*?{{
wire  y;
logic a, b, c, d;
logic [1:0] s;

three_state_mux three_state_mux_inst(.*);

assign a = 'b1;
assign b = 'b1;
assign c = 'b1;
assign d = 'b1;

initial begin
	#10ns s = 2'd0;
	#10ns s = 2'd1;
	#10ns s = 2'd2;
	#10ns s = 2'd3;
	#10ns ;
end
}}*/
