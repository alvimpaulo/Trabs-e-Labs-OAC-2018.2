`ifndef PARAM
	`include "../Parametros.v"
`endif

//*
// * Bloco de Controle UNICICLO
// *
 

 module Control_UNI(
    input  [31:0] iInstr, 
    output    	  oOrigAULA, oOrigBULA, oRegWrite, oMemWrite, oMemRead, oFPRegWrite, oMemWriteFPouInt, 
	output [1:0]  oMem2Reg, oOrigPC, oCompOuMvouCvt, oDataToRegFP
	output [4:0]  oALUControl
);


wire [6:0] Opcode   = iInstr[ 6: 0];
wire [2:0] Funct3	= iInstr[14:12];
wire [6:0] Funct7	= iInstr[31:25];
wire [4:0] RS2      = iInstr[24:20];


always @(*)
	case(Opcode)
		OPC_LOAD:
			begin
				oOrigAULA	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oMemWrite	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx; 
				oMemRead 	<= 1'b1; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b10;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
		OPC_OPIMM:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;

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
							oFPRegWrite <= 1'b0;
							oMemWriteFPouInt <= 1'bx;
							oMemWrite	<= 1'b0; 
							oMemRead 	<= 1'b0; 
							oALUControl	<= OPNULL;
							oMem2Reg 	<= 2'b00;
							oOrigPC		<= 2'b00;
							oCompOuMvouCvt <= 2'bxx;
							oDataToRegFP <= 2'bxx;
						end				
				endcase
			end
			
		OPC_AUIPC:
			begin
				oOrigAULA  	<= 1'b1;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
			
		OPC_STORE:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWrite	<= 1'b1;
				oMemWriteFPouInt <= 1'b1; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
		
		OPC_RTYPE:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0;
				oMemRead 	<= 1'b0; 
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
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
								oFPRegWrite <= 1'b0;
								oMemWriteFPouInt <= 1'bx;
								oMemWrite	<= 1'b0; 
								oMemRead 	<= 1'b0; 
								oALUControl	<= OPNULL;
								oMem2Reg 	<= 2'b00;
								oOrigPC		<= 2'b00;
								oCompOuMvouCvt <= 2'bxx;
								oDataToRegFP <= 2'bxx;
							end				
					endcase

`ifdef RV32M					
				FUNCT7_MULDIV:	
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
								oFPRegWrite <= 1'b0;
								oMemWriteFPouInt <= 1'bx;
								oMemWrite	<= 1'b0; 
								oMemRead 	<= 1'b0; 
								oALUControl	<= OPNULL;
								oMem2Reg 	<= 2'b00;
								oOrigPC		<= 2'b00;
								oCompOuMvouCvt <= 2'bxx;
								oDataToRegFP <= 2'bxx;
							end				
					endcase
`endif		
				default: // instrucao invalida
					begin
						oOrigAULA  	<= 1'b0;
						oOrigBULA 	<= 1'b0;
						oRegWrite	<= 1'b0;
						oFPRegWrite <= 1'b0;
						oMemWriteFPouInt <= 1'bx;
						oMemWrite	<= 1'b0; 
						oMemRead 	<= 1'b0; 
						oALUControl	<= OPNULL;
						oMem2Reg 	<= 2'b00;
						oOrigPC		<= 2'b00;
						oCompOuMvouCvt <= 2'bxx;
						oDataToRegFP <= 2'bxx;
					end				
			endcase			
		end
`ifdef RV32IMF
        //Adicionar as instruções tipo R com FP
        OPC_FP_RTYPE:
            begin
				oOrigAULA	<= 1'bx;
				oOrigBULA 	<= 1'bx;
				oMemWrite	<= 1'b0;
				oMemWriteFPouInt <= 1'bx; 
				oMemRead 	<= 1'b0; 
				oOrigPC		<= 2'b00;

                case (Funct7):
                    FUNCT7_FP_ADD:
						begin
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'bxx;
							oALUControl	<= FOPADD;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'bxx;
						end	
                    FUNCT7_FP_SUB:
						begin
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'bxx;
							oALUControl	<= FOPSUB;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'bxx;
						end	
                    FUNCT7_FP_MUL:
						begin
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'bxx;
							oALUControl	<= FOPMUL;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'bxx;
						end	
                    FUNCT7_FP_DIV:
						begin
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'bxx;
							oALUControl	<= FOPDIV;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'bxx;
						end
                    FUNCT7_FP_SIGN:
                        case (Funct3)
                            FUNCT3_FSGNJS:
								begin
									oRegWrite <= 1'b0;
									oFPRegWrite <= 1'b1;
									oMem2Reg 	<= 2'bxx;
									oALUControl	<= FOPSGNJS;
									oDataToRegFP <= 2'b00;
									oCompOuMvouCvt <= 2'bxx;
								end
							FUNCT3_FSGNJNS:
								begin
									oRegWrite <= 1'b0;
									oFPRegWrite <= 1'b1;
									oMem2Reg 	<= 2'bxx;
									oALUControl	<= FOPSGNJNS;
									oDataToRegFP <= 2'b00;
									oCompOuMvouCvt <= 2'bxx;
								end
							FUNCT3_FSGNJXS:	
								begin
									oRegWrite <= 1'b0;
									oFPRegWrite <= 1'b1;
									oMem2Reg 	<= 2'bxx;
									oALUControl	<= FOPSGNJXS;
									oDataToRegFP <= 2'b00;
									oCompOuMvouCvt <= 2'bxx;
								end
							default:
								begin
									oRegWrite <= 1'b0;
									oFPRegWrite <= 1'b0;
									oMem2Reg 	<= 2'bxx;
									oALUControl	<= OPNULL;
									oDataToRegFP <= 2'b00;
									oCompOuMvouCvt <= 2'bxx;
								end
                        endcase
                    FUNCT7_FP_MINMAX:
                        case (Funct3)
                            
                        endcase
                    FUNCT7_FP_SQRT:
                    FUNCT7_FP_COMP:
                        case (Funct3)
                            
                        endcase
                    FUNCT7_FP_CVTWS:
                        case (RS2)
                            
                        endcase
                    FUNCT7_FP_CVTSW:
                        case (RS2)
                            
                        endcase
                    FUNCT7_FP_MVXW:
                    FUNCT7_FP_MVWX:
                endcase
            end
        OPC_FP_FLW:
            begin
                
            end
        OPC_FP_FSW:
            begin
                oMemWriteFPouInt <= 1'b0;
            end
`endif
		
		OPC_LUI:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPLUI;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
			
		OPC_BRANCH:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b01;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
			
		OPC_JALR:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b01;
				oOrigPC		<= 2'b11;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
		
		OPC_JAL:
			begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b01;
				oOrigPC		<= 2'b10;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
			end
      
		default: // instrucao invalida
        begin
				oOrigAULA  	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oRegWrite	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'bx;
				oMemWrite	<= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPNULL;
				oMem2Reg 	<= 2'b00;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt <= 2'bxx;
				oDataToRegFP <= 2'bxx;
        end
	endcase

endmodule
