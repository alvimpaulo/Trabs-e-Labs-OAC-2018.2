
`timescale 1 ns / 100 ps

module TopDE_tb;

	reg CLOCK;
	reg [9:0] SW;
	reg [3:0] KEY;
	wire [9:0] LEDR; 
	wire [6:0] HEX0, HEX1; 	
	

TopDE U0 (
	.CLOCK_50 (CLOCK),
	.SW(SW), 
	.KEY(KEY),
	.LEDR(LEDR), 
	.HEX0(HEX0), 
	.HEX1(HEX1) 
);



//Clock de 50MHz
always
	#10 CLOCK = ~CLOCK;

always @(posedge CLOCK)
	#20 SW=SW+1;


initial
	begin
		$display($time, " << Starting Simulation >> ");
		CLOCK = 1'b0;
		SW = 8'h00;
		KEY= 4'b1111;
	
		#800;
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

	
initial
	begin
		$display("\t\ttime,\tCLOCK,\tSW,\tHEX0,\tHEX1"); 
		$monitor("%d,\t%b,\t%b,\t%b,\t%b,",$time, CLOCK,SW,HEX0,HEX1);	
	end
	
	
endmodule
