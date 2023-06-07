`timescale 1ns/1ns 

module halfAdder_tb;

  reg xi;
  reg yi;
  
  wire s;
  wire cj;

  halfAdder dut(
    .xi(xi),
    .yi(yi),
    .s(s),
    .cj(cj)
  );

  reg clk;
  initial clk = 0;
  always #5 clk = ~clk; // Toggle the clock every 5 time units
  
  initial begin
    xi = 0;
    yi = 0;
    #10 xi = 1;
    #10 yi = 1;
    #10 xi = 0;
    #10 yi = 1;
    #10 xi = 1;
    #10 yi = 0;
    #10 xi = 1;
    #10 yi = 1;
    #10 $finish; 
  end

  always @(posedge clk) begin
    $display("xi=%b, yi=%b, s=%b, cj=%b", xi, yi, s, cj);
  end

endmodule