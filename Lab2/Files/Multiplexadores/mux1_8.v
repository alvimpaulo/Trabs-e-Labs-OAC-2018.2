module mux1_8(
	input [2:0] sel,
	input dado0,dado1,dado2,dado3,dado4,dado5,dado6,dado7,
	output saida
	);
	
assign saida = sel==3'b000 ? dado0 :
					sel==3'b001 ? dado1 :
					sel==3'b010 ? dado2 :
					sel==3'b011 ? dado3 :
					sel==3'b100 ? dado4 :
					sel==3'b101 ? dado5 :
					sel==3'b110 ? dado6 :
					sel==3'b111 ? dado7 : 1'b0;	
			
endmodule
	