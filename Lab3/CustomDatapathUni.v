`ifndef PARAM
	`include "../Parametros.v"
`endif

//
// Caminho de dados processador RISC-V Uniciclo
//
// 2018-2 Marcus Vinicius Lamar
//

module Datapath_UNI (
    // Inputs e clocks
    input  wire        iCLK, iCLK50, iRST,
    input  wire [31:0] iInitialPC,

    // Para monitoramento
    output wire [31:0] mPC, mInstr,
    output wire [31:0] mRegDisp,
    input  wire [ 4:0] mRegDispSelect,
    output wire [31:0] mDebug,	 
    input  wire [ 4:0] mVGASelect,
    output wire [31:0] mVGARead,
	 output wire [31:0] mRead1,
	 output wire [31:0] mRead2,
	 output wire [31:0] mRegWrite,
	 output wire [31:0] mULA,	 


    //  Barramento de Dados
    output wire        DwReadEnable, DwWriteEnable,
    output wire [ 3:0] DwByteEnable,
    output wire [31:0] DwAddress, DwWriteData,
    input  wire [31:0] DwReadData,

    // Barramento de Instrucoes
    output wire        IwReadEnable, IwWriteEnable,
    output wire [ 3:0] IwByteEnable,
    output wire [31:0] IwAddress, IwWriteData,
    input  wire [31:0] IwReadData

);



// ****************************************************** 
// Definicao dos fios e registradores							 

reg  [31:0] PC;
wire [31:0] wPC, wPC4;
wire [ 4:0] wRs1, wRs2, wRd;
wire [31:0] wRead1, wRead2, wRegWrite;
wire [31:0] wOrigAULA,wOrigBULA,wALUresult;
wire [31:0] wiPC;
wire 			wBranch;
wire [31:0] wBranchPC;
wire [31:0] wImmediate;
wire [31:0] wInstr;
wire [ 2:0] wFunct3;

// sinais do controle 
wire        wCRegWrite;
wire 		   wCOrigAULA,wCOrigBULA;
wire [ 1:0] wCOrigPC;
wire [ 1:0] wCMem2Reg;
wire 			wCMemRead, wCMemWrite;
wire [ 4:0] wCALUControl;


// Sinais de monitoramento e Debug
wire [31:0] wRegDisp, wVGARead;
wire [ 4:0] wRegDispSelect, wVGASelect;

assign mPC					= wPC; 
assign mInstr				= wInstr;
assign mRead1				= wRead1;
assign mRead2				= wRead2;
assign mRegWrite			= wRegWrite;
assign mULA					= wALUresult;
assign mDebug				= 32'h000ACE10;	// Ligar onde for preciso	
assign mRegDisp			= wRegDisp;
assign mVGARead			= wVGARead;
assign wRegDispSelect 	= mRegDispSelect;
assign wVGASelect 		= mVGASelect;


// ****************************************************** 
// Inicializacao do PC						  						 

initial
	begin
		PC         <= BEGINNING_TEXT;
	end


// ****************************************************** 
// Definicao das estruturas assign		  						 

assign wPC			= PC;
assign wPC4       = wPC + 32'h00000004;
assign wBranchPC  = wPC + wImmediate;
assign wRs1			= wInstr[19:15];
assign wRs2			= wInstr[24:20];
assign wRd			= wInstr[11: 7];
assign wFunct3		= wInstr[14:12];


// ****************************************************** 
// Instanciacao das estruturas 	 		  						 


// Barramento da Memoria de Instrucoes 
assign    IwReadEnable      = ON;
assign    IwWriteEnable     = OFF;
assign    IwByteEnable      = 4'b1111;
assign    IwAddress         = wPC;
assign    IwWriteData       = ZERO;
assign    wInstr            = IwReadData;


// Banco de Registradores 
Registers REGISTERS0 (
    .iCLK(iCLK),
    .iRST(iRST),
    .iReadRegister1(wRs1),
    .iReadRegister2(wRs2),
    .iWriteRegister(wRd),
    .iWriteData(wRegWrite),
    .iRegWrite(wCRegWrite),
    .oReadData1(wRead1),
    .oReadData2(wRead2),
	 
    .iRegDispSelect(wRegDispSelect),    // seleção para display
    .oRegDisp(wRegDisp),                // Reg display
    .iVGASelect(wVGASelect),            // para mostrar Regs na tela
    .oVGARead(wVGARead)                 // para mostrar Regs na tela
	);


// Unidade geradora do imediato 
ImmGen IMMGEN0 (
    .iInstrucao(wInstr),
    .oImm(wImmediate)
);


// ALU 
ALU ALU0 (
    .iControl(wCALUControl),
    .iA(wOrigAULA),
    .iB(wOrigBULA),
    .oResult(wALUresult),
    .oZero()
	);


// Unidade de controle de escrita 
wire [31:0] wMemDataWrite,wReadData;
wire [ 3:0] wMemEnable;

MemStore MEMSTORE0 (
    .iAlignment(wALUresult[1:0]),
    .iFunct3(wFunct3),
    .iData(wRead2),
    .oData(wMemDataWrite),
    .oByteEnable(wMemEnable),
    .oException()
	);

// Barramento da memoria de dados 
assign DwReadEnable     = wCMemRead;
assign DwWriteEnable    = wCMemWrite;
assign DwByteEnable     = wMemEnable;
assign DwWriteData      = wMemDataWrite;
assign wReadData        = DwReadData;
assign DwAddress        = wALUresult;

// Unidade de controle de leitura 
wire [31:0] wMemLoad;

MemLoad MEMLOAD0 (
    .iAlignment(wALUresult[1:0]),
    .iFunct3(wFunct3),
    .iData(wReadData),
    .oData(wMemLoad),
    .oException()
	);

	
	
// Unidade de Controle 
Control_UNI CONTROL0 (
    .iInstr(wInstr),
    .oOrigAULA(wCOrigAULA),
    .oOrigBULA(wCOrigBULA),	 
    .oMem2Reg(wCMem2Reg),
    .oRegWrite(wCRegWrite),
    .oMemWrite(wCMemWrite),
	 .oMemRead(wCMemRead),
    .oALUControl(wCALUControl),
    .oOrigPC(wCOrigPC)
	);


// Unidade de controle de Branches 
BranchControl BC0 (
    .iFunct3(wFunct3),
    .iA(wRead1), 
	 .iB(wRead2),
    .oBranch(wBranch)
);



// ******************************************************
// multiplexadores							  						 


always @(*)
    case(wCOrigAULA)
        1'b0:      wOrigAULA <= wRead1;
        1'b1:      wOrigAULA <= wPC;
		  default:	 wOrigAULA <= ZERO;
    endcase

	 

always @(*)
    case(wCOrigBULA)
        1'b0:      wOrigBULA <= wRead2;
        1'b1:      wOrigBULA <= wImmediate;
		  default:	 wOrigBULA <= ZERO;
    endcase	 
	 

	 
always @(*)
    case(wCMem2Reg)
        2'b00:     wRegWrite <= wALUresult;		// Tipo-R e Tipo-I
        2'b01:     wRegWrite <= wPC4;				// jalr e jal
        2'b10:     wRegWrite <= wMemLoad;			// Loads
        default:   wRegWrite <= ZERO;
    endcase

	 
always @(*)
	case(wCOrigPC)
		2'b00:     wiPC <= wPC4;												// PC+4
      2'b01:     wiPC <= wBranch ? wBranchPC: wPC4;					// Branches
      2'b10:     wiPC <= wBranchPC;											// jal
      2'b11:     wiPC <= (wRead1+wImmediate) & ~(32'h000000001);	// jalr
		default:	  wiPC <= ZERO;
	endcase




// ****************************************************** 
// A cada ciclo de clock					  						 


always @(posedge iCLK or posedge iRST)
begin
    if(iRST)
			PC	<= iInitialPC;
    else
			PC	<= wiPC;
end


endmodule
