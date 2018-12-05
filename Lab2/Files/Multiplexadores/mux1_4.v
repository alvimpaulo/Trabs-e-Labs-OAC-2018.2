module mux1_4(
	input [1:0] sel,
	input dado0,dado1,dado2,dado3,
	output saida
	);
	
assign saida = sel==2'b00 ? dado0 :
					sel==2'b01 ? dado1 :
					sel==2'b10 ? dado2 :
					sel==2'b11 ? dado3 : 1'b0;			
endmodule
	