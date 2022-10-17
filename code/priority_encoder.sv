/**
 * Priority encoder.
 */
module priority_encoder (
	output logic [1:0] y,
	output logic       y_valid,
	input  logic [3:0] a
);

always_comb begin
	y_valid = 1'b1;
	unique casez (a)
		4'b1??? : y = 2'b11;
		4'b01?? : y = 2'b10;
		4'b001? : y = 2'b01;
		4'b0001 : y = 2'b00;
		4'b0000 : begin
			y       = 2'b00;
			y_valid = 1'b0;
		end
		default : begin
			y       = 2'bxx;
			y_valid = 1'bx;
		end
	endcase
end

endmodule

/*?{{
logic [1:0] y;
logic       y_valid;
logic [3:0] a;

priority_encoder priority_encoder_inst(.*);

initial begin
	for (int i = 0; i < 16; i++) begin
		#10 a = i;
	end
	#10 ;
end
}}*/
