module carryRippleAdder(input [31:0] a, b, input wire cin, output wire[31:0] s,  output wire cout);
	wire c01, c02, c03, c04, c05, c06, c07, c08, c09, c10;
	wire c11, c12, c13, c14, c15, c16, c17, c18, c19, c20;
	wire c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;
	
	fullAdder fullAdder0(a[0], b[0], cin,
							  s[0], c01);
	fullAdder fullAdder1(a[1], b[1], c01,
							  s[1], c02);				  
	fullAdder fullAdder2(a[2], b[2], c02,
							  s[2], c03);
	fullAdder fullAdder3(a[3], b[3], c03,
							  s[3], c04);
	fullAdder fullAdder4(a[4], b[4], c04,
							  s[4], c05);
	fullAdder fullAdder5(a[5], b[5], c05,
							  s[5], c06);
	fullAdder fullAdder6(a[6], b[6], c06,
							  s[6], c07);
	fullAdder fullAdder7(a[7], b[7], c07,
							  s[7], c08);
	fullAdder fullAdder8(a[8], b[8], c08,
							  s[8], c09);
	fullAdder fullAdder9(a[9], b[9], c09,
							  s[9], c10);
	fullAdder fullAdder10(a[10], b[10], c10,
							  s[10], c11);
	fullAdder fullAdder11(a[11], b[11], c11,
							  s[11], c12);				  
	fullAdder fullAdder12(a[12], b[12], c12,
							  s[12], c13);
	fullAdder fullAdder13(a[13], b[13], c13,
							  s[13], c14);
	fullAdder fullAdder14(a[14], b[14], c14,
							  s[14], c15);
	fullAdder fullAdder15(a[15], b[15], c15,
							  s[15], c16);
	fullAdder fullAdder16(a[16], b[16], c16,
							  s[16], c17);
	fullAdder fullAdder17(a[17], b[17], c17,
							  s[17], c18);
	fullAdder fullAdder18(a[18], b[18], c18,
							  s[18], c19);
	fullAdder fullAdder19(a[19], b[19], c19,
							  s[19], c20);
	fullAdder fullAdder20(a[20], b[20], c20,
							  s[20], c21);
	fullAdder fullAdder21(a[21], b[21], c21,
							  s[21], c22);				  
	fullAdder fullAdder22(a[22], b[22], c22,
							  s[22], c23);
	fullAdder fullAdder23(a[23], b[23], c23,
							  s[23], c24);
	fullAdder fullAdder24(a[24], b[24], c24,
							  s[24], c25);
	fullAdder fullAdder25(a[25], b[25], c25,
							  s[25], c26);
	fullAdder fullAdder26(a[26], b[26], c26,
							  s[26], c27);
	fullAdder fullAdder27(a[27], b[27], c27,
							  s[27], c28);
	fullAdder fullAdder28(a[28], b[28], c28,
							  s[28], c29);
	fullAdder fullAdder29(a[29], b[29], c29,
							  s[29], c30);
	fullAdder fullAdder30(a[30], b[30], c30,
							  s[30], c31);
	fullAdder fullAdder31(a[31], b[31], c31,
							  s[31], cout);

endmodule
