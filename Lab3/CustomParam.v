/* ******************************************** */
/* * Parametros da ISA RV32						 * */
/* * 														 * */
/* * 2018-2	Marcus Vinicius Lamar				 * */
/* ******************************************** */


`ifndef PARAM
`define PARAM

/* Para identificar se MULDIV deve ser sintetizado */
`ifdef RV32IM
  `define RV32M
`elsif RV32IMF
  `define RV32M
`endif

/* Parametros Gerais*/
parameter
    ON          = 1'b1,
    OFF         = 1'b0,
    ZERO        = 32'h00000000,

/* Operacoes da ULA */
	OPAND		= 5'd0,
	OPOR		= 5'd1,
	OPXOR		= 5'd2,
	OPADD		= 5'd3,
	OPSUB		= 5'd4,
	OPSLT		= 5'd5,
	OPSLTU	= 5'd6,
	OPSLL		= 5'd7,
	OPSRL		= 5'd8,
	OPSRA		= 5'd9,
	OPLUI		= 5'd10,
	OPMUL		= 5'd11,
	OPMULH	= 5'd12,
	OPMULHU	= 5'd13,
	OPMULHSU	= 5'd14,
	OPDIV		= 5'd15,
	OPDIVU	= 5'd16,
	OPREM		= 5'd17,
	OPREMU	= 5'd18,
	OPNULL	= 5'd31, // saída ZERO
		
/* Operacoes da ULA FP */
	FOPADD      = 4'd0,
	FOPSUB      = 4'd1,
	FOPMUL      = 4'd2,
	FOPDIV      = 4'd3,
	FOPSQRT     = 4'd4,
	FOPABS      = 4'd5,
	FOPNEG      = 4'd6,
	FOPCEQ      = 4'd7,
	FOPCLT      = 4'd8,
	FOPCLE      = 4'd9,
	FOPCVTSW    = 4'd10,
	FOPCVTWS    = 4'd11,    
    FOPCVTSWU   = 4,d12,    //criar operação
    FOPCVTWUS   = 4'd13,    //criar operação
    FOPSGNJS    = 4'd14,    //criar operação		
    FOPSGNJN    = 4'd15,    //criar operação
    FOPSGNJX    = 4'd16,    //criar operação
    FOPMIN      = 4'd17,    //criar operação
    FOPMAX      = 4'd18,    //criar operação



/* Campo OpCode */
	OPC_LOAD       	= 7'b0000011,
	OPC_OPIMM     	= 7'b0010011,
	OPC_AUIPC      	= 7'b0010111,
	OPC_STORE      	= 7'b0100011,
	OPC_RTYPE    	= 7'b0110011,
	OPC_LUI     	= 7'b0110111,
	OPC_BRANCH     	= 7'b1100011,
	OPC_JALR       	= 7'b1100111,
	OPC_JAL        	= 7'b1101111,
	OPC_SYS			= 7'b1110111,
	OPC_URET		= 7'b1110011,
    OPC_FP_RTYPE    = 7'b1010011,
    OPC_FP_FLW      = 7'b0000111,  
    OPC_FP_FSW      = 7'b0100111,

/* Campo Funct7 */
	FUNCT7_ADD			= 7'b0000000,
    FUNCT7_SUB          = 7'b0100000,
	FUNCT7_SLL			= 7'b0000000,
	FUNCT7_SLT			= 7'b0000000,
	FUNCT7_SLTU			= 7'b0000000,
	FUNCT7_XOR			= 7'b0000000,
    FUNCT7_SRL          = 7'b0000000,
	FUNCT7_SRA          = 7'b0100000,
	FUNCT7_OR			= 7'b0000000,
	FUNCT7_AND			= 7'b0000000,
	FUNCT7_MULDIV	    = 7'b0000001,
	FUNCT7_ECALL		= 7'b0000000,
	FUNCT7_URET			= 7'b0010000,
    FUNCT7_FP_ADD       = 7'b0000000 ,
    FUNCT7_FP_SUB       = 7'b0000100 ,
    FUNCT7_FP_MUL       = 7'b0001000 ,
    FUNCT7_FP_DIV       = 7'b0001100 ,
    FUNCT7_FP_SIGN      = 7'b0010000 ,
    FUNCT7_FP_MINMAX    = 7'b0010100 ,    
    FUNCT7_FP_SQRT      = 7'b0101100 ,
    FUNCT7_FP_COMP      = 7'b1010000 ,
    FUNCT7_FP_CVTWS     = 7'b1100000 , 
    FUNCT7_FP_CVTSW     = 7'b1101000 , 
    FUNCT7_FP_MVXW      = 7'b1110000 ,
    FUNCT7_FP_MVWX      = 7'b1111000 ,	

/* Campo Funct3 */
	FUNCT3_LB			= 3'b000,
	FUNCT3_LH			= 3'b001,
	FUNCT3_LW			= 3'b010,
	FUNCT3_LBU			= 3'b100,
	FUNCT3_LHU			= 3'b101,

	FUNCT3_SB			= 3'b000,
	FUNCT3_SH			= 3'b001,
	FUNCT3_SW			= 3'b010,	
	
	FUNCT3_ADD			= 3'b000,
	FUNCT3_SUB			= 3'b000,
	FUNCT3_SLL			= 3'b001,
	FUNCT3_SLT			= 3'b010,
	FUNCT3_SLTU			= 3'b011,
	FUNCT3_XOR			= 3'b100,
	FUNCT3_SRL			= 3'b101,
	FUNCT3_SRA			= 3'b101,
	FUNCT3_OR			= 3'b110,
	FUNCT3_AND			= 3'b111,
	
	FUNCT3_BEQ			= 3'b000,
	FUNCT3_BNE			= 3'b001,
	FUNCT3_BLT			= 3'b100,
	FUNCT3_BGE			= 3'b101,
	FUNCT3_BLTU			= 3'b110,
	FUNCT3_BGEU			= 3'b111,
	
	FUNCT3_JALR			= 3'b000,

	FUNCT3_ECALL		= 3'b000,

	FUNCT3_MUL			= 3'b000,
	FUNCT3_MULH			= 3'b001,
	FUNCT3_MULHSU		= 3'b010,
	FUNCT3_MULHU		= 3'b011,
	FUNCT3_DIV			= 3'b100,
	FUNCT3_DIVU			= 3'b101,
	FUNCT3_REM			= 3'b110,
	FUNCT3_REMU			= 3'b111,

	/* FLOAT POINT */
	FUNCT3_FLE			= 3'b000;
	FUNCT3_FLT			= 3'b001;
	FUNCT3_FEQ			= 3'b010;
	FUNCT3_MIN			= 3'b000;
	FUNCT3_MAX			= 3'b001;
	FUNCT3_FSGNJS		= 3'b000;
	FUNCT3_FSGNJNS		= 3'b001;
	FUNCT3_FSGNJXS		= 3'b010;

	/*RS2*/

	RS2_CVTWS 			= 5'b00000;
	RS2_CVTWUS			= 5'b00001;
	RS2_CVTSW 			= 5'b00000;
	RS2_CVTSWU			= 5'b00001;


/* ADDRESS MACROS *****************************************************************************************************/

    BACKGROUND_IMAGE    = "display.mif",


    BEGINNING_TEXT      = 32'h0040_0000,
	 TEXT_WIDTH				= 14+2,					// 16384 words = 16384x4 = 64ki bytes	 
    END_TEXT            = (BEGINNING_TEXT + 2**TEXT_WIDTH) - 1,	 

	 
    BEGINNING_DATA      = 32'h1001_0000,
	 DATA_WIDTH				= 15+2,					// 32768 words = 32768x4 = 128ki bytes
    END_DATA            = (BEGINNING_DATA + 2**DATA_WIDTH) - 1,	 


	 STACK_ADDRESS       = END_DATA-3,


//    BEGINNING_KTEXT     = 32'h8000_0000,
//	 KTEXT_WIDTH			= 13,					// 2048 words = 2048x4 = 8192 bytes
//    END_KTEXT           = (BEGINNING_KTEXT + 2**KTEXT_WIDTH) - 1,	 	 
//	 
//    BEGINNING_KDATA     = 32'h9000_0000,
//	 KDATA_WIDTH			= 12,					// 1024 words = 1024x4 = 4096 bytes
//    END_KDATA           = (BEGINNING_KDATA + 2**KDATA_WIDTH) - 1,	 	 

	 
    BEGINNING_IODEVICES         = 32'hFF00_0000,
	 
    BEGINNING_VGA               = 32'hFF00_0000,
    END_VGA                     = 32'hFF01_2C00,  // 320 x 240 = 76800 bytes

    BEGINNING_VGA1              = 32'hFF10_0000,
    END_VGA1                    = 32'hFF11_2C00,  // 320 x 240 = 76800 bytes	 
	 
	 KDMMIO_CTRL_ADDRESS		     = 32'hFF20_0000,	// Para compatibilizar com o KDMMIO
	 KDMMIO_DATA_ADDRESS		  	  = 32'hFF20_0004,
	 
	 BUFFER0_TECLADO_ADDRESS     = 32'hFF20_0100,
    BUFFER1_TECLADO_ADDRESS     = 32'hFF20_0104,
	 
    TECLADOxMOUSE_ADDRESS       = 32'hFF20_0110,
    BUFFERMOUSE_ADDRESS         = 32'hFF20_0114,
	  
	 AUDIO_INL_ADDRESS           = 32'hFF20_0160,
    AUDIO_INR_ADDRESS           = 32'hFF20_0164,
    AUDIO_OUTL_ADDRESS          = 32'hFF20_0168,
    AUDIO_OUTR_ADDRESS          = 32'hFF20_016C,
    AUDIO_CTRL1_ADDRESS         = 32'hFF20_0170,
    AUDIO_CRTL2_ADDRESS         = 32'hFF20_0174,

    NOTE_SYSCALL_ADDRESS        = 32'hFF20_0178,
    NOTE_CLOCK                  = 32'hFF20_017C,
    NOTE_MELODY                 = 32'hFF20_0180,
    MUSIC_TEMPO_ADDRESS         = 32'hFF20_0184,
    MUSIC_ADDRESS               = 32'hFF20_0188,      // Endereco para uso do Controlador do sintetizador
    PAUSE_ADDRESS               = 32'hFF20_018C,
		
	 IRDA_DECODER_ADDRESS		 = 32'hFF20_0500,
	 IRDA_CONTROL_ADDRESS       = 32'hFF20_0504, 	 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
	 IRDA_READ_ADDRESS          = 32'hFF20_0508,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    IRDA_WRITE_ADDRESS         = 32'hFF20_050C,		 	// Relatorio questao B.10) - Grupo 2 - (2/2016)
    
	 STOPWATCH_ADDRESS			 = 32'hFF20_0510,	 		//Feito em 2/2016 para servir de cronometro
	 
	 LFSR_ADDRESS					 = 32'hFF20_0514,			// Gerador de numeros aleatorios
	 
	 KEYMAP0_ADDRESS				 = 32'hFF20_0520,			// Mapa do teclado 2017/2
	 KEYMAP1_ADDRESS				 = 32'hFF20_0524,
	 KEYMAP2_ADDRESS				 = 32'hFF20_0528,
	 KEYMAP3_ADDRESS				 = 32'hFF20_052C,
	 
	 BREAK_ADDRESS					 = 32'hFF20_0600,  	  // Buffer do endereço do Break Point
	 
	 
/* STATES ************************************************************************************************************/
   ST_FETCH       = 6'd0,
   ST_DECODE      = 6'd1,
	ST_LWSW			= 6'd2,
	ST_LW				= 6'd3,
	ST_SW				= 6'd4,
	ST_LW2			= 6'd5,
	ST_RTYPE			= 6'd6,
	ST_ULAREGWRITE	= 6'd7,
	ST_BRANCH		= 6'd8,
	ST_JAL			= 6'd9,
	ST_IMMTYPE		= 6'd10,
	ST_JALR			= 6'd11,
	ST_AUIPC			= 6'd12,
	ST_LUI			= 6'd13,
	ST_SYS			= 6'd14, // nao implementado
	ST_URET			= 6'd15,	// nao implementado
	
	ST_WAITFP		= 6'd61, // nao implementado
	ST_WAIT			= 6'd62, // nao implementado
	ST_ERRO        = 6'd63; // Estado de Erro
	  
`endif