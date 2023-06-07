`timescale 1ns/1ns

module SE_Logic_tb;

	reg Gra, Grb, Grc, Rin, Rout, BAout;
	reg [31:0] instr;
	wire [4:0] op;
	wire [15:0] Ren, Rselect;
	wire [31:0] C_Sign_Extnd;
	
	SE_Logic lol(Gra, Grb, Grc, Rin, Rout, BAout, instr, op, Ren, Rselect, C_Sign_Extnd);
	
	initial 
		begin
			#10
			Gra <= 0; Grb <= 0; Grc<=0; Rin<=0; Rout<=0; BAout<=0;
			instr<=32'h00000000;
			#10
			Gra<=1; // out should be 16'h0002
			Rin<=1;
			Rout<=1;
			instr<=32'b00000000100101111000000000000000; //op = 00000, Ra = 0001, Rb = 0010, Rc = 0011, 14bits = 0
			#10
			Gra<=0; // out should be 16'h0002
			Grb<=1;
			Rin<=1;
			Rout<=0;
			instr<=32'b11111000100100101000000000000000;
			#10
			Grb<=0; // out should be 16'h0002
			Grc<=1;
			Rin<=0;
			BAout<=1;
			instr<=32'b10000000100100011000000000000000;	
		end
endmodule
