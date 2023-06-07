`timescale 1ns/1ns

module con_ff_tb;

	reg signed[31:0] busMuxOut;
	reg [1:0] IR;
	reg con_en;
	wire con_out;
	
	con_ff con(busMuxOut, IR, con_en, con_out);
	
	initial 
		begin	
			#5
			busMuxOut<=32'h00000001;
			IR<=2'b00;
			con_en<= 0; // output = 0
			#5
			con_en<=1; 	// output = 1
			#5
			busMuxOut<=32'h00000000;
			IR<=2'b01;
			con_en<=1; // output = 1
			#5
			busMuxOut<=32'hF0000001;
			IR<=2'b10;
			con_en<=1;	// output = 1
			#5
			busMuxOut<=32'h00000001;
			IR<=2'b11;
			con_en<=1;	// output = 1
			#5;
		end
endmodule
