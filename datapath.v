module datapath(
	 input wire clk, stop, reset,
     //en = ENABLE, Allows register to be written to.
	  //R15en, HIen, LOen, Zen,
     //Pen, MDRen, In_Porten, Cen, IRen, MARen, Yen,
     //con_en, OutPorten, Write, 

     //select, Allows bus to read register contents.
     //HIselect, LOselect, Zhighselect, zlowselect,
     //Pselect, MDRselect, In_Portselect, Cselect, Read,
	  
	  //input wire [4:0] alu_control,
     //input wire [31:0] Mdatain,
     input wire [31:0] In_PortIN, 
	  output wire [31:0] Out_PortOUT,
     //input Gra, Grb, Grc, Rin, Rout, BAout, run, reset, IncPC,
     
     //output [31:0] C_Sign_Extnd,
     //output wire [15:0] Ren, Rselect
	  output [4:0] op,
	  output [31:0] BusMuxOut,
	  output [63:0] alu_result
	); 
	
	wire Gra, Grb, Grc, Rin, Rout, BAout;
	wire HIen, LOen, Pen, Zen, Yen, MDRen, MARen, Out_Porten, Cen, IRen, con_en, Write, Read;
	wire HIselect, LOselect, Zhighselect, zlowselect, Pselect, MDRselect, In_Portselect, Cselect, IncPC;
	wire con_out, run, clr;
	
	//Instantiate the internal register outputs
	
	reg [15:0] Ren, Rselect;
	
	
	
	wire [31:0] R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZhighBusIn, zlowBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, IRoutput, ramDataOut, alu_input, C_Sign_Extnd, busMuxOut;
	wire [15:0] Ren_control, Rselect_control, Ren_se, Rselect_se;				
	wire [8:0] MARoutput;
	
	assign BusMuxOut = busMuxOut;
	
	//Create Registers
	register0 r0 (clr, clk, Ren[0], BAout, busMuxOut, R0BusIn);
	register r1 (clr, clk, Ren[1], busMuxOut, R1BusIn);
	register r2 (clr, clk, Ren[2], busMuxOut, R2BusIn);
	register r3 (clr, clk, Ren[3], busMuxOut, R3BusIn);
	register r4 (clr, clk, Ren[4], busMuxOut, R4BusIn);
	register r5 (clr, clk, Ren[5], busMuxOut, R5BusIn);
	register r6 (clr, clk, Ren[6], busMuxOut, R6BusIn);
	register r7 (clr, clk, Ren[7], busMuxOut, R7BusIn);
	register r8 (clr, clk, Ren[8], busMuxOut, R8BusIn);
	register r9 (clr, clk, Ren[9], busMuxOut, R9BusIn);
	register r10 (clr, clk, Ren[10], busMuxOut, R10BusIn);
	register r11 (clr, clk, Ren[11], busMuxOut, R11BusIn);
	register r12 (clr, clk, Ren[12], busMuxOut, R12BusIn);
	register r13 (clr, clk, Ren[13], busMuxOut, R13BusIn);
	register r14 (clr, clk, Ren[14], busMuxOut, R14BusIn);
	register r15 (clr, clk, Ren[15], busMuxOut, R15BusIn);
	
	//other registers
	In_Port IP(clr, clk, In_PortIN, InPortBusIn);
	register Out_Port(clr, clk, Out_Porten, busMuxOut, Out_PortOUT);
	register PCreg(clr, clk, Pen, busMuxOut, PCBusIn);
   register IRreg(clr, clk, IRen, busMuxOut, IRoutput);
   register Yreg(clr, clk, Yen, busMuxOut, alu_input);
   register ZLoReg(clr, clk, Zen, alu_result[31:0], zlowBusIn);
	register ZHiReg(clr, clk, Zen, alu_result[63:32], ZhighBusIn);
   register HIreg(clr, clk, HIen, busMuxOut, HIBusIn);
   register LOreg(clr, clk, LOen, busMuxOut, LOBusIn);
	
	//memory registers
	MDR mdr(.busMuxOut(busMuxOut), .Mdatain(ramDataOut), .read(Read), .clr(clr), .clk(clk), .en(MDRen), .Q(MDRBusIn));
	mar maR(.busMuxOut(busMuxOut), .MARen(MARen), .clr(clr), .clk(clk), .Q(MARoutput));

	always@(*)begin
		if (Ren_se) Ren<=Ren_se;
		else Ren<=Ren_control;
		if (Rselect_se) Rselect<=Rselect_se;
		else Rselect<=16'b0;
	end
	
	
	ALU aluDP(
	.b(busMuxOut),
	.y(alu_input),
	.control(op),
	.IncPC(IncPC),
	.con_flag(con_out),
	.result(alu_result)
	);
	
	SE_Logic se( 
	 .Gra(Gra), .Grb(Grb), .Grc(Grc),
	 .Rin(Rin), .Rout(Rout), .BAout(BAout),
	 .instr(IRoutput),
	 .op(op),
	 .Ren(Ren_se), .Rselect(Rselect_se),
	 .C_Sign_Extnd(C_Sign_Extnd)
	);
	
	con_ff con( 
	.busMuxOut(busMuxOut),
	.IR(IRoutput[20:19]), 
	.con_en(con_en), .con_out(con_out)
	);
	
	ram Ramdp(
	.clk(clk),
	.read(Read),
	.write(Write), 
	.dataIn(MDRBusIn), 
	.address(MARoutput),
	.dataOut(ramDataOut)
	);
	
	control_unit control( .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .LOselect(LOselect), .HIselect(HIselect), .zlowselect(zlowselect), .Zhighselect(Zhighselect), .MDRselect(MDRselect), .Pselect(Pselect), .Cselect(Cselect), .IncPC(IncPC), .In_portselect(In_Portselect), 
	.HIen(HIen), .LOen(LOen), .con_en(con_en), .Pen(Pen), .IRen(IRen), .Yen(Yen), .Zen(Zen), .MARen(MARen), .MDRen(MDRen), .Out_porten(Out_Porten), .Read(Read), .Write(Write), .clr(clr), .run(run), .Ren_control(Ren_control),
	.IRoutput(IRoutput), .clk(clk), .reset(reset), .stop(stop)
	);
	
	biBus bus(Rselect[0], Rselect[1], Rselect[2], Rselect[3], Rselect[4], Rselect[5], Rselect[6], Rselect[7], Rselect[8], Rselect[9],
	 Rselect[10], Rselect[11], Rselect[12], Rselect[13], Rselect[14], Rselect[15], HIselect, LOselect, Zhighselect, zlowselect,
	 Pselect, MDRselect, In_Portselect, Cselect, R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZhighBusIn, zlowBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd, busMuxOut
	);
endmodule
