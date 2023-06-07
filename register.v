module register #(parameter qInit = 0)(input clr, clk, enable, input[31:0] d, output reg [31:0] q);
	initial 
		q<= qInit;
	 
	always @(*) begin
		if(clr)
			q <= 32'h00000000;
		else if(enable)
			q <= d;
	end

endmodule
