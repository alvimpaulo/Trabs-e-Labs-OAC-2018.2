`ifndef PARAM
	`include "../Parametros.v"
`endif

// *
// * Bloco de Controle MULTICICLO
// *
	
module Control_MULTI (

	input  			 iCLK, iRST,
	input		[31:0] iInstr,
	output 			 oEscreveIR,
	output 			 oEscrevePC,
	output 			 oEscrevePCCond,
	output 			 oEscrevePCBack,
   output 	[ 1:0] oOrigAULA,
   output 	[ 1:0] oOrigBULA,	 
   output 	[ 1:0] oMem2Reg,
	output 	[ 1:0] oOrigPC,
	output 			 oIouD,
   output 			 oRegWrite,
   output 			 oMemWrite,
	output 			 oMemRead,
	output 	[ 4:0] oALUControl,
	output   [ 5:0] oState
	);


reg 	[ 5:0]  pr_state;		// present state
wire  [ 5:0]  nx_state;		// next state

wire [6:0] Opcode = iInstr[ 6: 0];
wire [2:0] Funct3	= iInstr[14:12];
wire [6:0] Funct7	= iInstr[31:25];

assign	oState	= pr_state;

reg [4:0] contador;

initial
	begin
		pr_state	<= ST_FETCH;
		contador <= 5'd0;
	end



// a cada ciclo de Clock
always @(posedge iCLK or posedge iRST)
	begin
		if (iRST)
			begin
				pr_state	<= ST_FETCH;
				contador <= 5'd1;
			end
		else
			begin
				pr_state	<= nx_state;
				if (nx_state == ST_DIVREM)
					contador <= contador + 5'd1;
				else
					contador <= 5'd0;
			end
	end



always @(*)
	case (pr_state)
		ST_FETCH:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b1;
				oALUControl 	<= OPNULL;			
				
				nx_state 		<= ST_FETCH1;
			end

		ST_FETCH1:
			begin
				oEscreveIR 		<= 1'b1;
				oEscrevePC 		<= 1'b1;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b1;
				oOrigAULA 		<= 2'b01;
				oOrigBULA 		<= 2'b01;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b1;
				oALUControl 	<= OPADD;			
				
				nx_state 		<= ST_DECODE;
			end
			
		ST_DECODE:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b10;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPADD;			
				
				case (Opcode)
					OPC_LOAD,
					OPC_STORE:	nx_state 		<= ST_LWSW;
					OPC_RTYPE:	nx_state 		<= ST_RTYPE;
					OPC_OPIMM:	nx_state 		<= ST_IMMTYPE;
					OPC_LUI:		nx_state 		<= ST_LUI;
					OPC_AUIPC:	nx_state 		<= ST_AUIPC;
					OPC_BRANCH:	nx_state 		<= ST_BRANCH;					
					OPC_JALR:	nx_state 		<= ST_JALR;
					OPC_JAL:		nx_state 		<= ST_JAL;
					OPC_SYS:		nx_state 		<= ST_SYS;
					OPC_URET:	nx_state 		<= ST_URET;
					default:
									nx_state 		<= ST_ERRO;
				endcase		
			end	

		ST_LWSW:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPADD;			
				
				case (Opcode)
					OPC_LOAD:	nx_state 		<= ST_LW;
					OPC_STORE:	nx_state 		<= ST_SW;
					default:
									nx_state 		<= ST_ERRO;
				endcase		
			end	
	

		ST_LW:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b1;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b1;
				oALUControl 	<= OPADD;			

				nx_state 		<= ST_LW1;
			end

		ST_LW1:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b1;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b1;
				oALUControl 	<= OPNULL;			

				nx_state 		<= ST_LW2;
			end			
			
		ST_LW2:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b10;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b1;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;			

				nx_state 		<= ST_FETCH;
			end
		
		ST_SW:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b1;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b1;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;			

				nx_state 		<= ST_SW1;
			end

		ST_SW1:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;			

				nx_state 		<= ST_FETCH;
			end			

		ST_RTYPE:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
						
				nx_state 		<= ST_ULAREGWRITE;
				
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
						default:// instrucao invalida
							begin 
								oALUControl 	<= OPNULL;		
								nx_state			<= ST_ERRO;
							end			
					endcase
`ifdef RV32M										
				FUNCT7_MULDIV:
					case (Funct3)
						FUNCT3_MUL:			 oALUControl <= OPMUL; 
						FUNCT3_MULH:		 oALUControl <= OPMULH;    
						FUNCT3_MULHSU:		 oALUControl <= OPMULHSU; 
						FUNCT3_MULHU:		 oALUControl <= OPMULHU;
						FUNCT3_DIV:		begin	 oALUControl <= OPDIV;  nx_state <= ST_DIVREM; end
						FUNCT3_DIVU:	begin	 oALUControl <= OPDIVU;	nx_state <= ST_DIVREM; end
						FUNCT3_REM:		begin	 oALUControl <= OPREM;	nx_state <= ST_DIVREM; end
						FUNCT3_REMU:	begin	 oALUControl <= OPREMU;	nx_state <= ST_DIVREM; end
						default: // instrucao invalida
							begin 
								oALUControl 	<= OPNULL;		
								nx_state			<= ST_ERRO;
							end	
					endcase				
`endif					
				default: // instrucao invalida
					begin 
						oALUControl 	<= OPNULL;		
						nx_state			<= ST_ERRO;
					end					
			endcase
		end			


		ST_DIVREM:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;			
				case (Funct3)
						FUNCT3_DIV:		oALUControl <= OPDIV;
						FUNCT3_DIVU:	oALUControl <= OPDIVU;
						FUNCT3_REM:		oALUControl <= OPREM;
						FUNCT3_REMU:	oALUControl <= OPREMU;
						default: // instrucao invalida
							begin 
								oALUControl 	<= OPNULL;		
								nx_state			<= ST_ERRO;
							end	
				endcase			
				if(contador == 5'd6)
						nx_state 	<= ST_ULAREGWRITE;
				else
						nx_state 	<= ST_DIVREM;
			
			end
	
		ST_IMMTYPE:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
						
				nx_state 		<= ST_ULAREGWRITE;
				
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
							oALUControl 	<= OPNULL;		
							nx_state			<= ST_ERRO;
						end				
				endcase
			end


	
		ST_ULAREGWRITE:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b1;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;

				nx_state 		<= ST_FETCH;
			end		

		ST_LUI:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPLUI;
						
				nx_state 		<= ST_ULAREGWRITE;
			end			
	
		ST_AUIPC:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b10;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPADD;

				nx_state 		<= ST_ULAREGWRITE;
			end
	
		ST_BRANCH:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b1;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b01;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;			

				nx_state 		<= ST_FETCH;
			end

		ST_JAL:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b1;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;
				oMem2Reg 		<= 2'b01;
				oOrigPC 			<= 2'b01;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b1;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;			

				nx_state 		<= ST_FETCH;
			end


		ST_JALR:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b1;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b10;	 
				oMem2Reg 		<= 2'b01;
				oOrigPC 			<= 2'b10;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b1;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPADD;			

				nx_state 		<= ST_FETCH;
			end			

			
		
		ST_ERRO:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;
				
				nx_state			<= ST_FETCH;	// Descarta instrucoes invalidas
			end

		// Instrucao invalida
		default:
			begin
				oEscreveIR 		<= 1'b0;
				oEscrevePC 		<= 1'b0;
				oEscrevePCCond <= 1'b0;
				oEscrevePCBack <= 1'b0;
				oOrigAULA 		<= 2'b00;
				oOrigBULA 		<= 2'b00;	 
				oMem2Reg 		<= 2'b00;
				oOrigPC 			<= 2'b00;
				oIouD 			<= 1'b0;
				oRegWrite 		<= 1'b0;
				oMemWrite 		<= 1'b0;
				oMemRead 		<= 1'b0;
				oALUControl 	<= OPNULL;
				
				nx_state 		<= ST_ERRO;
			end
		
	endcase


endmodule
