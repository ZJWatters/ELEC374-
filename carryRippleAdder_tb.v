`timescale 1ns/1ns

module carryRippleAdder_tb;
reg [31:0] a, b;
wire [31:0] out;
reg cin;
wire cout;

carryRippleAdder adder(a,b,cin,out,cout);

initial
	begin
	a = 1;
	b = 1;
	cin = 0;
	#10
	a = 2;
	b = 2;
	#10;
	a = 4;
	b = -2;
	#10;
	a = -4;
	b =2;
	#10;

	end
endmodule

	