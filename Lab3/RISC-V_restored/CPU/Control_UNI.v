`ifndef PARAM
	`include "../Parametros.v"
`endif

//`ifdef RV32IM
//	`ifndef RV32M
//		`define RV32M
//	`endif
//`elsif RV32IMF
//	`ifndef RV32M
//		`define RV32M
//	`endif
//`endif

 module Control_UNI(
    input  [31:0] iInstr, 
    output    	 	oOrigAULA, oOrigBULA, oRegWrite, oMemWrite, oMemRead,
	 output [1:0]	oMem2Reg, oOrigPC,
	 output [4:0]  oALUControl
`ifdef RV32IMF
	,
	output			oOrigAFPULA, oFPRegWrite, oMemWriteFPouInt,
	output [1:0]	oCompOuMvouCvt, oDataToRegFP,
	output [4:0]  oFPALUControl

`endif

// monitoramento
//	output [31:0] CDebug
);

// teste
//`ifdef RV32M
//	assign CDebug = 32'd1;
//`else
//	assign CDebug = 32'd0;
//`endif
//
//initial CDebug = 32'd32;


wire [6:0] Opcode = iInstr[ 6: 0];
wire [2:0] Funct3	= iInstr[14:12];
wire [6:0] Funct7	= iInstr[31:25];
`ifdef RV32IMF
wire [4:0] RS2      = iInstr[24:20];
`endif

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
`ifdef RV32IMF
				oOrigAFPULA	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'b1;
				oCompOuMvouCvt <= 2'b11;
				oDataToRegFP <= 2'b11;
				oFPALUControl <= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'b1;
				oCompOuMvouCvt <= 2'b11;
				oDataToRegFP <= 2'b11;
				oFPALUControl <= FOPNULL;
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
`ifdef RV32IMF
							oOrigAFPULA	<= 1'b0;
							oFPRegWrite <= 1'b0;
							oMemWriteFPouInt <= 1'b1;
							oCompOuMvouCvt <= 2'b11;
							oDataToRegFP <= 2'b11;
							oFPALUControl <= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'b1;
				oCompOuMvouCvt <= 2'b11;
				oDataToRegFP <= 2'b11;
				oFPALUControl <= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'b1;
				oCompOuMvouCvt <= 2'b11;
				oDataToRegFP <= 2'b11;
				oFPALUControl <= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA	<= 1'b0;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'b1;
				oCompOuMvouCvt <= 2'b11;
				oDataToRegFP <= 2'b11;
				oFPALUControl <= FOPNULL;
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
`ifdef RV32IMF
								oOrigAFPULA	<= 1'b0;
								oFPRegWrite <= 1'b0;
								oMemWriteFPouInt <= 1'b1;
								oCompOuMvouCvt <= 2'b11;
								oDataToRegFP <= 2'b11;
								oFPALUControl <= FOPNULL;
`endif
							end				
					endcase

`ifdef RV32M					
				FUNCT7_MULDIV:
				begin
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
`ifdef RV32IMF
								oOrigAFPULA			<= 1'b0;
								oFPRegWrite 		<= 1'b0;
								oMemWriteFPouInt 	<= 1'b1;
								oCompOuMvouCvt 	<= 2'b11;
								oDataToRegFP 		<= 2'b11;
								oFPALUControl 		<= FOPNULL;
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
`ifdef RV32IMF
						oOrigAFPULA			<= 1'b0;
						oFPRegWrite 		<= 1'b0;
						oMemWriteFPouInt 	<= 1'b1;
						oCompOuMvouCvt 	<= 2'b11;
						oDataToRegFP 		<= 2'b11;
						oFPALUControl 		<= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA			<= 1'b1;
				oFPRegWrite 		<= 1'b0;
				oMemWriteFPouInt 	<= 1'b1;
				oCompOuMvouCvt 	<= 2'b11;
				oDataToRegFP 		<= 2'b11;
				oFPALUControl 		<= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA			<= 1'b1;
				oFPRegWrite 		<= 1'b0;
				oMemWriteFPouInt 	<= 1'b1;
				oCompOuMvouCvt 	<= 2'b11;
				oDataToRegFP 		<= 2'b11;
				oFPALUControl 		<= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA			<= 1'b1;
				oFPRegWrite 		<= 1'b0;
				oMemWriteFPouInt 	<= 1'b1;
				oCompOuMvouCvt 	<= 2'b11;
				oDataToRegFP 		<= 2'b11;
				oFPALUControl 		<= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA			<= 1'b1;
				oFPRegWrite 		<= 1'b0;
				oMemWriteFPouInt 	<= 1'b1;
				oCompOuMvouCvt 	<= 2'b11;
				oDataToRegFP 		<= 2'b11;
				oFPALUControl 		<= FOPNULL;
`endif
			end
`ifdef RV32IMF
        //Adicionar as instruções tipo R com FP
        OPC_FP_RTYPE:
            begin
				oOrigAULA	<= 1'b0;
				oOrigBULA 	<= 1'b0;
				oMemWrite	<= 1'b0;
				oMemWriteFPouInt <= 1'b1; 
				oMemRead 	<= 1'b0; 
				oOrigPC		<= 2'b00;
				oALUControl	<= OPNULL;

                case (Funct7)
                    FUNCT7_FP_ADD:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPADD;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
						end	
                    FUNCT7_FP_SUB:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPSUB;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
						end	
                    FUNCT7_FP_MUL:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPMUL;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
						end	
                    FUNCT7_FP_DIV:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPDIV;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
						end
                    FUNCT7_FP_SIGN:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
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
										oOrigAFPULA			<= 1'b1;
										oFPRegWrite 		<= 1'b0;
										oMemWriteFPouInt 	<= 1'b1;
										oCompOuMvouCvt 	<= 2'b11;
										oDataToRegFP 		<= 2'b11;
										oFPALUControl 		<= FOPNULL;
									end
							endcase
						end
                    FUNCT7_FP_MINMAX:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
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
										oOrigAFPULA			<= 1'b1;
										oFPRegWrite 		<= 1'b0;
										oMemWriteFPouInt 	<= 1'b1;
										oCompOuMvouCvt 	<= 2'b11;
										oDataToRegFP 		<= 2'b11;
										oFPALUControl 		<= FOPNULL;
									end
							endcase
						end
                    FUNCT7_FP_SQRT:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPSQRT;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
						end	
                    FUNCT7_FP_COMP:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b1;
							oFPRegWrite <= 1'b0;
							oMem2Reg 	<= 2'b11;
							oDataToRegFP <= 2'b11;
							oCompOuMvouCvt <= 2'b00;
							oALUControl	<= OPNULL;
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
										oOrigAFPULA			<= 1'b1;
										oFPRegWrite 		<= 1'b0;
										oMemWriteFPouInt 	<= 1'b1;
										oCompOuMvouCvt 	<= 2'b11;
										oDataToRegFP 		<= 2'b11;
										oFPALUControl 		<= FOPNULL;
									end
							endcase
						end
                    FUNCT7_FP_CVTWS:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b1;
							oFPRegWrite <= 1'b0;
							oMem2Reg 	<= 2'b11;
							oDataToRegFP <= 2'b11;
							oCompOuMvouCvt <= 2'b10;
							oALUControl	<= OPNULL;
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
										oOrigAFPULA			<= 1'b1;
										oFPRegWrite 		<= 1'b0;
										oMemWriteFPouInt 	<= 1'b1;
										oCompOuMvouCvt 	<= 2'b11;
										oDataToRegFP 		<= 2'b11;
										oFPALUControl 		<= FOPNULL;
									end
							endcase
						end
                    FUNCT7_FP_CVTSW:
						begin
							oOrigAFPULA	<= 1'b0;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oDataToRegFP <= 2'b00;
							oCompOuMvouCvt <= 2'b11;
							oALUControl	<= OPNULL;
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
										oOrigAFPULA			<= 1'b1;
										oFPRegWrite 		<= 1'b0;
										oMemWriteFPouInt 	<= 1'b1;
										oCompOuMvouCvt 	<= 2'b11;
										oDataToRegFP 		<= 2'b11;
										oFPALUControl 		<= FOPNULL;
									end
							endcase
						end
                    FUNCT7_FP_MVXW:
						begin
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b1;
							oFPRegWrite <= 1'b0;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPNULL;
							oALUControl	<= OPNULL;
							oDataToRegFP <= 2'b11;
							oCompOuMvouCvt <= 2'b01;
						end	
                    FUNCT7_FP_MVWX:
						begin	
							oOrigAFPULA	<= 1'b1;
							oRegWrite <= 1'b0;
							oFPRegWrite <= 1'b1;
							oMem2Reg 	<= 2'b11;
							oFPALUControl	<= FOPNULL;
							oALUControl	<= OPNULL;
							oDataToRegFP <= 2'b10;
							oCompOuMvouCvt <= 2'b11;
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
							oOrigAFPULA			<= 1'b1;
							oFPRegWrite 		<= 1'b0;
							oMemWriteFPouInt 	<= 1'b1;
							oCompOuMvouCvt 	<= 2'b11;
							oDataToRegFP 		<= 2'b11;
							oFPALUControl 		<= FOPNULL;
						end
                endcase
            end
        OPC_FP_FLW:
			begin
				oOrigAFPULA	<= 1'b1;
				oOrigAULA	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b0;
				oFPRegWrite <= 1'b1;
				oMemWriteFPouInt <= 1'b0; 
				oMemRead 	<= 1'b1; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b11;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt   <= 2'b11;
				oDataToRegFP     <= 2'b01;
				oFPALUControl    <= FOPNULL;
			end
        OPC_FP_FSW:
            begin
				oOrigAFPULA	<= 1'b1;
				oOrigAULA	<= 1'b0;
				oOrigBULA 	<= 1'b1;
				oRegWrite	<= 1'b0;
				oMemWrite	<= 1'b1;
				oFPRegWrite <= 1'b0;
				oMemWriteFPouInt <= 1'b0; 
				oMemRead 	<= 1'b0; 
				oALUControl	<= OPADD;
				oMem2Reg 	<= 2'b11;
				oOrigPC		<= 2'b00;
				oCompOuMvouCvt   <= 2'b11;
				oDataToRegFP     <= 2'b11;
				oFPALUControl    <= FOPNULL;
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
`ifdef RV32IMF
				oOrigAFPULA			<= 1'b1;
				oFPRegWrite 		<= 1'b0;
				oMemWriteFPouInt 	<= 1'b1;
				oCompOuMvouCvt 	<= 2'b11;
				oDataToRegFP 		<= 2'b11;
				oFPALUControl 		<= FOPNULL;
`endif
        end
	endcase

endmodule