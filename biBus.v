// #reformed

module biBus(input wire R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en,
					R10en, R11en, R12en, R13en, R14en, R15en, HIen, LOen, Zhighen, zlowen,
					Pen, MDRen, In_Porten, Cen, input wire [31:0] R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZhighBusIn, zlowBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd, output wire [31:0] busMuxOut);
					
	wire [4:0] select;
	reg [31:0] muxin;
	
	always @(Cen, In_Porten, MDRen, Pen, zlowen, Zhighen, LOen, HIen, R15en, R14en,
					R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en,
					R3en, R2en, R1en, R0en)
		begin
			muxin = {{8'b0},Cen, In_Porten, MDRen, Pen, zlowen, Zhighen, LOen, HIen, R15en, R14en,
					R13en, R12en, R11en, R10en, R9en, R8en, R7en, R6en, R5en, R4en,
					R3en, R2en, R1en, R0en};
		end
	
	ThirtyTwoToFiveEncoder encoder(select, muxin);
	
	thirtyTwoToOneMultiplexer mux(R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
					R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZhighBusIn, zlowBusIn,
					PCBusIn, MDRBusIn, InPortBusIn, C_Sign_Extnd, select, busMuxOut);

endmodule
