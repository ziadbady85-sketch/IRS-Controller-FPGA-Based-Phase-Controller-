module IRS_Conroller_tb();

parameter N      = 10    ;
parameter IDLE   = 2'b00 ;
parameter LOAD   = 2'b01 ;
parameter DIVIDE = 2'b11 ;

reg clk , rst , AI_start ; 
reg	[2*N-1:0] AI_PHASES ;
wire [N-1:0] PINA , PINB ;
wire UPDATE_IRS , DONE_AI ;

IRS_Conroller #(.N(N),.IDLE(IDLE),.LOAD(LOAD),.DIVIDE(DIVIDE))
           dut (.clk(clk),.rst(rst),.AI_PHASES(AI_PHASES),.AI_start(AI_start),
           	    .PINA(PINA),.PINB(PINB),.UPDATE_IRS(UPDATE_IRS),.DONE_AI(DONE_AI)) ;

initial begin
	clk = 0 ;
	forever #1 clk=~clk ;
end

integer i ;

initial begin
    
	rst = 1 ;
	AI_start = 0 ;
	AI_PHASES = 0 ;
	@(negedge clk) ;
	rst = 0 ;
	AI_start = 0 ;
	for (i = 0; i < N; i = i + 1) begin
        AI_PHASES[2*i +: 2] = $urandom_range(0,3);
        @(negedge clk) ;
    end

	@(negedge clk) ;
	AI_start = 1 ;

	for (i = 0; i < N; i = i + 1) begin
        AI_PHASES[2*i +: 2] = $urandom_range(0,3);
        @(negedge clk) ;
    end
	$stop ;
end

initial begin
	$monitor ("rst=%0d , AI_start=%0d , AI_PHASES=%0d , PINA=%0b , PINB=%0b ",rst , AI_start , AI_PHASES , PINA , PINB) ;

end

endmodule