`timescale 1ns/1ns

module divider_tb;

reg [31:0] a, b;
wire [31:0] q;

divider div(a,b,q);

initial
	begin
		a = 4;
		b = 2;
		#10
		
		a = 16;
		b = 4;
		#10
		
		a = 0;
		b = 1;
	end
endmodule

