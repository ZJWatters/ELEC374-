`timescale 1ns/10ps
module control_unit_tb;
	 reg clk, stop, reset;
    reg [31:0] In_PortIN;
	 wire [31:0] Out_PortOUT;

	 wire [4:0] op;
	 wire [31:0] BusMuxOut;
	 wire[63:0] alu_result;
	
	datapath dataPath_instance( .clk(clk), .stop(stop), .reset(reset), .In_PortIN(In_PortIN), 
	.Out_PortOUT(Out_PortOUT), .op(op), .BusMuxOut(BusMuxOut), .alu_result(alu_result)
	);
	
	initial
		begin
			clk = 0;
			stop = 0;
			reset = 0;
		end
		
	always
		begin
			#10 clk <= ~clk;
		end
endmodule
