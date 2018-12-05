module mux32_32(
	input [4:0] sel,
	input [31:0] dado0,dado1,dado2,dado3,dado4,dado5,dado6,dado7,dado8,dado9,dado10,dado11,dado12,dado13,dado14,dado15,
	dado16,dado17,dado18,dado19,dado20,dado21,dado22,dado23,dado24,dado25,dado26,dado27,dado28,dado29,dado30,dado31,
	output [31:0] saida
	);
	
assign saida = sel==5'd0 ? dado0 :
					sel==5'd1 ? dado1 :
					sel==5'd2 ? dado2 :
					sel==5'd3 ? dado3 :
					sel==5'd4 ? dado4 :
					sel==5'd5 ? dado5 :
					sel==5'd6 ? dado6 :
					sel==5'd7 ? dado7 :	
					sel==5'd8 ? dado8 :
					sel==5'd9 ? dado9 :
					sel==5'd10 ? dado10 :
					sel==5'd11 ? dado11 :
					sel==5'd12 ? dado12 :
					sel==5'd13 ? dado13 :
					sel==5'd14 ? dado14 :
					sel==5'd15 ? dado15 :
					sel==5'd16 ? dado16 :
					sel==5'd17 ? dado17 :
					sel==5'd18 ? dado18 :
					sel==5'd19 ? dado19 :
					sel==5'd20 ? dado20 :
					sel==5'd21 ? dado21 :
					sel==5'd22 ? dado22 :
					sel==5'd23 ? dado23 :
					sel==5'd24 ? dado24 :
					sel==5'd25 ? dado25 :
					sel==5'd26 ? dado26 :
					sel==5'd27 ? dado27 :
					sel==5'd28 ? dado28 :
					sel==5'd29 ? dado29 :
					sel==5'd30 ? dado30 :
					sel==5'd31 ? dado31 : 1'b0;		
		
endmodule
	