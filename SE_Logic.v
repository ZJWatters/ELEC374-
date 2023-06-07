module SE_Logic(input Gra, Grb, Grc, Rin, Rout, BAout, input [31:0] instr,
					  output [4:0] op, output [15:0] Ren, Rselect, output [31:0] C_Sign_Extnd);
					 
	wire [3:0] decIn;
	wire [15:0] decOut;
	//selects which register is being selected right now (Control Unit will assign Gra,b,c values on its own in phase 3)
	assign decIn = (instr[26:23]&{4{Gra}}) | (instr[22:19] & {4{Grb}}) | (instr[18:15] & {4{Grc}});
	
	fourToSixteen_dec dec(decIn, decOut);
	
	//opcode
	
	assign op = instr[31:27];
	
	//Extend output register sign
	
	assign C_Sign_Extnd = {{13{instr[18]}}, instr[18:0]};
	
	//Assign the select and enable signals that will eventually go into biBus
	assign Ren = {16{Rin}} & decOut;
	assign Rselect = ({16{Rout}} | {16{BAout}}) & decOut;
	

endmodule
	