`timescale 1ns/1ns

module biBus_tb;

reg R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en,
R10en, R11en, R12en, R13en, R14en, R15en, HIen, LOen, Zhighen, zlowen,
Pen, MDRen, In_Porten, Cen;

reg [31:0] R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZhighBusIn, zlowBusIn,
PCBusIn, MDRBusIn, InPortBusIn, CBusIn;

wire [31:0] BusMuxOut;

biBus boose(R0en, R1en, R2en, R3en, R4en, R5en, R6en, R7en, R8en, R9en,
R10en, R11en, R12en, R13en, R14en, R15en, HIen, LOen,  In_Porten, Cen,R0BusIn, R1BusIn, R2BusIn, R3BusIn, R4BusIn, R5BusIn, R6BusIn, R7BusIn, R8BusIn, R9BusIn,
R10BusIn, R11BusIn, R12BusIn, R13BusIn, R14BusIn, R15BusIn, HIBusIn, LOBusIn, ZhighBusIn, zlowBusIn,
PCBusIn, MDRBusIn, InPortBusIn, CBusIn, BusMuxOut);

initial 
	begin	
	
	R0en <= 1;
	
	R1en=0; R2en= 0;  R3en= 0;  R4en= 0;  R5en= 0;  R6en= 0;  R7en= 0;  R8en= 0;  R9en= 0;  R10en= 0;  R11en= 0;  R12en= 0;  R13en= 0;  R14en= 0;  R15en= 0;  HIen= 0;  LOen= 0;  In_Porten= 0;  Cen = 0;

	R2BusIn= 0;  R3BusIn= 0;  R4BusIn= 0;  R5BusIn= 0;  R6BusIn= 0;  R7BusIn= 0;  R8BusIn= 0;  R9BusIn= 0;  R10BusIn= 0;  R11BusIn= 0;  R12BusIn= 0;  R13BusIn= 0;  R14BusIn= 0;  R15BusIn= 0;  HIBusIn= 0;  LOBusIn= 0;  InPortBusIn= 0;  CBusIn = 0;
	
	R0BusIn <= 32'd12;
	R1BusIn <= 32'd3;
	#20;
	
	
	R0en <= 0;
	R1en <= 1;
	#20;
	
	end
	
endmodule 


	