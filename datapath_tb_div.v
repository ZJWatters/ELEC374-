`timescale 1ns/10ps

module datapath_tb_div;
	reg clr, clk,
	 R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en,
	 R10en, R11en, R12en, R13en, R14en, R15en, HIen, LOen, Zen,
	 Pen, MDRen, In_Porten, Cen, IRen, MARen, Yen,
	 
	 //select, Allows bus to read register contents.
	 
	 R0select, R1select, R2select, R3select, R4select, R5select, R6select, R7select, R8select, R9select,
	 R10select, R11select, R12select, R13select, R14select, R15select, HIselect, LOselect, Zhighselect, zlowselect,
	 Pselect, MDRselect, In_Portselect, Cselect, Read; 

	reg [31:0] alu_control, Mdatain;
	 
   parameter Default = 4'b0000; 
	parameter Reg_load1a = 4'b0001; 
	parameter Reg_load1b = 4'b0010; 
	parameter Reg_load2a = 4'b0011;
   parameter Reg_load2b = 4'b0100; 
	parameter T0 = 4'b0111;
   parameter T1 = 4'b1000; 
	parameter T2 = 4'b1001; 
	parameter T3 = 4'b1010; 
	parameter T4 = 4'b1011; 
	parameter T5 = 4'b1100;
	parameter T6 = 4'b1101;
   reg [3:0] Present_state = Default;
	 
	datapath dut(.clr(clr), .clk(clk), .R0en(R0en), .R1en(R1en), .R2en(R2en), .R3en(R3en), .R4en(R4en), .R5en(R5en), .R6en(R6en), .R7en(R7en),
		  .R8en(R8en), .R9en(R9en), .R10en(R10en), .R11en(R12en), .R12en(R12en), .R13en(R13en), .R14en(R5en), .R15en(R15en), .Zen(Zen), 
		 .Pen(Pen), .MDRen(MDRen), .In_Porten(In_Porten), .Cen(Cen), .IRen(IRen), .MARen(MARen), .Yen(Yen), .HIen(HIen), .LOen(LOen),
		 .R0select(R0select), .R1select(R1select), .R2select(R2select), .R3select(R3select), .R4select(R4select), .R5select(R5select), .R6select(R6select), .R7select(R7select),
		  .R8select(R8select), .R9select(R9select), .R10select(R10select), .R11select(R12select), .R12select(R12select), .R13select(R13select), .R14select(R14select), .R15select(R15select),
		  .HIselect(HIselect), .LOselect(LOselect), .Zhighselect(Zhighselect), .zlowselect(zlowselect),
		 .Pselect(Pselect), .MDRselect(MDRselect),  .In_Portselect(In_Portselect), .Cselect(Cselect), .Read(Read),
		 .alu_control(alu_control), .Mdatain(Mdatain));
	 
    initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
    end
	 
    always @(posedge clk) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                Default : Present_state = Reg_load1a;
                Reg_load1a : Present_state = Reg_load1b;
                Reg_load1b : Present_state = Reg_load2a;
                Reg_load2a : Present_state = Reg_load2b;
                Reg_load2b : Present_state = T0;
                T0 : Present_state = T1;
                T1 : Present_state = T2;
                T2 : Present_state = T3;
                T3 : Present_state = T4;
                T4 : Present_state = T5;
					 T5 : Present_state = T6;
            endcase
        end
		  
    always @(Present_state) // do the required job in each state
        begin
            case (Present_state) // assert the required signals in each clock cycle
            Default: begin
					clr<=0;
					R0en<=0; R1en<=0; R2en<=0; R3en<=0; R4en<=0; R5en<=0; R6en<=0; R7en<=0; R8en<=0; R9en<=0;
					R10en<=0; R11en<=0; R12en<=0; R13en<=0; R14en<=0; R15en<=0; HIen<=0; LOen<=0; Zen<=0;
					Pen<=0; MDRen<=0; In_Porten<=0; Cen<=0; IRen<=0; MARen<=0; Yen<=0;
					R0select<=0; R1select<=0; R2select<=0; R3select<=0; R4select<=0; R5select<=0; R6select<=0; R7select<=0; R8select<=0; R9select<=0;
					R10select<=0; R11select<=0; R12select<=0; R13select<=0; R14select<=0; R15select<=0; HIselect<=0; LOselect<=0; Zhighselect<=0; zlowselect<=0;
					Pselect<=0; MDRselect<=0; In_Portselect<=0; Cselect<=0; Read<=0;
									alu_control<=32'h00000000; Mdatain<=32'h00000000;
            end
                Reg_load1a: begin
                Mdatain <= 32'h00000015;
                Read = 0; MDRen = 1; // the first zero is there for completeness
                #4 
					 Read <= 1; 
					 MDRen <= 1;
                #4 
					 Read <= 0; 
					 MDRen <= 0;
            end
            Reg_load1b: begin
                #4
					MDRselect <= 1; 
					R6en <= 1;
                #4
					MDRselect <= 0; 
					R6en <= 0; // initialize R6 with the value $4
            end
            Reg_load2a: begin
            Mdatain <= 32'h00000005;
                #4
					Read <= 1; 
					MDRen <= 1;
                #4
					Read <= 0; 
					MDRen <= 0;
            end
            Reg_load2b: begin
                #4
					MDRselect <= 1; 
					R7en <= 1;
                #4
					MDRselect <= 0; 
					R7en <= 0; // initialize R7 with value 5
            end
				
            T0: begin // see if you need to de-assert these signals
					 #4
					 Mdatain = 32'h00000004;
                Pselect <= 1; MARen <= 1; alu_control<= 32'h0000000F;
					 Zen <= 1;
					 #4
					 Pselect <= 0; MARen <= 0; Zen <= 0;
            end
            T1: begin
					 #4
                zlowselect <= 1; Pen <= 1; Read <= 1; Mdatain <= 32'h28918000; 
					 MDRen <= 1;
					 #4
					 zlowselect <= 0; Pen <= 0; Read <= 0; MDRen <= 0;
            end
            T2: begin
					 #4
                MDRselect <= 1; IRen <= 1;
					 #4
					 MDRselect <= 0; IRen <= 0;
            end
            T3: begin
					 #4
                R6select <= 1; Yen <= 1;
					 #4
					 R6select <= 0; Yen <= 0;
            end
            T4: begin
					 #4
                R7select <= 1; alu_control <= 32'h80000000; Zen <= 1;
					 #4
					 R7select <= 0; Zen <= 0;
            end
            T5: begin
					 #4
                Zhighselect<=1; HIen <= 1;
					 #4
					 Zhighselect <= 0; HIen <= 0; 
            end
				T6: begin
					 #4
					 zlowselect<=1; LOen<=1;
					 #4
					 zlowselect<=0; LOen<=0;
					 end 
            endcase
        end
endmodule
