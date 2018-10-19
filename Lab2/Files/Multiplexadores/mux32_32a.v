module mux32_32a(
	input [4:0] sel,
	input [31:0] dado0,dado1,dado2,dado3,dado4,dado5,dado6,dado7,dado8,dado9,dado10,dado11,dado12,dado13,dado14,dado15,
	dado16,dado17,dado18,dado19,dado20,dado21,dado22,dado23,dado24,dado25,dado26,dado27,dado28,dado29,dado30,dado31,
	output [31:0] saida
	);
	
	always @(*)
		case (sel)
			5'd0: saida <= dado0;
			5'd1: saida <= dado1;
			5'd2: saida <= dado2;
			5'd3: saida <= dado3;
			5'd4: saida <= dado4;
			5'd5: saida <= dado5;
			5'd6: saida <= dado6;
			5'd7: saida <= dado7;
			5'd8: saida <= dado8;
			5'd9: saida <= dado9;
			5'd10: saida <= dado10;
			5'd11: saida <= dado11;
			5'd12: saida <= dado12;
			5'd13: saida <= dado13;
			5'd14: saida <= dado14;
			5'd15: saida <= dado15;
			5'd16: saida <= dado16;
			5'd17: saida <= dado17;
			5'd18: saida <= dado18;
			5'd19: saida <= dado19;
			5'd20: saida <= dado20;
			5'd21: saida <= dado21;
			5'd22: saida <= dado22;
			5'd23: saida <= dado23;
			5'd24: saida <= dado24;
			5'd25: saida <= dado25;
			5'd26: saida <= dado26;
			5'd27: saida <= dado27;
			5'd28: saida <= dado28;
			5'd29: saida <= dado29;
			5'd30: saida <= dado30;
			5'd31: saida <= dado31;
			default: saida <= 32'b0;
		endcase
			
endmodule
	