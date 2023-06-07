module fullAdder(input a, b, cin, output reg sum, output cout);
	wire w1, w2, w3, s;
	
	halfAdder halfAdder1(a, b, w1, w2);
	halfAdder halfAdder2(cin, w1, s, w3);
	or(cout, w3, w2);
	always @(*) begin
		sum = s;
	end

endmodule
