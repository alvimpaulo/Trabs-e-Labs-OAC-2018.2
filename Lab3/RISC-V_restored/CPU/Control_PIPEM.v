`ifndef PARAM
	`include "../Parametros.v"
`endif

/*
 * Bloco de Controle PIPELINE
 *
 
module Control_PIPEM (
	input  wire [6:0]	iOp, iFunct7,
	input  wire [2:0]	iFunct3,
	output reg		 	oEscreveReg, oLeMem, oEscreveMem, oJump, oBranch, onBranch, oJr, oSavePC,
	output reg [1:0] 	oOpALU, oOrigALU,
	output reg [2:0] 	oOrigPC,
	output reg	 		oEscreveEPC,
	output reg [2:0] 	oLoadType,
	output reg [1:0] 	oWriteType
);

always @(*) 
	case(iOp)
		OPCRM:
			case (iFunct)
				FUNMADD,	// Relatorio questao 6.B) - Grupo 2 - (2/2016)
				FUNMSUB:	// Relatorio questao 6.B) - Grupo 2 - (2/2016)
				begin
					oOrigALU    	<= 2'b00;  // seleciona o resultado do fowardB
					oSavePC     	<= 1'b0;   // seleciona o resultado da ALU
					oEscreveReg 	<= 1'b1;   // ativa EscreveReg
					oLeMem      	<= 1'b0;   // desativa LeMem
					oEscreveMem 	<= 1'b0;   // desativa EscreveMem
					oOrigPC     	<= 3'b000; // seleciona PC+4
					oOpALU      	<= 2'b11;  // funct determina a operacao da ALU
					oJump       	<= 1'b0;   // desativa jump
					oBranch     	<= 1'b0;   // desativa branch
					onBranch    	<= 1'b0;   // desativa BNE
					oJr         	<= 1'b0;   // desativa o Jr
					oEscreveEPC		<= 1'b0;	  // Escreve EPC
					oLoadType   	<= 3'b000; // load word/ignore
					oWriteType  	<= 2'b00;  // write word/ignore
				end

				FUNMADDU,	// Relatorio questao 6.B) - Grupo 2 - (2/2016)
				FUNMSUBU:	// Relatorio questao 6.B) - Grupo 2 - (2/2016)
				begin
					oOrigALU    	<= 2'b00;  // seleciona o resultado do fowardB
					oSavePC     	<= 1'b0;   // seleciona o resultado da ALU
					oEscreveReg 	<= 1'b1;   // ativa EscreveReg
					oLeMem      	<= 1'b0;   // desativa LeMem
					oEscreveMem 	<= 1'b0;   // desativa EscreveMem
					oOrigPC     	<= 3'b000; // seleciona PC+4
					oOpALU      	<= 2'b11;  // funct determina a operacao da ALU
					oJump       	<= 1'b0;   // desativa jump
					oBranch     	<= 1'b0;   // desativa branch
					onBranch    	<= 1'b0;   // desativa BNE
					oJr         	<= 1'b0;   // desativa o Jr
					oEscreveEPC		<= 1'b0;	  // Escreve EPC
					oLoadType   	<= 3'b000; // load word/ignore
					oWriteType  	<= 2'b00;  // write word/ignore
				end
				
				default: // Instrucao Nao reconhecida
				begin
					oOrigALU    	<= 2'b00;
					oSavePC     	<= 1'b0;
					oEscreveReg 	<= 1'b0;
					oLeMem      	<= 1'b0;
					oEscreveMem 	<= 1'b0;
					oOrigPC     	<= 3'b111; // default: ignora a instrução não reconhecida
					oOpALU      	<= 2'b00;
					oJump       	<= 1'b0;   // desativa jump
					oBranch     	<= 1'b0;   // desativa branch
					onBranch    	<= 1'b0;   // desativa BNE
					oJr         	<= 1'b0;   // desativa o Jr
					oEscreveEPC		<= 1'b0;	  // Escreve EPC
					oLoadType   	<= 3'b000; // load word/ignore
					oWriteType  	<= 2'b00;  // write word/ignore
				end
			endcase

		OPCLW:
			begin
				oOrigALU    	<= 2'b01;  // seleciona o imediato
				oSavePC     	<= 1'b0;   // seleciona o resultado da memoria de dados
				oEscreveReg 	<= 1'b1;   // ativa EscreveReg
				oLeMem      	<= 1'b1;   // ativa LeMem
				oEscreveMem 	<= 1'b0;   // desativa EscreveMem
				oOrigPC     	<= 3'b000; // seleciona PC+4
				oOpALU      	<= 2'b00;  // realiza ADD
				oJump       	<= 1'b0;   // desativa jump
				oBranch     	<= 1'b0;   // desativa branch
				onBranch    	<= 1'b0;   // desativa BNE
				oJr         	<= 1'b0;   // desativa o Jr
				oEscreveEPC		<= 1'b0;	  // Escreve EPC
				oLoadType   	<= LOAD_TYPE_LW; // load word/ignore
				oWriteType  	<= 2'b00;  // write word/ignore
			end


			
						
		default: // iOp Instrucao Nao reconhecida
			begin
				oOrigALU    	<= 2'b00;
				oSavePC     	<= 1'b0;
				oEscreveReg 	<= 1'b0;
				oLeMem      	<= 1'b0;
				oEscreveMem 	<= 1'b0;
				oOrigPC     	<= 3'b111; //default: ignora a instrução não reconhecida
				oOpALU      	<= 2'b00;
				oJump       	<= 1'b0;   // desativa jump
				oBranch     	<= 1'b0;   // desativa branch
				onBranch    	<= 1'b0;   // desativa BNE
				oJr         	<= 1'b0;   // desativa o Jr
				oEscreveEPC		<= 1'b0;	  // Escreve EPC
				oLoadType   	<= 3'b000; // load word/ignore
				oWriteType  	<= 2'b00;  // write word/ignore				
			end
	endcase 

endmodule*/
