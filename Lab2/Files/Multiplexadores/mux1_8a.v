module mux1_8a(
	input [2:0] sel,
	input dado0,dado1,dado2,dado3,dado4,dado5,dado6,dado7,
	output saida
	);
	
	always @(*)
		case (sel)
			3'b000: saida = dado0;
			3'b001: saida = dado1;
			3'b010: saida = dado2;
			3'b011: saida = dado3;
			3'b100: saida = dado4;
			3'b101: saida = dado5;
			3'b110: saida = dado6;
			3'b111: saida = dado7;
			default: saida = 1'b0;
		endcase
			
endmodule
	