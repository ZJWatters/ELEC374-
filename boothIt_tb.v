`timescale 1ns/1ns

module boothIt_tb;

reg [31:0] a, b;
wire [63:0] c;

boothIt multiply(a,b,c);

initial
	begin
		a = 2;
		b = 2;
		#10
		
		a = -2;
		b = 2;
		#10
		a = 0;
		b = 0;
		
	end
	
endmodule
