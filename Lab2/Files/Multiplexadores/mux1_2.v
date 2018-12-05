module mux1_2(
	input sel,
	input dado0, dado1,
	output saida
	);
	
assign saida = sel ? dado1 : dado0;
			
endmodule
	