module In_Port(input clr, clk, input[31:0] d, output reg [31:0] q);

	always @(*) begin
		if(clr)
			q <= 32'h00000000;
		else
			q <= d;
	end

endmodule
