module decoder_2_to_4(input [1:0] decIn, output reg[3:0] decOut);

	always @(*)
		begin
		
		case(decIn)
			2'b00 : decOut = 4'b0001;
			2'b01 : decOut = 4'b0010;
			2'b10 : decOut = 4'b0100;
			2'b11 : decOut = 4'b1000;
		endcase
		
	end
endmodule
