`timescale 1ns/1ns

module ThirtyTwoToFiveEncoder_tb;
	wire [4:0] out;
	reg [31:0] data;
	
	ThirtyTwoToFiveEncoder uut(
	.out(out),
	.data(data)
	);
	
	initial 
		begin
			#20;
			data = 32'h00000000;
			#40;
			data = 32'h00000010;
			#40;
		end
endmodule

			
	