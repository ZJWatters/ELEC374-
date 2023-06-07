`timescale 1ns/1ns

module CU_tb;
	reg [31:0] IRoutput;
	reg clk, reset, stop;
	
	wire [15:0] Ren_control;
	wire Gra, Grb, Grc, Rin, Rout, 
	LOselect, HIselect, zlowselect, Zhighselect, MDRselect, Pselect,  
	HIen, LOen, con_en, Pen, IRen, Yen, Zen, 
	MARen, MDRen,
	Out_porten, Cselect, BAout, IncPC,
	In_portselect, Read, Write, clr, run;
	
	control_unit CU(.IRoutput(IRoutput), .clk(clk), .reset(reset), .stop(stop),
	.Ren_control(Ren_control),
	.Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), 
	.LOselect(LOselect), .HIselect(HIselect), .zlowselect(zlowselect), .Zhighselect(Zhighselect), .MDRselect(MDRselect), .Pselect(Pselect),  
	.HIen(HIen), .LOen(LOen), .con_en(con_en), .Pen(Pen), .IRen(IRen), .Yen(Yen), .Zen(Zen), 
	.MARen(MARen), .MDRen(MDRen),
	.Out_porten(Out_porten), .Cselect(Cselect), .BAout(BAout), .IncPC(IncPC),
	.In_portselect(In_portselect), .Read(Read), .Write(Write), .clr(clr), .run(run));
	
	initial 
		begin	
			clk = 0;
			reset = 0;
			stop = 0;
			IRoutput = 32'b00010000000000000000000000000000;
			#170
			IRoutput = 32'b00110000000000000000000000000000;
			#170
			stop = 1;
		end

	always begin
			#10 
			clk = ~clk;
		end
		
endmodule
