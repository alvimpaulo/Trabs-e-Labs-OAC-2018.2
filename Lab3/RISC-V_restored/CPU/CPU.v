/* Definicao do processador */
`ifndef PARAM
	`include "../Parametros.v"
`endif


module CPU (
    input  wire        iCLK, iCLK50, iRST,
    input  wire [31:0] iInitialPC,
	 
    //sinais de monitoramento
	 output wire [31:0] mPC, 
	 output wire [31:0] mInstr,
	 output wire [31:0] mDebug,
//`ifdef RV32IMF
	 input  wire 		  mRegDispFPouInt,		// Selecionar Banco de Reg para mostrar
//`endif
    input  wire [4:0]  mRegDispSelect,
    output wire [31:0] mRegDisp,
    output wire [5:0]  mControlState,
    input  wire [4:0]  mVGASelect,
    output wire [31:0] mVGARead,
	 output wire [31:0] mRead1,
	 output wire [31:0] mRead2,
	 output wire [31:0] mRegWrite,
	 output wire [31:0] mULA,	 
	 
    //barramentos de dados
    output wire        DwReadEnable, DwWriteEnable,
    output wire [3:0]  DwByteEnable,
    output wire [31:0] DwAddress,
    output wire [31:0] DwWriteData,
    input  wire [31:0] DwReadData,

    // barramentos de instrucoes
    output wire        IwReadEnable, IwWriteEnable,
    output wire [3:0]  IwByteEnable,
	 output wire [31:0] IwAddress,
    output wire [31:0] IwWriteData,
    input  wire [31:0] IwReadData

    //interrupcoes
//    input wire [7:0]       iPendingInterrupt
);




/*************  UNICICLO *********************************/
`ifdef UNICICLO

assign mControlState    = 6'b000000;

Datapath_UNI Processor (
    .iCLK(iCLK),
    .iCLK50(iCLK50),
    .iRST(iRST),
    .iInitialPC(iInitialPC),

	 // Sinais de monitoramento
    .mPC(mPC),
    .mInstr(mInstr),
    .mDebug(mDebug),
	 .mRegDispFPouInt(mRegDispFPouInt),
    .mRegDispSelect(mRegDispSelect),
    .mRegDisp(mRegDisp),
    .mVGASelect(mVGASelect),
    .mVGARead(mVGARead),
	 .mRead1(mRead1),
	 .mRead2(mRead2),
	 .mRegWrite(mRegWrite),
	 .mULA(mULA),
	 
    // Barramento de dados
    .DwReadEnable(DwReadEnable), .DwWriteEnable(DwWriteEnable),
    .DwByteEnable(DwByteEnable),
    .DwWriteData(DwWriteData),
    .DwReadData(DwReadData),
    .DwAddress(DwAddress),
	 
    // Barramento de instrucoes
    .IwReadEnable(IwReadEnable), .IwWriteEnable(IwWriteEnable),
    .IwByteEnable(IwByteEnable),
    .IwWriteData(IwWriteData),
    .IwReadData(IwReadData),
    .IwAddress(IwAddress)
);
 `endif

 

/*************  MULTICICLO **********************************/

`ifdef MULTICICLO

assign IwReadEnable     = 1'b0;
assign IwWriteEnable    = 1'b0;
assign IwByteEnable     = 4'b0000;
assign IwWriteData      = 32'h00000000;
assign IwAddress        = 32'h00000000;

Datapath_MULTI Processor (
    .iCLK(iCLK),
    .iCLK50(iCLK50),
    .iRST(iRST),
    .iInitialPC(iInitialPC),

	 // Sinais de monitoramento
    .mPC(mPC),
    .mInstr(mInstr),
    .mDebug(mDebug),
    .mRegDispSelect(mRegDispSelect),
    .mRegDisp(mRegDisp),
    .mVGASelect(mVGASelect),
    .mVGARead(mVGARead),
    .mControlState(mControlState),
	 .mRead1(mRead1),
	 .mRead2(mRead2),
	 .mRegWrite(mRegWrite),
	 .mULA(mULA),
	 
    // Barramento
    .DwWriteEnable(DwWriteEnable), .DwReadEnable(DwReadEnable),
    .DwByteEnable(DwByteEnable),
    .DwWriteData(DwWriteData),
    .DwAddress(DwAddress),
    .DwReadData(DwReadData)
);
`endif





/*************  PIPELINE **********************************

`ifdef PIPELINE

assign wControlState    = 6'b111111;


Datapath_PIPEM Processor (
    .iCLK(iCLK),
    .iCLK50(iCLK50),
    .iRST(iRST),
    .iInitialPC(iInitialPC),

	  // Sinais de monitoramento
    .mPC(mPC),
    .mInstr(mInstr),
    .mDebug(mDebug),
    .mRegDispSelect(mRegDispSelect),
    .mRegDisp(mRegDisp),
    .mVGASelect(mVGASelect),
    .mVGARead(VGARead),
	 .mRead1(mRead1),
	 .mRead2(mRead2),
	 .mRegWrite(mRegWrite),
	 .mULA(mULA),
	 
    // Barramento de dados
    .DwMemRead(DwReadEnable), .DwMemWrite(DwWriteEnable),
    .DwByteEnable(DwByteEnable),
    .DwMemWriteData(DwWriteData),
    .DwMemReadData(DwReadData),
    .DwMemAddress(DwAddress),
	 
    // Barramento de instrucoes
    .IwMemRead(IwReadEnable), .IwMemWrite(IwWriteEnable),
    .IwByteEnable(IwByteEnable),
    .IwMemWriteData(IwWriteData),
    .IwMemReadData(IwReadData),
    .IwMemAddress(IwAddress)

);

`endif*/


endmodule
