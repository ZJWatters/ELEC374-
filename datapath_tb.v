// and datapath_tb.v file
`timescale 1ns/10ps
module datapath_tb;
	 reg clk, clr;
    reg [31:0] R0in, R1in, R2in, R3in, R4in, R5in, 
        R6in, R7in, R8in, R9in, R10in, R11in,
        R12in, R13in, R14in, R15in;
    reg R0out, R1out, R2out, R3out, R4out, 
        R5out, R6out, R7out, R8out, R9out, R10out, 
        R11out, R12out, R13out, R14out, R15out, Zout;
    reg [31:0] HIin, LOin, PCin, MARin, MDRin, IRin, Yin, Zin, Read;
    reg HIout, LOout, PCout, InPortOut, Zhighout, Zlowout, 
        MDRout, Cout, IncPC, IRout, Yout, MARout;
	 reg [31:0] alu_control, Mdatain;
    wire [31:0] busMuxOut;
	 wire [63:0] alu_result;
		
		
		parameter Default = 4'b0000; 
		parameter Reg_load1a = 4'b0001; 
		parameter Reg_load1b = 4'b0010; 
		parameter Reg_load2a = 4'b0011;
		parameter Reg_load2b = 4'b0100; 
		parameter Reg_load3a = 4'b0101; 
		parameter Reg_load3b = 4'b0110; 
		parameter T0 = 4'b0111;
		parameter T1 = 4'b1000; 
		parameter T2 = 4'b1001; 
		parameter T3 = 4'b1010; 
		parameter T4 = 4'b1011; 
		parameter T5 = 4'b1100;
		reg [3:0] Present_state = Default;
		 
		datapath DUT(.clk(clk), .clr(clr),.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in),
						.R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in),
						.R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), .R9out(R9out), .R10out(R10out), 
						.R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out), .Zout(Zout),
						.HIout(HIout), .LOout(LOout), .PCout(PCout), .InPortOut(InPortOut), .Zhighout(Zhighout), .Zlowout(Zlowout), 
						.MDRout(MDRout), .Cout(Cout), .IncPC(IncPC), .IRout(IRout), .Yout(Yout), .MARout(MARout),
						.alu_control(alu_control), .Mdatain(Mdatain),
						.busMuxOut(busMuxOut), 
						.alu_result(alu_result));
	
    // add test logic here
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
                Reg_load2b : Present_state = Reg_load3a;
                Reg_load3a : Present_state = Reg_load3b;
                Reg_load3b : Present_state = T0;
                T0 : Present_state = T1;
                T1 : Present_state = T2;
                T2 : Present_state = T3;
                T3 : Present_state = T4;
                T4 : Present_state = T5;
            endcase
        end
		  
    always @(Present_state) // do the required job in each state
        begin
            case (Present_state) // assert the required signals in each clock cycle
            Default: begin
                PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
                R2out <= 0; R3out <= 0; MARout <= 0; Zout <= 0;
                PCout <=0; MDRout <= 0; IRout <= 0; Yout <= 0;
                IncPC <= 0; Read <= 0; alu_control <= 0;
                R1out <= 0; R2out <= 0; R3out <= 0; Mdatain <= 32'h00000000;
                clr <= 0;
            end
                Reg_load1a: begin
                Mdatain <= 32'h00000012;
                Read = 0; MDRout = 1; // the first zero is there for completeness
                #2 
					Read <= 1; 
					MDRout <= 1;
                #2 
					Read <= 0; 
					MDRout <= 0;
            end
            Reg_load1b: begin
                #2
					MDRout <= 1; 
					R2out <= 1;
                #2
					MDRout <= 0; 
					R2out <= 0; // initialize R2 with the value $12
            end
            Reg_load2a: begin
            Mdatain <= 32'h00000014;
                #2 
					Read <= 1; 
					MDRout <= 1;
                #2
					Read <= 0; 
					MDRout <= 0;
            end
            Reg_load2b: begin
                #2
					MDRout <= 1; 
					R3out <= 1;
                #2
					MDRout <= 0; 
					R3out <= 0; // initialize R3 with the value $14
            end
            Reg_load3a: begin
                Mdatain <= 32'h00000018;
                #2 
					Read <= 1; 
					MDRout <= 1;
                #2
					Read <= 0; 
					MDRout <= 0;
            end
            Reg_load3b: begin
                #2 
					MDRout <= 1; 
					R1out <= 1;
                #2
					MDRout <= 0; 
					R1out <= 0; // initialize R1 with the value $18
            end
            T0: begin // see if you need to de-assert these signals
                PCout <= 0; MARout <= 0; IncPC <= 0; Zout <= 0;
            end
            T1: begin
                Zlowout <= 0; PCout <= 0; Read <= 0; MDRout <= 0;
                Mdatain <= 32'h28918000; // opcode for and R1, R2, R3
            end
            T2: begin
					 #2
                MDRout <= 1; IRout <= 1;
					 #2
					 MDRout <= 0; IRout <= 0;
            end
            T3: begin
					 #2
                R2out <= 1; Yout <= 1;
					 #2
					 R2out <= 0; Yout <= 0;
            end
            T4: begin
					 #2
                R3out <= 1; alu_control <= Mdatain[31:27]; Zout <= 1;
					 #2
					 R3out <= 0; Zout <= 0;
            end
            T5: begin
					 #2
                Zlowout <= 1; R1out <= 1;
					 #2
					 Zlowout <= 0; R1out <= 0;
            end
            endcase
        end
endmodule
