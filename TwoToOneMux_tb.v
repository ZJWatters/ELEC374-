`timescale 1ns/1ns

module TwoToOneMux_tb;

  reg clk;
  reg Read; 
  reg [31:0] busMuxOut;
  reg [31:0] Mdatain;
  wire [31:0] out;

  TwoToOneMux mux(clk, Read, busMuxOut, Mdatain, out);

	initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
			end
  
  initial 
	  begin
		 Read = 0;
		 busMuxOut = 32'h00000001;
		 Mdatain = 32'h00000010;
		 #40;
		 Read = 1;
		 #40;
	  end

endmodule
