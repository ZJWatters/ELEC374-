module fourToOneMux(output reg [31:0] out, input wire [31:0] a, b, c, d, input wire s0, s1);
	always @(*)
		begin
			out = s1 ? (s0 ? d : c) : (s0 ? b: a);
		end
endmodule
