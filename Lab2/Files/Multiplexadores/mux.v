module mux(
	input [Sel-1:0] select,
	input [NBits-1:0] dado [Mux-1:0],
	output [NBits-1:0] saida
	);
	
assign saida=dado[select];
			
endmodule
	