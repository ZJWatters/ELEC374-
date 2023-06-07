`timescale 1ns/1ns  

module register_tb;

  reg clr;
  reg clk;
  reg enable;
  reg [31:0] d;
  
  wire [31:0] q;

  register dut(
    .clr(clr),
    .clk(clk),
    .enable(enable),
    .d(d),
    .q(q)
  );

	initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
    end
	 
	 always @(posedge clk)
		begin	
			clr <= 1;
			d <= 32'h00001111;
			#20; 
			clr <= 0;
			enable <= 1;
			#40 ;
			enable <= 0;
			#20;
			clr <= 1;
			#20;
		end		
endmodule
