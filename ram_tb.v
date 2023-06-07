module ram_tb;

reg clk, write, read;
reg [31:0] dataIn;
wire [31:0] dataOut;
reg [8:0] addresses;

ram r(clk, read, write, dataIn, addresses, dataOut);

    initial
        begin
            clk = 0;
            forever #10 clk = ~ clk;
    end
	initial
		begin
			#10
			write = 1;
			read = 0;
			dataIn = 42;
			addresses = 9'b000000001;
			#10;
			write = 0;
			read = 1;
			addresses = 9'b000000001;
			#10;
		end
		
endmodule

		
		