`timescale 1ns/10ps

module ldi_tb;
    reg clr, clk; 
	 reg R15en, HIen, LOen, Zen, Pen, MDRen, In_Porten, Cen, IRen, MARen, Yen, con_en, RAMen, OutPorten, write;
	   
	 reg HIselect, LOselect, Zhighselect, zlowselect,
     Pselect, MDRselect, In_Portselect, Cselect, Read, RAMselect;
	  
	 reg Gra, Grb, Grc, Rin, Rout, BAout;
     
    reg [31:0] In_PortIN;
	 wire [31:0] Out_PortOUT;
    reg [4:0] alu_control; 
	 reg [31:0] Mdatain;
	 wire [4:0] op;
	 wire [31:0] C_Sign_Extnd;
    wire [15:0] Ren, Rselect;
     
	 parameter Default = 4'b0000; 
    parameter T0 = 4'b0001; 
    parameter T1 = 4'b0010; 
    parameter T2 = 4'b0011; 
    parameter T3 = 4'b0100; 
    parameter T4 = 4'b0101;
	 parameter T5 = 4'b0110;
	 parameter T6 = 4'b0111;
	 parameter T7 = 4'b1000;
    reg [3:0] Present_state = Default;
     
    datapath dut(.clr(clr), .clk(clk), .R15en(R15en), .HIen(HIen), .LOen(LOen), .Zen(Zen), 
         .Pen(Pen), .MDRen(MDRen), .In_Porten(In_Porten), .Cen(Cen), .IRen(IRen), .MARen(MARen), .Yen(Yen), .con_en(con_en), .RAMen(RAMen),
			.OutPorten(OutPorten), .write(write),
         .HIselect(HIselect), .LOselect(LOselect), .Zhighselect(Zhighselect), .zlowselect(zlowselect),
         .Pselect(Pselect), .MDRselect(MDRselect),  .In_Portselect(In_Portselect), .Cselect(Cselect), .Read(Read), .RAMselect(RAMselect), 
			.Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .In_PortIN(In_PortIN), .Out_PortOUT(Out_PortOUT),
         .op(op), .C_Sign_Extnd(C_Sign_Extnd), .Ren(Ren), .Rselect(Rselect), .alu_control(alu_control), .Mdatain(Mdatain));
     
    initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
    end

always @(posedge clk)
begin
	case (Present_state)
		Default			: Present_state = T0;
		T0					: Present_state = T1;
		T1					: Present_state = T2;
		T2					: Present_state = T3;
		T3					: Present_state = T4;
		T4					: Present_state = T5;
		endcase
	end
	
always @(Present_state)// do the required job in each state
begin
	case (Present_state)				//assert the required signals in each clock cycle
	
	Default: begin
					clr<=0; 
					HIen<=0; LOen<=0; Zen<=0; R15en<=0;
               Pen<=0; MDRen<=0; In_Porten<=0; OutPorten<=0; Cen<=0; IRen<=0; MARen<=0; Yen<=0;
					In_PortIN<=32'd0; Mdatain <= 32'h00000000; Gra<=0; Grb<=0; Grc<=0; RAMen<=0; In_PortIN<=0; Rin<=0; con_en<=0;
					
               HIselect<=0; LOselect<=0; Zhighselect<=0; zlowselect<=0;
               Pselect<=0; MDRselect<=0; In_Portselect<=0; Cselect<=0; Read<=0; BAout<=0; Rout<=0;
         
				end
            T0: begin 		// see if you need to de-assert these signals
               Pselect <= 1; alu_control <= 5'b11111; Zen <= 1; 
					MARen <= 1;
					Read<=1;
            end
            T1: begin
					 Pselect <= 0; MARen <= 0; Zen <= 0;
                zlowselect <= 1; Read <= 1; MDRen <= 1;  Pen <= 1;
            end
            T2: begin
					 zlowselect <= 0; Pen <= 0; Read <= 1; MDRen <= 0;
					 MDRselect <= 1; IRen <= 1;
            end
            T3: begin
				    MDRselect <= 0; IRen <= 0; 
				    Grb <= 1; BAout <= 1; Yen <= 1;
            end
            T4: begin
				    Grb <= 0; BAout <= 0; Yen <= 0;
				    Cselect <= 1; alu_control <= 5'b00011; Zen <= 1; 
            end
            T5: begin
				    Cselect <= 0; Zen <= 0; 
				    zlowselect <= 1; Gra<=1; Rin<=1;
            end
	endcase
end
endmodule
