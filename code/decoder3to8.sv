/**
 * 3-8 decoder
 */
module decoder3to8 (
	output logic [7:0] out,
	input  logic [2:0] in
);

always_comb begin
	case (in)
		3'b000: out = 8'b0000_0001;
		3'b001: out = 8'b0000_0010;
		3'b010: out = 8'b0000_0100;
		3'b011: out = 8'b0000_1000;
		3'b100: out = 8'b0001_0000;
		3'b101: out = 8'b0010_0000;
		3'b110: out = 8'b0100_0000;
		3'b111: out = 8'b1000_0000;
		default:out = 'x;
	endcase
end

endmodule

/*?{{
logic [7:0] out;
logic [2:0] in;

decoder3to8 decoder3to8_inst(.*);

initial begin
	#10 in = 3'd0;
	#10 in = 3'd1;
	#10 in = 3'd2;
	#10 in = 3'd3;
	#10 in = 3'd4;
	#10 in = 3'd5;
	#10 in = 3'd6;
	#10 in = 3'd7;
	#10 in = 3'd0;
end
}}*/
