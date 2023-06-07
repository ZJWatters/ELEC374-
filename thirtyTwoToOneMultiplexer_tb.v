`timescale 1ns/1ns
module thirtyTwoToOneMultiplexer_tb;
   reg [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23;
   wire [31:0] out;
	reg [4:0] select;

   thirtyTwoToOneMultiplexer uut(
      .in0(in0),
      .in1(in1),
      .in2(in2),
      .in3(in3),
      .in4(in4),
      .in5(in5),
      .in6(in6),
      .in7(in7),
      .in8(in8),
      .in9(in9),
      .in10(in10),
      .in11(in11),
      .in12(in12),
      .in13(in13),
      .in14(in14),
      .in15(in15),
      .in16(in16),
      .in17(in17),
      .in18(in18),
      .in19(in19),
      .in20(in20),
      .in21(in21),
      .in22(in22),
      .in23(in23),
      .select(select),
      .out(out)
   );

   initial begin
      #20;
      in0 = 0;
      in1 = 0;
      in2 = 0;
      in3 = 0;
      in4 = 0;
      in5 = 0;
      in6 = 0;
      in7 = 0;
      in8 = 0;
      in9 = 0;
      in10 = 0;
      in11 = 0;
      in12 = 0;
      in13 = 0;
      in14 = 0;
      in15 = 0;
      in16 = 0;
      in17 = 0;
      in18 = 0;
      in19 = 0;
      in20 = 0;
      in21 = 32'h00000001;
      in22 = 0;
		in23 = 0;
		select = 5'b10101;
		#40;
	end
	
endmodule
		
		


