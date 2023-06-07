
//Restoring Division

module divider (
//Two Inputs a, b, and our output quotient q
//I decided to use wires because the values dont need to be stored in the actual divider module. It can just be sent to the
// output register in ALU after. 
  input wire signed [31:0] a,
  input wire signed [31:0] b,

  output wire signed [63:0] q
);
//Remainder has a 33 bit register as shown in lecture slides
reg signed [32:0] A;
reg signed [31:0] Q;
integer i;

//When a or b changes, run the for loop.
always @(*) begin
  A = 0; 
  Q = a;
    
	//We going through the entire 32 bit array
  for (i = 0; i < 32; i = i + 1) begin
    A = { A[31:0], Q[31] };
    Q = Q << 1;
	
    A = A - b;
	 
	//check if remainder is a negative. If it is we need to restore
    if (A < 0)begin
      A = A + b;
    end else begin
      Q[0] = 1;
    end
  end
end

assign q[63:32] = Q;
assign q[31:0] = A[31:0];


endmodule
