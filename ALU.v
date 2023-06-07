module ALU(input [31:0] b, y, input [4:0] control, input con_flag, input IncPC, output reg [63:0] result);
	//Y register is the 'temp register' that holds the value 
	
	wire [31:0] addOut, subOut;
	wire [63:0] mulOut, divOut;
	reg first, last; 
	wire cOutAdd,cOutSub;
	reg [31:0] temp;
	
	//Subtraction
	
	carryRippleAdder crSub(
	.a (y),
	.b (-b),
	.cin(1'b0),
	.s (subOut),
	.cout(cOutSub));
	
	
	//Addition
	
	carryRippleAdder cra(
	.a (y),
	.b (b),
	.cin(1'b0),
	.s (addOut),
	.cout(cOutAdd));
	
	
	//Multiplication 
	
	boothIt mul(
	.a (y),
	.b (b),
	.c (mulOut));
	
	
	//Division
	
	divider div(
	.a (y),
	.b (b),
	.q (divOut));
	
	parameter	or_opcode = 5'b00110,
					ori_opcode = 5'b01110,
               and_opcode = 5'b00101,
					andi_opcode = 5'b01101,
               shr_opcode = 5'b00111,
               shra_opcode = 5'b01000,
               shl_opcode = 5'b01001,
               ror_opcode = 5'b01010,
               rol_opcode = 5'b01011,
               negate_opcode = 5'b10001,
               not_opcode = 5'b10010,
               ADD_opcode = 5'b00011,
					addi_opcode = 5'b01100,
               SUBTRACT_opcode = 5'b00100,
               MULTIPLY_opcode = 5'b01111,
               DIVISION_opcode = 5'b10000,
               INCREMENT_opcode = 5'b11111,
					branch_opcode = 5'b10011,
					jr_opcode = 5'b10100,
					jal_opcode = 5'b10101,
					in_opcode = 5'b10110,
					out_opcode = 5'b10111,
					mfhi_opcode = 5'b11000,
					mflo_opcode = 5'b11001,
					nop_opcode = 5'b11010,
					halt_opcode = 5'b11011,
					ld_opcode = 5'b00000,
					ldi_opcode = 5'b00001,
					st_opcode = 5'b00010;
					
	
	// Controls which output comes out of the ALU
	// Idea is that all the modules will do all their calculations, then this opcode
	// will select the output that goes into the result output
	
	// Note: Most of the operations only use the first 32 bits, the high 32 bits are
	// only used for the multiplication and the division factors.  
	always @(*)
	begin
		if(IncPC == 1) begin
                result[31:0] = b[31:0] + 1'b1;
                result[63:32] = 32'h00000000;
		end
		else begin
			case(control)
				or_opcode: begin 
					result[31:0] = y | b;
					result[63:32] = 32'h00000000;
				end
				and_opcode: begin
					result[31:0] = y & b;
					result[63:32] = 32'h00000000;
				end
				shr_opcode: begin	
					result[31:0] = y >> b;
					result[63:32] = 32'h00000000;
				end
				shra_opcode: begin	
					result[31:0] = $signed(y)>>>b;
					result[63:32] = 32'h00000000;
				end
				shl_opcode: begin
					result[31:0] = y << b;
					result[63:32] = 32'h00000000;
				end
				ror_opcode: begin
					
					case(b[4:0])
						5'd31: 	result <= {y[30:0], y[31]};
						5'd30: 	result <= {y[29:0], y[31:30]};
						5'd29: 	result <= {y[28:0], y[31:29]};
						5'd28: 	result <= {y[27:0], y[31:28]};
						5'd27: 	result <= {y[26:0], y[31:27]};
						5'd26: 	result <= {y[25:0], y[31:26]};
						5'd25: 	result <= {y[24:0], y[31:25]};
						5'd24: 	result <= {y[23:0], y[31:24]};
						5'd23: 	result <= {y[22:0], y[31:23]};
						5'd22: 	result <= {y[21:0], y[31:22]};
						5'd21: 	result <= {y[20:0], y[31:21]};
						5'd20: 	result <= {y[19:0], y[31:20]};
						5'd19: 	result <= {y[18:0], y[31:19]};
						5'd18: 	result <= {y[17:0], y[31:18]};
						5'd17: 	result <= {y[16:0], y[31:17]};
						5'd16:  result <= {y[15:0], y[31:16]};
						5'd15:  result <= {y[14:0], y[31:15]};
						5'd14:  result <= {y[13:0], y[31:14]};
						5'd13:  result <= {y[12:0], y[31:13]};
						5'd12:  result <= {y[11:0],y[31:12]};
						5'd11:  result <= {y[10:0],y[31:11]};
						5'd10:  result <= {y[9:0], y[31:10]};
						5'd9:   result <= {y[8:0], y[31:9]};
						5'd8:   result <= {y[7:0], y[31:8]};
						5'd7:   result <= {y[6:0], y[31:7]};
						5'd6:   result <= {y[5:0], y[31:6]};
						5'd5:   result <= {y[4:0], y[31:5]};
						5'd4:   result <= {y[3:0], y[31:4]};
						5'd3:   result <= {y[2:0], y[31:3]};
						5'd2:	result <= {y[1:0], y[31:2]};
						5'd1:	result <= {y[0], y[31:1]};
						default: result <= y;
					endcase
				end
				rol_opcode: begin	
				
					case(b[4:0])
						5'd1 : result <= {y[30:0], y[31]};
						5'd2 : result <= {y[29:0], y[31:30]};
						5'd3 : result <= {y[28:0], y[31:29]};
						5'd4 : result <= {y[27:0], y[31:28]};
						5'd5 : result <= {y[26:0], y[31:27]};
						5'd6 : result <= {y[25:0], y[31:26]};
						5'd7 : result <= {y[24:0], y[31:25]};
						5'd8 : result <= {y[23:0], y[31:24]};
						5'd9 : result <= {y[22:0], y[31:23]};
						5'd10: result <= {y[21:0], y[31:22]};
						5'd11: result <= {y[20:0], y[31:21]};
						5'd12: result <= {y[19:0], y[31:20]};
						5'd13: result <= {y[18:0], y[31:19]};
						5'd14: result <= {y[17:0], y[31:18]};
						5'd15: result <= {y[16:0], y[31:17]};
						5'd16: result <= {y[15:0], y[31:16]};
						5'd17: result <= {y[14:0], y[31:15]};
						5'd18: result <= {y[13:0], y[31:14]};
						5'd19: result <= {y[12:0], y[31:13]};
						5'd20: result <= {y[11:0], y[31:12]};
						5'd21: result <= {y[10:0], y[31:11]};
						5'd22: result <= {y[9:0], y[31:10]};
						5'd23: result <= {y[8:0], y[31:9]};
						5'd24: result <= {y[7:0], y[31:8]};
						5'd25: result <= {y[6:0], y[31:7]};
						5'd26: result <= {y[5:0], y[31:6]};
						5'd27: result <= {y[4:0], y[31:5]};
						5'd28: result <= {y[3:0], y[31:4]};
						5'd29: result <= {y[2:0], y[31:3]};
						5'd30: result <= {y[1:0], y[31:2]};
						5'd31: result <= {y[0], y[31:1]};
						default: result <= y;
						endcase					
				end
				negate_opcode: begin
					result[31:0] = -b;
					result[63:32] = 32'h00000000;
				end
				not_opcode: begin
					result[31:0] = ~b;
					result[63:32] = 32'h00000000;
				end
				ADD_opcode, ldi_opcode, ld_opcode, st_opcode: begin
					result[31:0] = addOut[31:0];
					result[63:32] = 32'h00000000;
				end
				SUBTRACT_opcode: begin
					result[31:0] = subOut[31:0];
					result[63:32] = 32'h00000000;
				end
				MULTIPLY_opcode: begin
					result[63:0] = mulOut[63:0];
				end
				DIVISION_opcode: begin
					result = divOut[63:0];
				end
				INCREMENT_opcode: begin
					result[31:0] = b[31:0] + 1'b1;
					result[63:32] = 32'h00000000;
				end
				branch_opcode: begin	
					if(con_flag) begin
								result[31:0] <= addOut[31:0];
								result[63:32] <= 32'd0;
					end
					else begin
								result[31:0] <= y;
								result[63:32] <= 32'd0;
					end
				end
				default: begin
					result = 64'h0000000000000000;
				end
			endcase
		end 
	end 
endmodule
