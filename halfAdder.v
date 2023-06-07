module halfAdder(input xi,yi, output s, cj);
		xor(s, xi, yi);
		and(cj, xi, yi);
endmodule 