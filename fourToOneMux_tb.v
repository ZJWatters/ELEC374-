`timescale 1ns/1ns

module fourToOneMux_tb;

  reg [31:0] a, b, c, d;
  reg s0, s1;
  wire [31:0] out;

  fourToOneMux uut(out, a, b, c, d, s0, s1);

  
  initial begin
    //Test 1
    a = 0;
    b = 32'h00000001;
    c = 0;
    d = 0;
    s0 = 1;
    s1 = 0;
    #40;
    //Test 2
    a = 0;
    b = 0;
    c = 32'h00000001;
    d = 0;
    s0 = 0;
    s1 = 1;
    #40;
    //Test 3
	 a = 32'h00000100;
    b = 0;
    c = 0;
    d = 0;
    s0 = 0;
    s1 = 0;
    #40;
    //Test 4
    a = 0;
    b = 0;
    c = 0;
    d = 32'h00000011;
    s0 = 1;
    s1 = 1;
    #40;
  end

endmodule
