`ifndef PARAM
	`include "../Parametros.v"
`endif

//
// Caminho de dados processador RISC-V Multiciclo
//
// 2018-2 Marcus Vinicius Lamar
//
 
module Datapath_MULTI (
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
	 output wire [ 5:0] mControlState,
	 output wire [31:0] mRead1,
	 output wire [31:0] mRead2,
	 output wire [31:0] mRegWrite,
	 output wire [31:0] mULA,	 


    //  Barramento
    output wire        DwReadEnable, DwWriteEnable,
    output wire [ 3:0] DwByteEnable,
    output wire [31:0] DwAddress, DwWriteData,
    input  wire [31:0] DwReadData
);





	
// ****************************************************** 
// Definicao dos fios e registradores							 

reg [31:0] PC, PCBack, IR, MDR, A, B, ALUOut;

wire [ 4:0] wRs1, wRs2, wRd;
wire [31:0] wRead1, wRead2, wRegWrite;
wire [31:0] wOrigAULA,wOrigBULA,wALUresult;
wire [31:0] wiPC;
wire [31:0] wMemAddress;
wire 			wBranch;
wire [31:0] wImmediate;
wire [ 2:0] wFunct3;

// sinais do controle 
wire        wCRegWrite, wCEscreveIR;
wire			wCEscrevePC, wCEscrevePCCond;
wire 			wCEscrevePCBack;
wire [ 1:0] wCOrigAULA;
wire [ 1:0] wCOrigBULA;
wire [ 1:0] wCOrigPC;
wire [ 1:0] wCMem2Reg;
wire			wCIouD;
wire 			wCMemRead, wCMemWrite;
wire [ 4:0] wCALUControl;
wire [ 5:0] wCState;


// Sinais de monitoramento e Debug
wire [31:0] wRegDisp, wVGARead;
wire [ 4:0] wRegDispSelect, wVGASelect;

assign mPC					= PC; 
assign mInstr				= IR;
assign mControlState		= wCState;
assign mRead1				= A;
assign mRead2				= B;
assign mRegWrite			= wRegWrite;
assign mULA					= ALUOut;
assign mDebug				= 32'h000ACE10;	// Ligar onde for preciso	
assign mRegDisp			= wRegDisp;
assign mVGARead			= wVGARead;
assign wRegDispSelect 	= mRegDispSelect;
assign wVGASelect 		= mVGASelect;


// ****************************************************** 
// Inicializacao dos registradores		  						 
initial
begin
	PC			<= BEGINNING_TEXT;
	PCBack 	<= BEGINNING_TEXT;
	IR			<= ZERO;
	ALUOut	<= ZERO;
	MDR 		<= ZERO;
	A 			<= ZERO;
	B 			<= ZERO;
end


 
// ****************************************************** 
// Definicao das estruturas assign		  						 

assign wRs1			= IR[19:15];
assign wRs2			= IR[24:20];
assign wRd			= IR[11:7];
assign wFunct3		= IR[14:12];


// ****************************************************** 
// Instanciacao das estruturas 	 		  						 


// Unidade de controle de escrita 
wire [31:0] wMemDataWrite,wReadData;
wire [ 3:0] wMemEnable;

MemStore MEMSTORE0 (
    .iAlignment(wMemAddress[1:0]),
    .iFunct3(wFunct3),
    .iData(B),
    .oData(wMemDataWrite),
    .oByteEnable(wMemEnable),
    .oException()
	);

// Barramento da memoria 
assign DwReadEnable     = wCMemRead;
assign DwWriteEnable    = wCMemWrite;
assign DwByteEnable     = wMemEnable;
assign DwWriteData      = wMemDataWrite;
assign wReadData        = DwReadData;
assign DwAddress        = wMemAddress;

// Unidade de controle de leitura 
wire [31:0] wMemLoad;

MemLoad MEMLOAD0 (
    .iAlignment(wMemAddress[1:0]),
    .iFunct3(wFunct3),
    .iData(wReadData),
    .oData(wMemLoad),
    .oException()
	);
	
	

// Unidade de Controle 
Control_MULTI CTRL0 (
	.iCLK(iCLK),
	.iRST(iRST),
	.iInstr(IR),
	.oEscreveIR(wCEscreveIR),
	.oEscrevePC(wCEscrevePC),
	.oEscrevePCCond(wCEscrevePCCond),
	.oEscrevePCBack(wCEscrevePCBack),
   .oOrigAULA(wCOrigAULA),
   .oOrigBULA(wCOrigBULA),	 
   .oMem2Reg(wCMem2Reg),
   .oRegWrite(wCRegWrite),
   .oMemWrite(wCMemWrite),
	.oMemRead(wCMemRead),
   .oOrigPC(wCOrigPC),
	.oIouD(wCIouD),
	.oALUControl(wCALUControl),
	.oState(wCState)
	);


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

	
// Unidade de controle de Branches 
BranchControl BC0 (
    .iFunct3(wFunct3),
    .iA(A), 
	 .iB(B),
    .oBranch(wBranch)
);


// Unidade geradora do imediato 
ImmGen IMMGEN0 (
    .iInstrucao(IR),
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





// ****************************************************** 
// multiplexadores							  						 



always @(*)
    case(wCOrigAULA)
        2'b00:    wOrigAULA <= A;
		  2'b01:		wOrigAULA <= PC;
		  2'b10:		wOrigAULA <= PCBack;
		  default:	wOrigAULA <= ZERO;
    endcase

	 
always @(*)
    case(wCOrigBULA)
        2'b00:    wOrigBULA <= B;
        2'b01:    wOrigBULA <= 32'h4;
		  2'b10:		wOrigBULA <= wImmediate;
		  default:	wOrigBULA <= ZERO;
    endcase	 
	 
	 
always @(*)
    case(wCMem2Reg)
        2'b00:    wRegWrite <= ALUOut;
        2'b01:    wRegWrite <= PC;
        2'b10:    wRegWrite <= MDR;
        default:  wRegWrite <= ZERO;
    endcase

	 
always @(*)
	case(wCOrigPC)
		2'b00:     wiPC <= wALUresult;				// PC+4
      2'b01:     wiPC <= ALUOut;						// Branches e jal
		2'b10:	  wiPC <= wALUresult & ~(32'h1);	// jalr
		default:	  wiPC <= ZERO;
	endcase
	
	
	
always @(*)
	case(wCIouD)
		1'b0:		wMemAddress <= PC;
		1'b1:		wMemAddress <= ALUOut;
		default:	wMemAddress <= ZERO;
	endcase
		

		


// ****************************************************** 
// A cada ciclo de clock					  						 

always @(posedge iCLK or posedge iRST)
	if (iRST)
	  begin
		PC			<= BEGINNING_TEXT;
		PCBack 	<= BEGINNING_TEXT;
		IR			<= ZERO;
		ALUOut	<= ZERO;
		MDR 		<= ZERO;
		A 			<= ZERO;
		B 			<= ZERO;
	  end
	else
	  begin
		// Unconditional 
		ALUOut	<= wALUresult;
		A			<= wRead1;
		B			<= wRead2;
		MDR		<= wMemLoad;

		// Conditional 
		if (wCEscreveIR)
			IR	<= wReadData;
			
		if (wCEscrevePCBack)
			PCBack <= PC;
			
		if (wCEscrevePC || wBranch & wCEscrevePCCond)
			PC	<= wiPC;	

	  end



endmodule 
