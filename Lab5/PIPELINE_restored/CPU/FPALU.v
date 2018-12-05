`ifndef PARAM
	`include "Parametros.v"
`endif
//`define MULTICICLO
module FPALU (
	input iclock,
	input [31:0] idataa,idatab,
	input [4:0] icontrol,
	output reg [31:0] oresult,
	output reg 		  onan, ozero, ooverflow, ounderflow,
	output reg [31:0] oCompResult
	//output reg [31:0] mAnalisys
//`ifdef MULTICICLO
	,
	input				istart,
	output			oready
//`endif
);
	    
//wire [3:0] icontrol = FOPADD;   // Para análise
	
// Para a operacao add e sub
wire [31:0] resultadd;
wire nanadd,zeroadd,overflowadd,underflowadd;

// Para a operacao mul
wire [31:0] resultmul;
wire nanmul,zeromul,overflowmul,underflowmul;

// Para a operacao div
wire [31:0] resultdiv;
wire nandiv,zerodiv,overflowdiv,underflowdiv;
	
// Para a operacao sqrt
wire [31:0] resultsqrt;
wire nansqrt,zerosqrt,overflowsqrt;

// Para a operacao abs
wire [31:0] resultabs;
wire nanabs,zeroabs,overflowabs,underflowabs;

// Para a operacao compara_equal
wire resultc_eq;

// Para a operacao compara_menor
wire resultc_lt;

// Para a operacao compara_menorigual
wire resultc_le;

// Para a operacao converte simples_word
wire [31:0] resultcvt_s_w;

wire [31:0] resultcvt_s_w_u;

	
// Para a operacao converte word_simples
wire [31:0] resultcvt_w_s;
wire nancvt_w_s,overflowcvt_w_s,underflowcvt_w_s;

//`ifdef MULTICICLO
wire [4:0] contador;

always @(posedge iclock or posedge istart)
	begin
		if (istart)
			begin
				contador <= 5'd0;
				oready <= 1'd0;
			end
		else
			begin
				if ((icontrol == FOPSUB) && (contador == 5'd8))
					oready <= 1'd1;
				else if (icontrol == FOPADD && contador == 5'd8)
					oready <= 1'd1;
				else if (icontrol == FOPMUL && contador == 5'd6)
					oready <= 1'd1;
				else if (icontrol == FOPDIV && contador == 5'd7)
					oready <= 1'd1;
				else if (icontrol == FOPSQRT && contador == 5'd17)
					oready <= 1'd1;
				else if (icontrol == FOPCVTSW && contador == 5'd7)
					oready <= 1'd1;
				else if (icontrol == FOPCVTSWU && contador == 5'd7)
					oready <= 1'd1;
				else if (icontrol == FOPCVTWS && contador == 5'd7)
					oready <= 1'd1;
				else if (icontrol == FOPCVTWUS && contador == 5'd7)
					oready <= 1'd1;
				else if (icontrol == FOPABS && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPNEG && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPCEQ && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPCLT && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPCLE && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPSGNJS && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPSGNJN && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPSGNJX && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPMIN && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPMAX && contador == 5'd1)
					oready <= 1'd1;
				else if (icontrol == FOPNULL && contador == 5'd1)
					oready <= 1'd1;
				else
					contador <= contador + 5'd1;
			end
	end
//`endif

always @(*)
	begin
		case (icontrol) 
			FOPADD,
			FOPSUB:		//soma e Subtração
			begin
				oresult = resultadd;
				onan = nanadd;
				ozero = zeroadd;
				ooverflow = overflowadd;
				ounderflow = underflowadd;
			end
			
			FOPMUL:		//multiplicação
			begin
				oresult = resultmul;
				onan = nanmul;
				ozero = zeromul;
				ooverflow = overflowmul;
				ounderflow = underflowmul;
			end

			FOPDIV:		//divisão
			begin
				oresult = resultdiv;
				onan = nandiv;
				ozero = zerodiv;
				ooverflow = overflowdiv;
				ounderflow = underflowdiv;
			end

			FOPSQRT:		//sqrt
			begin
				oresult = resultsqrt;
				onan = nansqrt;
				ozero = zerosqrt;
				ooverflow = overflowsqrt;
				ounderflow = 1'b0;
			end

			FOPABS:		//abs
			begin
				oresult = resultabs;
				onan = nanabs;
				ozero = zeroabs;
				ooverflow = overflowabs;
				ounderflow = underflowabs;
			end
			
			FOPNEG:		//neg
			begin
				oresult[31] = ~idataa[31];
				oresult[30:0] = idataa[30:0];
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end

			FOPCEQ:		//c_eq
			begin
				oresult = {31'b0,resultc_eq};
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end

			FOPCLT:		//c_lt
			begin
				oresult = {31'b0,resultc_lt};
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			
			FOPCLE:		//c_le
			begin
				oresult = {31'b0,resultc_le};
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end

			FOPCVTSW:		//cvt_s_w
			begin
				oresult = resultcvt_s_w;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end

			FOPCVTWS:		//cvt_w_s
			begin
				oresult = resultcvt_w_s;
				onan = nancvt_w_s;
				ozero = (resultcvt_w_s==32'b0);
				ooverflow = overflowcvt_w_s;
				ounderflow = underflowcvt_w_s;
			end
			FOPCVTSWU:
			begin
				oresult = resultcvt_s_w_u;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			FOPCVTWUS:
			begin
				oresult = $unsigned(resultcvt_w_s);
				onan = nancvt_w_s;
				ozero = (resultcvt_w_s==32'b0);
				ooverflow = overflowcvt_w_s;
				ounderflow = underflowcvt_w_s;
			end
			
			FOPSGNJS:
			begin
				oresult = {idataa[31],idatab[30:0]};
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			
			FOPSGNJN:
			begin
				oresult = {~idataa[31],idatab[30:0]};
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			
			FOPSGNJX:
			begin
				oresult = {idataa[31]^idatab[31],idatab[30:0]};
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			
			FOPMIN:
			begin
				oresult = resultc_lt == 1 ? idataa : idatab;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			
			FOPMAX:
			begin
				oresult = resultc_le == 0 ? idataa : idatab;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			
			FOPNULL:
			begin
				oresult = 32'd0;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			FOPMOV:
			begin
				oresult = idataa;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
			default:
			begin
				oresult = 32'd0;
				onan = 1'b0;
				ozero = 1'b0;
				ooverflow = 1'b0;
				ounderflow = 1'b0;
			end
		endcase
	end

add_sub add1 (	
	.add_sub(icontrol==FOPADD),	
	.clock(iclock),
	.dataa(idataa),
	.datab(idatab),
	.nan(nanadd),
	.overflow(overflowadd),
	.result(resultadd),
	.underflow(underflowadd),
	.zero(zeroadd));

mul_s mul1 (
	.clock(iclock),
	.dataa(idataa),
	.datab(idatab),
	.nan(nanmul),
	.overflow(overflowmul),
	.result(resultmul),
	.underflow(underflowmul),
	.zero(zeromul));
	
div_s div1 (
	.clock(iclock),
	.dataa(idataa),
	.datab(idatab),
	.nan(nandiv),
	.overflow(overflowdiv),
	.result(resultdiv),
	.underflow(underflowdiv),
	.zero(zerodiv));

sqrt_s sqrt1 (
	.clock(iclock),
	.data(idataa),
	.nan(nansqrt),
	.overflow(overflowsqrt),
	.result(resultsqrt),
	.zero(zerosqrt));
	
abs_s abs1 (
	.data(idataa),
	.nan(nanabs),
	.overflow(overflowabs),
	.result(resultabs),
	.underflow(underflowabs),
	.zero(zeroabs));

c_comp c_comp1 (
	.clock (iclock),
	.dataa (idataa),
	.datab (idatab),
	.aeb (resultc_eq),
	.alb (resultc_lt),
	.aleb (resultc_le));

cvt_s_w cvt_s_w1 (
	.clock (iclock),
	.dataa (idataa),
	.result (resultcvt_s_w));
	
cvt_s_w_u cvt_s_w_u (
	.clk (iclock),
	.a (idataa),
	.q (resultcvt_s_w_u));
	
cvt_w_s cvt_w_s1 (
	.clock (iclock),
	.dataa (idataa),
	.nan (nancvt_w_s),
	.overflow (overflowcvt_w_s),
	.result (resultcvt_w_s),
	.underflow (underflowcvt_w_s));

endmodule
