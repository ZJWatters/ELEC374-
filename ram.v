module ram (input wire [31:0] dataIn, input wire[8:0] address, input wire clk, input wire write, input wire read, output reg [31:0] dataOut);
	 
	 reg [31:0] mem [0:511];
	 
	 initial begin
		$readmemh("ramInit.mif", mem);
	 end
    always @ (*) begin
        
            if (write == 1)
					 mem[address] <= dataIn;
        
              
				if (read == 1)
                dataOut <= mem[address];
     end
	  
	  
endmodule
