`timescale 1ns/10ps
module control_unit(
	// define the inputs and outputs to your Control Unit
	input [31:0] IRoutput, 
	input clk, reset, stop,
	
	output reg [15:0] Ren_control,
	output reg Gra, Grb, Grc, Rin, Rout, 
	LOselect, HIselect, zlowselect, Zhighselect, MDRselect, Pselect,  
	HIen, LOen, con_en, Pen, IRen, Yen, Zen, 
	MARen, MDRen,
	Out_porten, Cselect, BAout, IncPC,
	In_portselect, Read, Write, clr, run
	);
	
	
	parameter 	reset_state = 7'b0000000, 
					fetch0 = 7'b0000001, 
					fetch1 = 7'b0000010, 
					fetch2 = 7'b0000011,
					ld3 = 7'b0000100,
					ld4 = 7'b0000101,
					ld5 = 7'b0000110,
					ld6 = 7'b0000111,
					ld7 = 7'b0001000,
					ldi3 = 7'b0001001,
					ldi4 = 7'b0001010,
					ldi5 = 7'b0001011,
					st3 = 7'b0001100,
					st4 = 7'b0001101,
					st5 = 7'b0001110,
					st6 = 7'b0001111,
					st7 = 7'b0010000,
					add3 = 7'b0010001,
					add4 = 7'b0010010,
					add5= 7'b0010011,
					sub3 = 7'b0010100,
					sub4 = 7'b0010101,
					sub5 = 7'b0010110,
					and3 = 7'b0010111,
					and4 = 7'b0011000,
					and5 = 7'b0011001,
					or3 = 7'b0011010,
					or4 = 7'b0011011,
					or5 = 7'b0011100,
					shr3 = 7'b0011101,
					shr4 = 7'b0011110,
					shr5 = 7'b0011111,
					shra3 = 7'b0100000,
					shra4 = 7'b0100001,
					shra5 = 7'b0100010,
					shl3 = 7'b0100011,
					shl4 = 7'b0100100,
					shl5 = 7'b0100101,
					ror3 = 7'b0100110,
					ror4 = 7'b0100111,
					ror5 = 7'b0101000,
					rol3 = 7'b0101001,
					rol4 = 7'b0101010,
					rol5 = 7'b0101011,
					addi3 = 7'b0101100,
					addi4 = 7'b0101101,
					addi5 = 7'b0101110,
					andi3 = 7'b0101111,
					andi4 = 7'b0110000,
					andi5 = 7'b0110001,
					ori3 = 7'b0110010,
					ori4 = 7'b0110011,
					ori5 = 7'b0110100,
					mul3 = 7'b0110101,
					mul4 = 7'b0110110,
					mul5 = 7'b0110111,
					mul6 = 7'b0111000,
					div3 = 7'b0111001,
					div4 = 7'b0111010,
					div5 = 7'b0111011,
					div6 = 7'b0111100,
					neg3 = 7'b0111101,
					neg4 = 7'b0111110,
					not3 = 7'b0111111,
					not4 = 7'b1000000,
					br3 = 7'b1000001,
					br4 = 7'b1000010,
					br5 = 7'b1000011,
					br6 = 7'b1000100,
					br7 = 7'b1000101,
					jr3 = 7'b1000110,
					jal3 = 7'b1000111,
					jal4 = 7'b1001000,
					in3 = 7'b1001001,
					out3 = 7'b1001010,
					mfhi3 = 7'b1001011,
					mflo3 = 7'b1001100,
					nop3 = 7'b1001101,
					halt3 = 7'b1001110;
				 
	reg [6:0] present_state = reset_state; // adjust the bit pattern based on the number of states
	
	always @(posedge clk, posedge reset, posedge stop) // finite state machine; if clock or reset rising-edge
		begin
			if (stop == 1'b1) present_state = halt3;
			if (reset == 1'b1) present_state = reset_state;
			else 
				case (present_state)
						reset_state : present_state = fetch0;
						fetch0 : present_state = fetch1;
						fetch1 : present_state = fetch2;
						fetch2 : begin
										case (IRoutput[31:27]) // inst. decoding based on the opcode to set the next state
											5'b00000 : present_state = ld3;
											5'b00001 : present_state = ldi3;
											5'b00010 : present_state = st3;
											5'b00011 : present_state = add3;
											5'b00100 : present_state = sub3;
											5'b00101 : present_state = and3;
											5'b00110 : present_state = or3;
											5'b00111 : present_state = shr3;
											5'b01000 : present_state = shra3;
											5'b01001 : present_state = shl3;
											5'b01010 : present_state = ror3;
											5'b01011 : present_state = rol3;
											5'b01100 : present_state = addi3;
											5'b01101 : present_state = andi3;
											5'b01110 : present_state = ori3;
											5'b01111 : present_state = mul3;
											5'b10000 : present_state = div3;
											5'b10001 : present_state = neg3;
											5'b10010 : present_state = not3;
											5'b10011 : present_state = br3;
											5'b10100 : present_state = jr3;
											5'b10101 : present_state = jal3;
											5'b10110 : present_state = in3;
											5'b10111 : present_state = out3;
											5'b11000 : present_state = mfhi3;
											5'b11001 : present_state = mflo3;
											5'b11010 : present_state = fetch0; // nop3 does nothing
											5'b11011 : present_state = halt3;
											default : present_state = halt3;
										endcase
									end
					// load
					ld3 : present_state = ld4;
					ld4 : present_state = ld5;
					ld5 : present_state = ld6;
					ld6 : present_state = ld7;
					ld7 : present_state = fetch0;
					
					// load immediate
					ldi3 : present_state = ldi4;
					ldi4 : present_state = ldi5;
					ldi5 : present_state = fetch0;
					
					// store
					st3 : present_state = st4;
					st4 : present_state = st5;
					st5 : present_state = st6;
					st6 : present_state = st7;
					st7 : present_state = fetch0;
					
					// add
					add3 : present_state = add4;
					add4 : present_state = add5;
					add5 : present_state = fetch0;
					
					// subtract
					sub3 : present_state = sub4;
					sub4 : present_state = sub5;
					sub5 : present_state = fetch0;
					
					// and
					and3 : present_state = and4;
					and4 : present_state = and5;
					and5 : present_state = fetch0;
					
					// or
					or3 : present_state = or4;
					or4 : present_state = or5;
					or5 : present_state = fetch0;
					
					// shift right
					shr3 : present_state = shr4;
					shr4 : present_state = shr5;
					shr5 : present_state = fetch0;
					
					// shift right arithmetic
					shra3 : present_state = shra4;
					shra4 : present_state = shra5;
					shra5 : present_state = fetch0;
					
					// shift left
					shl3 : present_state = shl4;
					shl4 : present_state = shl5;
					shl5 : present_state = fetch0;
					
					// rotate right
					ror3 : present_state = ror4;
					ror4 : present_state = ror5;
					ror5 : present_state = fetch0;
					
					// rotate left
					rol3 : present_state = rol4;
					rol4 : present_state = rol5;
					rol5 : present_state = fetch0;
					
					// add immediate
					addi3 : present_state = addi4;
					addi4 : present_state = addi5;
					addi5 : present_state = fetch0;
					
					// and immediate
					andi3 : present_state = andi4;
					andi4 : present_state = andi5;
					andi5 : present_state = fetch0;
					
					// or immediate
					ori3 : present_state = ori4;
					ori4 : present_state = ori5;
					ori5 : present_state = fetch0;
					
					// multiply
					mul3 : present_state = mul4;
					mul4 : present_state = mul5;
					mul5 : present_state = mul6;
					mul6 : present_state = fetch0;
					
					// divide
					div3 : present_state = div4;
					div4 : present_state = div5;
					div5 : present_state = div6;
					div6 : present_state = fetch0;
					
					// negate
					neg3 : present_state = neg4;
					neg4 : present_state = fetch0;
					
					// not
					not3 : present_state = not4;
					not4 : present_state = fetch0;
					
					// branch
					br3 : present_state = br4;
					br4 : present_state = br5;
					br5 : present_state = br6;
					br6 : present_state = br7;
					br7 : present_state = fetch0;
					
					// jump and return (only 3)
					jr3 : present_state = fetch0;
					
					// jump and link (only 3)
					jal3 : present_state = jal4;
					jal4 : present_state = fetch0;
					
					// in (only 3)
					in3 : present_state = fetch0;
					
					// out (only 3)
					out3 : present_state = fetch0;
					
					// move from HI (only 3)
					mfhi3 : present_state = fetch0;
					
					// move from LO (only 3)
					mflo3 : present_state = fetch0;
					
					// no-operation (only 3)
					nop3 : present_state = fetch0;
					
					// halt (only 3)
					halt3 : present_state = reset_state;
					
					endcase
		end
		
		
	always @(present_state) // do the job for each state
		begin
			case (present_state) // assert the required signals in each state
					reset_state: begin
						// initilize signals
						clr <= 1;
						Gra <= 0; Grb <= 0; Grc <= 0; Yen <= 0; 
						Yen <= 0; Pselect <= 0; Zhighselect <=0; zlowselect<=0;
						MDRen<=0; MARen<=0; Pen<=0; MDRselect<=0; 
						IRen<=0; IncPC<=0; Read<=0;
						HIen<=0; LOen<=0; HIselect<=0; LOselect<=0;
						Zen<=0; Cselect<=0; Write<=0; Rin<=0;
						Rout<=0; BAout<=0; con_en<=0; Out_porten<=0; In_portselect<=0;
						#5
						run<=1; clr<=0;
					end
					
					// --------------------------------------- T0-T2
					fetch0: begin
						Pselect<=1; MARen<=1; IncPC<=1; Zen<=1;
					end
					fetch1: begin
						Pselect<=0; MARen<=0; IncPC<=0; Zen<=0;
						
						zlowselect<=1; Pen<=1; Read<=1; MDRen<=1;  
					end
					fetch2: begin
						zlowselect<=0; Pen<=0; Read<=0; MDRen<=0;
						
						MDRselect<=1; IRen<=1;
						#18;
						MDRselect<=0; IRen<=0;
						end
					
					// --------------------------------------- load 
					ld3: begin 
						Grb<=1; BAout<=1; Yen<=1;
					end
					ld4: begin
						Grb<=0; BAout<=0; Yen<=0;
						
						Cselect<=1; Zen<=1;
					end
					ld5: begin 
						Cselect<=0; Zen<=0;
						
						zlowselect<=1; MARen<=1;
					end
					ld6: begin
						zlowselect<=0; MARen<=0;
						
						Read<=1; MDRen<=1;
					end
					ld7: begin 
						Read<=0; MDRen<=0;
						
						MDRselect<=1; Gra<=1; Rin<=1;
						#10
						Rin<=0;
						#8
						MDRselect<=0; Gra<=0;	 
					end
					
					// --------------------------------------- load immediate
					ldi3: begin
						 Grb<=1; BAout<=1; Yen<=1;
					end
					ldi4: begin
						 Grb<=0; BAout<=0; Yen<=0;
						 
						 Cselect<=1; Zen<=1; 
					end
					ldi5: begin
						 Cselect<=0; Zen<=0; 
						 
						 zlowselect<=1; Gra<=1; Rin<=1;
						 #10
						 Rin<=0;
						 #8
						 zlowselect<=0; Gra<=0; 
					end
					
					// --------------------------------------- store 
					
					st3: begin
						Grb<=1; BAout<=1; Yen<=1;
					end
					st4: begin
						Grb<=0; BAout<=0; Yen<=0;
						
						Cselect<=1; Zen <= 1;
					end
					st5: begin
						Cselect<=0; Zen<=0;
						
						zlowselect<=1; MARen<=1;
					end
					st6: begin
						zlowselect<=0; MARen<=0;
						
						Read<=1; Gra<=1; Rout<=1; MDRen<=1; //read = 0??
					end
					st7: begin
						Read<=0; Gra<=0; Rout<=0; MDRen<=0;
						
						MDRselect<=1; 
						#2
						Write<=1;
						#16
						MDRselect<=0; Write<=0;
					end
					
					// ---------------------------------------  add/subtract
					add3, sub3: begin
						Grb<=1; Rout<=1; Yen<=1;
					end
					add4, sub4: begin
						Grb<=0; Rout<=0; Yen<=0;
						
						Grc<=1; Rout<=1; Zen<=1;
					end
					add5, sub5: begin
						Grc<=0; Rout <= 0; Zen <= 0;
						
						zlowselect<=1; Gra<=1; Rin<=1;
						#10
						Rin<=0;
						#8
						zlowselect<=0; Gra<=0;
					end
					
					// -------------------------------------- and/or/shl/shr/shra/rol/ror
										
					or3, and3, shl3, shr3, shra3, rol3, ror3: begin
						Grb<=1; Rout<=1; Yen<=1;
					end
					or4, and4, shl4, shr4, shra4, rol4, ror4: begin
						Grb<=0; Rout<=0; Yen<=0;
						
						Grc<=1; Rout<=1; Zen<=1;
					end
					or5, and5, shl5, shr5, shra5, rol5, ror5: begin
						Grc<=0; Rout<=0; Zen<=0;
						
						zlowselect<=1; Gra<=1; Rin<=1;
						#10
						Rin<=0;
						#8
						zlowselect<=0; Gra<=0; 
					end

					// -------------------------------------- multiply/divide
					
					mul3, div3: begin
						Gra<=1; Rout<=1; Yen<=1;
					end
					mul4, div4: begin
						Gra<=0; Rout<=0; Yen<=0;
						
						Grb<=1; Rout<=1; Zen<=1;
					end
					mul5, div5: begin
						Grb<=0; Rout<=0; Zen<=0;
						
						zlowselect<=1; LOen<=1;
					end
					mul6, div6: begin
						zlowselect<=0; LOen<=0;
						
						Zhighselect<=1; HIen<=1;
						#18
						Zhighselect<=0; HIen<=0;
					end

					// -------------------------------------- negate/not
					
					not3, neg3: begin
						Grb<=1; Rout<=1; Zen<=1;
					end
					not4, neg4: begin
						Grb<=0; Rout<=0; Zen<=0;
						
						zlowselect<=1; Gra<=1; Rin<=1;
						#10
						Rin<=0;
						#8
						zlowselect<=0; Gra<=0;
					end
					
					// -------------------------------------- andi
					
					andi3: begin
						Grb<=1; Rout<=1; Yen<=1;
					end
					andi4: begin
						Grb<=0; Rout<=0; Yen<=0;
						
						Cselect<=1; Zen<=1;
					end
					andi5: begin
						Cselect<=0; Zen<=0;
						
						zlowselect<=1; Gra<=1; Rin<=1;
						#10
						Rin<=0;
						#8
						zlowselect<=0; Gra<=0;
					end
					
					// -------------------------------------- addi/ori
					
					addi3, ori3: begin
						Grb<=1; Rout<=1; Yen<=1;
					end
					addi4, ori4: begin
						Grb<=0; Rout<=0; Yen<=0;

						Cselect<=1; Zen<=1;
					end
					addi5, ori5: begin
						Cselect<=0; Zen<=0;
						
						zlowselect<=1; Gra<=1; Rin<=1;
						#10
						Rin<=0;
						#8
						zlowselect<=0; Gra<=0;
					end
					
					// -------------------------------------- jr
					
					jr3: begin
						Gra<=1; Rout<=1; Pen<=1;
						#18
						Gra<=0; Rout<=0; Pen<=0;
					end
			
					// -------------------------------------- jal
					
					jal3: begin
						Pselect<=1; Ren_control<=16'h8000;
					end
					jal4: begin
						Pselect<=0; Ren_control<=16'h0000; 
						
						Gra<=1; Rout<=1; Pen<=1;
						#18
						Gra<=0; Rout<=0; Pen<=0;
					end
					
					// -------------------------------------- mfhi
					
					mfhi3: begin
						Gra<=1; Rin<=1; HIselect<=1;
						#18
						Gra<=0; Rin<=0; HIselect<=0;
					end
					
					// -------------------------------------- mflo
					
					mflo3: begin
						Gra<=1; Rin<=1; LOselect<=1;
						#18 
						Gra<=0; Rin<=0; LOselect<=0;
					end
					
					// -------------------------------------- in
					
					in3: begin
						Gra<=1; Rin<=1; In_portselect<=1;
						#18
						Gra<=1; Rin<=0; In_portselect<=0;
					end

					// -------------------------------------- out
					
					out3: begin
						Gra<=1; Rout<=1; Yen<=1; Out_porten<=1;
						#18
						Gra<=0; Rout<=0; Yen<=0; Out_porten<=0;
					end

					// -------------------------------------- branch
					
					br3: begin
						Gra<=1; Rout<=1; con_en<=1;
					end
					br4: begin
						Gra<=0; Rout<=0; con_en<=0;
						
						Pselect<=1; Yen<=1;
					end
					br5: begin
						Pselect<=0; Yen<=0;
						
						Cselect<=1; Zen<=1;
					end
					br6: begin
						Cselect<=0; Zen<=0;
						
						zlowselect<=1; Pen<=1;
					end
					br7: begin
						zlowselect<=0; Pen<=0;
						
						Pselect<=1;
						#18
						Pselect<=0;
					end
					
					// -------------------------------------- halt
					halt3: begin
						run<=0;
					end
					
					// -------------------------------------- default
					
					default: begin
					end
		 endcase
	end
endmodule
