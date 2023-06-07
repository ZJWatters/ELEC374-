module register0 (input clr, clk, enable, BAout, input[31:0] d, output reg [31:0] q);
	initial begin
		q<=32'h00000000;
	end
	always @(posedge clk) begin
		if(clr)
			q <= 32'h00000000;
		else if(enable)
			q <= {32{!BAout}} & d;
	end

endmodule
