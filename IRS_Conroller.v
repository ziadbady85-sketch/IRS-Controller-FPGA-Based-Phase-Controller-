module IRS_Conroller #(parameter N      = 100   ,
	                   parameter IDLE   = 2'b00 ,
                       parameter LOAD   = 2'b01 ,
                       parameter DIVIDE = 2'b11 )(
	input clk , rst , AI_start , 
	input [2*N-1:0] AI_PHASES ,
	output reg [N-1:0] PINA , PINB ,
	output reg UPDATE_IRS , DONE_AI);


reg [1:0] FPGA_PHASES [0:N-1] ;
reg [1:0] cs , ns ;

always @(posedge clk or posedge rst) begin
 	if (rst) 
 		cs <= IDLE ;
 
 	else 
 		cs <= ns ;
 end 

always @(*) begin
	case (cs)
	 IDLE : ns = (AI_start)? LOAD : IDLE ;
	 LOAD : ns = DIVIDE ;
	 DIVIDE : ns = IDLE ;
	 default : ns = IDLE ;
	endcase
end

integer i ;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		PINA <= 0 ;
		PINB <= 0 ;
		UPDATE_IRS  <= 0 ;
	    DONE_AI <= 0 ;
	
	end
	else  begin
	   case (cs)
		LOAD : begin
			for (i = 0; i < N; i = i + 1)
                    FPGA_PHASES[i] <= AI_PHASES[2*i +: 2];
				
		
			
		end

		DIVIDE : begin
			for (i=0 ; i<N ; i=i+1) begin
				PINA[i] <= FPGA_PHASES[i][0] ;
				PINB[i] <= FPGA_PHASES[i][1] ;
			end

			UPDATE_IRS  <= 1 ;
			DONE_AI     <= 1 ;
			
		end

		default : begin
			PINA <= 0 ;
		    PINB <= 0 ;
		    UPDATE_IRS  <= 0 ;
			DONE_AI     <= 0 ;
		  
		end
	  endcase
	end
end

endmodule