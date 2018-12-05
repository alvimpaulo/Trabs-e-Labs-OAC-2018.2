`ifndef PARAM
	`include "../Parametros.v"
`endif

// *
// * Bloco de Controle PIPELINE
// *
 

 module Control_PIPEM(
    input  [31:0] iInstr, 
    output    	 	oOrigAULA, 
	 output 			oOrigBULA, 
	 output			oRegWrite, 
	 output			oMemWrite, 
	 output			oMemRead,
	 output [ 1:0]	oMem2Reg, 
	 output [ 1:0]	oOrigPC,
	 output [ 4:0] oALUControl,
	 output [ 7:0] oInstrType,	//{Load,Store,TipoR,TipoI,Jal,Jalr,Branch,DivRem}
	 
	 output			oOrigAFPULA,
	 output			oData2Mem,
	 output [ 5:0]	oFPALUContro,
	 output			oFPRegWrite
);


wire [6:0] Opcode = iInstr[ 6: 0];
wire [2:0] Funct3	= iInstr[14:12];
wire [6:0] Funct7	= iInstr[31:25];


always @(*)
	case(Opcode)
		OPC_LOAD:
			begin
				oOrigAULA	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b1; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b10;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b01000000; // Load

`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
		OPC_OPIMM:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00001000; // TipoI
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
				case (Funct3)
					FUNCT3_ADD:			oALUControl <= OPADD;
					FUNCT3_SLL:			oALUControl <= OPSLL;
					FUNCT3_SLT:			oALUControl <= OPSLT;
					FUNCT3_SLTU:		oALUControl	<= OPSLTU;
					FUNCT3_XOR:			oALUControl <= OPXOR;
					FUNCT3_SRL,
					FUNCT3_SRA:
						if(Funct7==FUNCT7_SRA)  oALUControl <= OPSRA;
						else 							oALUControl <= OPSRL;
					FUNCT3_OR:			oALUControl <= OPOR;
					FUNCT3_AND:			oALUControl <= OPAND;	
					default: // instrucao invalida
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b00;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
						end				
				endcase
			end
			
		OPC_AUIPC:
			begin
				oOrigAULA  	<= 1'b1;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00001000; // TipoI;
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
			
		OPC_STORE:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b1; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00100000; // Store;
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
		
		OPC_RTYPE:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00010000; // TipoR;
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			case (Funct7)
				FUNCT7_ADD,  // ou qualquer outro 7'b0000000
				FUNCT7_SUB:	 // SUB ou SRA			
					case (Funct3)
						FUNCT3_ADD,
						FUNCT3_SUB:
							if(Funct7==FUNCT7_SUB)   oALUControl <= OPSUB;
							else 							 oALUControl <= OPADD;
						FUNCT3_SLL:			oALUControl <= OPSLL;
						FUNCT3_SLT:			oALUControl <= OPSLT;
						FUNCT3_SLTU:		oALUControl	<= OPSLTU;
						FUNCT3_XOR:			oALUControl <= OPXOR;
						FUNCT3_SRL,
						FUNCT3_SRA:
							if(Funct7==FUNCT7_SRA)  oALUControl <= OPSRA;
							else 							oALUControl <= OPSRL;
						FUNCT3_OR:			oALUControl <= OPOR;
						FUNCT3_AND:			oALUControl <= OPAND;
						default: // instrucao invalida
							begin
								oOrigAULA  	<= 1'b0;
								oOrigBULA 	<= 1'b0;
								oRegWrite	<= 1'b0;
								oMemWrite	<= 1'b0; 
								oMemRead 	<= 1'b0; 
								oALUControl	<= OPNULL;
								oMem2Reg 	<= 2'b00;
								oOrigPC		<= 2'b00;
								oInstrType	<= 8'b00000000; // Null
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
							end				
					endcase

`ifdef RV32M					
				FUNCT7_MULDIV:
					begin
					oInstrType	<= 8'b10010000; // DivRem
					case (Funct3)
						FUNCT3_MUL:			oALUControl <= OPMUL;
						FUNCT3_MULH:		oALUControl <= OPMULH;
						FUNCT3_MULHSU:		oALUControl <= OPMULHSU;
						FUNCT3_MULHU:		oALUControl <= OPMULHU;
						FUNCT3_DIV:			oALUControl <= OPDIV;
						FUNCT3_DIVU:		oALUControl <= OPDIVU;
						FUNCT3_REM:			oALUControl <= OPREM;
						FUNCT3_REMU:		oALUControl <= OPREMU;	
						default: // instrucao invalida
							begin
								oOrigAULA  	<= 1'b0;
								oOrigBULA 	<= 1'b0;
								oRegWrite	<= 1'b0;
								oMemWrite	<= 1'b0; 
								oMemRead 	<= 1'b0; 
								oALUControl	<= OPNULL;
								oMem2Reg 	<= 2'b00;
								oOrigPC		<= 2'b00;
								oInstrType	<= 8'b00000000; // Null
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
							end				
					endcase
					end
`endif			
				default: // instrucao invalida
					begin
						oOrigAULA  	<= 1'b0;
						oOrigBULA 	<= 1'b0;
						oRegWrite	<= 1'b0;
						oMemWrite	<= 1'b0; 
						oMemRead 	<= 1'b0; 
						oALUControl	<= OPNULL;
						oMem2Reg 	<= 2'b00;
						oOrigPC		<= 2'b00;
						oInstrType	<= 8'b00000000; // Null
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
					end				
			endcase			
		end
		
		OPC_LUI:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPLUI;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00001000; // TipoI
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
			
		OPC_BRANCH:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b01;
				oInstrType	<= 8'b00000001; // Branch
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
			
		OPC_JALR:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b01;
				oOrigPC		<= 2'b11;
				oInstrType	<= 8'b00000010; // Jalr
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
		
		OPC_JAL:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b01;
				oOrigPC		<= 2'b10;
				oInstrType	<= 8'b00000100; // Jal
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
			end
`ifdef RV32IMF
        //Adicionar as instruções tipo R com FP
        OPC_FP_RTYPE:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPNULL;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00000000; // Null
				
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
				case (Funct7)
					FUNCT7_FP_ADD:
						beginA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPADD;
							oFPRegWrite	<= 1;
						end	
					FUNCT7_FP_SUB:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPSUB;
							oFPRegWrite	<= 1;
						end	
					FUNCT7_FP_MUL:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPMUL;
							oFPRegWrite	<= 1;
						end	
					FUNCT7_FP_DIV:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPDIV;
							oFPRegWrite	<= 1;
						end
					FUNCT7_FP_SIGN:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPNULL;
							oFPRegWrite	<= 1;
							case (Funct3)
							FUNCT3_FSGNJS: oFPALUControl	<= FOPSGNJS;
							FUNCT3_FSGNJNS: oFPALUControl	<= FOPSGNJN; 
							FUNCT3_FSGNJXS:	 oFPALUControl	<= FOPSGNJX; 
							default: // instrucao invalida
								begin
									oOrigAULA  	<= 1'b0;
									oOrigBULA 	<= 1'b0;
									oRegWrite	<= 1'b0;
									oMemWrite	<= 1'b0; 
									oMemRead 	<= 1'b0; 
									oALUControl	<= OPNULL;
									oMem2Reg 	<= 2'b00;
									oOrigPC		<= 2'b00;
									oInstrType	<= 8'b00000000; // Null
									
									oOrigAFPULA	<= 0;
									oData2Mem	<= 0;
									oFPALUContro<= FOPNULL;
									oFPRegWrite	<= 0;
								end
							endcase
						end
					FUNCT7_FP_MINMAX:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPNULL;
							oFPRegWrite	<= 1;
							case (Funct3)
							FUNCT3_MIN:	oFPALUControl	<= FOPMIN;
							FUNCT3_MAX: oFPALUControl	<= FOPMAX;
							default:
								begin
									oOrigAULA  	<= 1'b0;
									oOrigBULA 	<= 1'b0;
									oRegWrite	<= 1'b0;
									oMemWrite	<= 1'b0; 
									oMemRead 	<= 1'b0; 
									oALUControl	<= OPNULL;
									oMem2Reg 	<= 2'b00;
									oOrigPC		<= 2'b00;
									oInstrType	<= 8'b00000000; // Null
									
									oOrigAFPULA	<= 0;
									oData2Mem	<= 0;
									oFPALUContro<= FOPNULL;
									oFPRegWrite	<= 0;
								end
							endcase
						end
					FUNCT7_FP_SQRT:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPSQRT;
							oFPRegWrite	<= 1;
						end	
					FUNCT7_FP_COMP:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b1;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPNULL;
							oFPRegWrite	<= 0;
							case (Funct3)
							FUNCT3_FLE: oFPALUControl	<= FOPCLE;
							FUNCT3_FLT: oFPALUControl	<= FOPCLT; 
							FUNCT3_FEQ: oFPALUControl	<= FOPCEQ; 
							default:
								begin
									oOrigAULA  	<= 1'b0;
									oOrigBULA 	<= 1'b0;
									oRegWrite	<= 1'b0;
									oMemWrite	<= 1'b0; 
									oMemRead 	<= 1'b0; 
									oALUControl	<= OPNULL;
									oMem2Reg 	<= 2'b00;
									oOrigPC		<= 2'b00;
									oInstrType	<= 8'b00000000; // Null
									
									oOrigAFPULA	<= 0;
									oData2Mem	<= 0;
									oFPALUContro<= FOPNULL;
									oFPRegWrite	<= 0;
								end
							endcase
						end
					FUNCT7_FP_CVTWS:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b1;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPNULL;
							oFPRegWrite	<= 0;
							case (RS2)
							RS2_CVTWS: oFPALUControl	<= FOPCVTWS;
							RS2_CVTWUS: oFPALUControl	<= FOPCVTWUS;
							default:
								begin
									oOrigAULA  	<= 1'b0;
									oOrigBULA 	<= 1'b0;
									oRegWrite	<= 1'b0;
									oMemWrite	<= 1'b0; 
									oMemRead 	<= 1'b0; 
									oALUControl	<= OPNULL;
									oMem2Reg 	<= 2'b00;
									oOrigPC		<= 2'b00;
									oInstrType	<= 8'b00000000; // Null
									
									oOrigAFPULA	<= 0;
									oData2Mem	<= 0;
									oFPALUContro<= FOPNULL;
									oFPRegWrite	<= 0;
								end
							endcase
						end
					FUNCT7_FP_CVTSW:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 0;
							oData2Mem	<= 1;
							oFPALUContro<= FOPNULL;
							oFPRegWrite	<= 1;
							case (RS2)
							RS2_CVTWS: oFPALUControl	<= FOPCVTSW;
							RS2_CVTWUS: oFPALUControl	<= FOPCVTSWU;
							default:
								begin
									oOrigAULA  	<= 1'b0;
									oOrigBULA 	<= 1'b0;
									oRegWrite	<= 1'b0;
									oMemWrite	<= 1'b0; 
									oMemRead 	<= 1'b0; 
									oALUControl	<= OPNULL;
									oMem2Reg 	<= 2'b00;
									oOrigPC		<= 2'b00;
									oInstrType	<= 8'b00000000; // Null
									
									oOrigAFPULA	<= 0;
									oData2Mem	<= 0;
									oFPALUContro<= FOPNULL;
									oFPRegWrite	<= 0;
								end
							endcase
						end
					FUNCT7_FP_MVXW:
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 0;
							oData2Mem	<= 1;
							oFPALUContro<= FOPMOV;
							oFPRegWrite	<= 1;
						end	
					FUNCT7_FP_MVWX:
						begin	
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b1;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b11;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 1;
							oData2Mem	<= 1;
							oFPALUContro<= FOPMOV;
							oFPRegWrite	<= 0;
						end	
					default: //instrucao invalida - funct 7
						begin
							oOrigAULA  	<= 1'b0;
							oOrigBULA 	<= 1'b0;
							oRegWrite	<= 1'b0;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b00;
							oOrigPC		<= 2'b00;
							oInstrType	<= 8'b00000000; // Null
							
							oOrigAFPULA	<= 0;
							oData2Mem	<= 0;
							oFPALUContro<= FOPNULL;
							oFPRegWrite	<= 0;
						end
				endcase
			end
		OPC_FP_FLW:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b1; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b10;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b01000000; // Null
				
				oOrigAFPULA	<= 1;
				oData2Mem	<= 1;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 1;
			end
		OPC_FP_FSW:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b1; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b10;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b01000000; // Null
				
				oOrigAFPULA	<= 1;
				oData2Mem	<= 1;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
			end
`endif		
      
		default: // instrucao invalida
        begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPNULL;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oInstrType	<= 8'b00000000; // Null
`ifdef RV32IMF
				oOrigAFPULA	<= 0;
				oData2Mem	<= 0;
				oFPALUContro<= FOPNULL;
				oFPRegWrite	<= 0;
`endif
        end
	endcase

endmodule
