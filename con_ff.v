module con_ff(input signed[31:0] busMuxOut, input [1:0] IR, input con_en, output reg con_out);
	reg equal, notEqual, pos, neg, flag;
	wire [3:0] decOut;
	
	decoder_2_to_4 decoder(IR, decOut);
	
	always @(*) 
	begin
		
		//Assign result of bus input and 0, and follow the conditional statements
		equal = (busMuxOut == 32'd0) ? 1'b1 : 1'b0;
		notEqual = (busMuxOut != 32'd0) ? 1'b1 : 1'b0;
		pos = (busMuxOut[31] == 0) ? 1'b1 : 1'b0;
		neg = (busMuxOut[31] == 1) ? 1'b1 : 1'b0;
		
		// assign flag with where the which comparison method was flagged
		flag = (decOut[0]&equal | decOut[1]&notEqual | decOut[2]&pos | decOut[3]&neg);
		
		if(con_en)
			con_out = flag;
	end
	
endmodule
