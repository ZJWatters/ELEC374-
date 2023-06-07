module MDR(input [31:0] busMuxOut, input [31:0] Mdatain, input wire read, input wire clr, input wire clk, input wire en, output wire [31:0] Q);	
    wire [31:0] MDR_muxOut;
	 TwoToOneMux mux1(.busMuxOut(busMuxOut),
							.Mdatain(Mdatain),
							.clk(clk),
							.Read(read),
							.out(MDR_muxOut));
    register mdrreg(.d(MDR_muxOut),
						  .clr(clr),
						  .clk(clk),
						  .enable(en),
						  .q(Q));
endmodule
		