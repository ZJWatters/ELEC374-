`timescale 1ns/1ns

module ALU_tb;

	reg [31:0]a, b, y; 
	reg [4:0] control; 
	reg con_flag;
	wire [63:0] result;
	
	ALU alu(b,y,control, con_flag, result);
	
	initial 
		begin 
			//Test 1 - worked
			#10
			a = 32'h00000001;
			b = 32'h00000010;
			y = a;
			control = 32'h00000000; //or_opcode, result will be 32'h00000011
			#100
			// Test 2 - worked
			y=a;
			#10
			control = 32'h00000001; // nor_opcode, result will be 32'hFFFFFFEE
			#100
			//Test 3 - worked
			a = 32'h0000FFFF;
			b = 32'h0000F000;
			y=a;
			#10
			control = 32'h00000002; // and_opcode, result will be 32'h0000F000
			#100
			//Test4 - worked
			a = 32'h00000001;
			b = 32'h00000010;
			y=a;
			#10
			control = 32'h00000003; // nand_opcode, result will be 32'hFFFFFFFF
			#100
			//Test 5 - worked
			a = 32'h000000F0;
			y=a;
			#10
			control = 32'h00000004; // shr_opcode, result will be 32'h00000000
			#100
			// Test 6 - worked
			a = 32'h10000001;
			y = a;
			#10
			control = 32'h00000005; //shra_opcode, result will be 32'h08000000
			#100
			// Test 7 - worked
			a = 32'h80000001;
			b = 32'h00000010;
			y = a;
			#10
			control = 32'h00000006; // shl_opcode, result will be 32'h00000002
			#100
			//Test 8 - worked
			a = 32'h00000001;
			y=a;
			#10
			control = 32'h00000007; // ror_opcode, result will be 32'h80000000
			#100
			//Test 9 - worked
			y=32'h80000001;
			#10
			control = 32'h00000008; // rol_opcode, result will be 32'h00000003
			#100
			//Test 10 - worked
			a = 32'h000000F0;
			y=a;
			#10
			control = 32'h00000009; // negate_opcode, result will be 32'hFFFFFFFF
			#100
			// Test 11 - worked
			a = 32'h00000001;
			y=a;
			#10
			control = 32'h0000000A; // not_opcode, result will be 32'hFFFFFFFE
			#100
			//Test 12 - worked
			a = 32'h400000F0;
			b = 32'h4000F000;
			y=a;
			#10
			control = 32'h0000000B; // ADD_opcode, result will be 32'h0000000A;
			#100
			//Test 13 - worked
			a = 32'h00000001;
			b = 32'h00000010;
			y=a;
			#10
			control = 32'h0000000C; // SUBTRACT_opcode, result will be 32'h00000011 = -15 2's comp
			#100
			//Test 14 - worked
			a = 32'h00000001;
			b = 32'h00000010;
			y=a;
			#10
			control = 32'h0000000D; // MULTIPLY_opcode, result will be 32'h00000010
			#100
			//Test 15 - result was 32'hzzzz0000
			a = 32'h00000001;
			b = 32'h00000010;
			y=a;
			#10
			control = 32'h0000000E; // DIVISION_opcode, result will be 0 R1
			#100
			//Test 16 - worked
			a = 32'h00000001;
			b = 32'h00000010;
			y=a;
			#10
			control = 5'b11111; // INCREMENT_opcode, result will be 32'h00000014
			#100;
		end
endmodule
		