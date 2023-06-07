module thirtyTwoToOneMultiplexer(input wire[31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16,
												 in17, in18, in19, in20, in21, in22, in23,
												  input wire [4:0] select, output reg[31:0] out);
	 
		 wire[31:0] mux0Out, mux1Out, mux2Out, mux3Out, mux4Out, mux5Out, mux8Out, mux9Out, mux10Out;
		 
		 fourToOneMux mux0(mux0Out, in0, in1, in2, in3, select[0], select[1]);
		 fourToOneMux mux1(mux1Out, in4, in5, in6, in7, select[0], select[1]);
		 fourToOneMux mux2(mux2Out, in8, in9, in10, in11, select[0], select[1]);
		 fourToOneMux mux3(mux3Out, in12, in13, in14, in15, select[0], select[1]);
		 fourToOneMux mux4(mux4Out, in16, in17, in18, in19, select[0], select[1]);
		 fourToOneMux mux5(mux5Out, in20, in21, in22, in23, select[0], select[1]);
			
		 fourToOneMux mux8(mux8Out, mux0Out, mux1Out, mux2Out, mux3Out, select[2], select[3]);
		 fourToOneMux mux9(mux9Out, mux4Out, mux5Out, 32'h00000000, 32'h00000000, select[2], select[3]);
		 
		 fourToOneMux mux10(mux10Out, mux8Out, mux9Out, 32'h00000000,32'h00000000, select[4], 1'b0);
		 
		 always @(*)
			begin
				 out = mux10Out;											
			end
endmodule 