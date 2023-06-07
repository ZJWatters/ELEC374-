module TwoToOneMux(input wire clk, Read, input wire [31:0] busMuxOut, input wire [31:0] Mdatain, output reg [31:0] out);
	always@(*) begin
		if (Read) 
			out[31:0] <= Mdatain[31:0];
		else 
			out[31:0] <= busMuxOut[31:0];
	end
endmodule
