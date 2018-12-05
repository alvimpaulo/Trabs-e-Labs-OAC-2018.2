/*
 * ALU
 *
 */
 

`ifndef PARAM
	`include "Parametros.v"
`endif
 
module ALU (
	input 		 [4:0]  iControl,
	input signed [31:0] iA, 
	input signed [31:0] iB,
	output reg	 	     oZero,
	output reg	 [31:0] oResult
	);

//	wire [4:0] iControl=OPMUL;		// Usado para as análises

assign oZero = (oResult == ZERO);  // Nao sera mais usado.


`ifdef RV32M
wire [63:0] mul, mulu, mulsu;
assign mul 	= iA * iB;
assign mulu = $unsigned(iA) * $unsigned(iB);
assign mulsu= iA * $unsigned(iB);
`endif


always @(*)
begin
    case (iControl)
		OPAND:
			oResult  <= iA & iB;
		OPOR:
			oResult  <= iA | iB;
		OPXOR:
			oResult  <= iA ^ iB;
		OPADD:
			oResult  <= iA + iB;
		OPSUB:
			oResult  <= iA - iB;
		OPSLT:
			oResult  <= iA < iB;
		OPSLTU:
			oResult  <= $unsigned(iA) < $unsigned(iB);
		OPSLL:
			oResult  <= iA << iB[4:0];
		OPSRL:
			oResult  <= iA >> iB[4:0];
		OPSRA:
			oResult  <= iA >>> iB[4:0];
		OPLUI:
			oResult  <= iB;
			
`ifdef RV32M	//	Modulo de multiplicacao e divisao
		OPMUL:
			oResult  <= mul[31:0];
		OPMULH:
			oResult  <= mul[63:32];
		OPMULHU:
			oResult  <= mulu[63:32];
		OPMULHSU:
			oResult  <= mulsu[63:32];	
		OPDIV:
			oResult  <= iA / iB;
		OPDIVU:
			oResult  <= $unsigned(iA) / $unsigned(iB);
		OPREM:
			oResult  <= iA % iB;
		OPREMU:
			oResult  <= $unsigned(iA) % $unsigned(iB);		
`endif

		OPNULL:
			oResult  <= ZERO;
			
		default:
			oResult  <= ZERO;
    endcase
end

endmodule
