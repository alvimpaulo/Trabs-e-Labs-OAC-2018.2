module mux1_4a(
	input [1:0] sel,
	input dado0,dado1,dado2,dado3,
	output saida
	);
	
	always @(*)
		case (sel)
			2'b00: saida <= dado0;
			2'b01: saida <= dado1;
			2'b10: saida <= dado2;
			2'b11: saida <= dado3;
			default: saida <= 1'b0;
		endcase
			
endmodule
	