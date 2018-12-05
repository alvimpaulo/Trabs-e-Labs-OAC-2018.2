
`ifndef PARAM
	`include "Parametros.v"
`endif

`timescale 1 ns / 1 ps

module TopDE_tb;

reg iCLOCK;
reg [9:0] iSW;
reg [3:0] iKEY;
wire [9:0] oLEDR;
wire [6:0] oHEX0,oHEX1,oHEX2,oHEX3,oHEX4,oHEX5;
wire [31:0] oRESULT, oRESULT0,oRESULT1,oRESULT2,oRESULT3, oRESULT4,oRESULT5,oRESULT6,oRESULT7,oRESULT8;

always
	#10 iCLOCK = ~iCLOCK;	// T=10+10 Clock de 50MHz

	TopDE top0 (
	.CLOCK_50(iCLOCK),
	.KEY(iKEY),
	.SW(iSW),
	.LEDR(oLEDR),
	.HEX0(oHEX0), .HEX1(oHEX1), .HEX2(oHEX2), .HEX3(oHEX3), .HEX4(oHEX4), .HEX5(oHEX5),
	.wresult(oRESULT), .wresult0(oRESULT0), .wresult1(oRESULT1), .wresult2(oRESULT2), .wresult3(oRESULT3),
	.wresult4(oRESULT4), .wresult5(oRESULT5), .wresult6(oRESULT6), .wresult7(oRESULT7), .wresult8(oRESULT8)
	);
	
	reg [3:0] i;

	
initial
	begin

		
		$display($time, " << Inicio da Simulacao >> ");
		iCLOCK=1'b0;
		iKEY=4'b1111;

		#50
		iSW=(12'h3F8) >>2;
		iKEY=4'b1110;
		
		#50
		iSW=(12'h400) >>2;
		iKEY=4'b1101;

		#50
		iKEY=4'b1111;
		
		for (i=0; i<5; i=i+1)
		#500 iSW={6'b0,i};
		
		
		#200
		$display($time, "<< Final da Simulacao >>");
		$stop;
	end

	
initial
	begin	
					
		$display("time, i, iKEY, r, r0, r1, r2 ,r3 ,r3 ,r3 ,r3 ,r3"); 
		$monitor("%d,  %d, %b, %h, %h, %h, %h, %h, %h, %h, %h, %h, %h",$time, i, iKEY, oRESULT, oRESULT0, oRESULT1, oRESULT2, oRESULT3, 
		oRESULT4, oRESULT5, oRESULT6, oRESULT7, oRESULT8);	
	
	end


endmodule
