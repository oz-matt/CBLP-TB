module ramwriter();

reg r_fakeclock = 0;
always #1 r_fakeclock <= ~r_fakeclock;

reg signed [15:0] r_data_word1 = -32768;
reg signed [15:0] r_data_word2 = -32767;
reg signed [15:0] r_data_word3 = -32766;
reg signed [15:0] r_data_word4 = -32765;

reg[13:0] r_address = 0;
reg[7:0] r_byteen = 0;
reg r_wbit = 0;

reg[3:0] clk_ctr = 0;


parameter INIT_STATE = 3'b000;
parameter START_WRITE = 3'b001;
parameter END_WRITE = 3'b010;
parameter NEXT_ADDY_AND_DATA = 3'b011;

reg[3:0] current_state = INIT_STATE;

always @ (posedge r_fakeclock)
begin

  case(current_state)
    
	 INIT_STATE:
	 begin
		if(clk_ctr >= 4)
		begin
		  clk_ctr <= 0;
		  current_state <= START_WRITE;
		end
		else
		  clk_ctr <= clk_ctr + 1;
	 end
	 
	 START_WRITE:
	 begin
	   if(clk_ctr == 0)
		  r_wbit <= 1;

		if(clk_ctr >= 4)
		begin
		  clk_ctr <= 0;
		  current_state <= END_WRITE;
		end
		else
		  clk_ctr <= clk_ctr + 1;
	 end
	 
	 END_WRITE:
	 begin
	   if(clk_ctr == 0)
		  r_wbit <= 0;
		
if(clk_ctr >= 4)
		begin
		  clk_ctr <= 0;
		  current_state <= NEXT_ADDY_AND_DATA;
		end
		else
		  clk_ctr <= clk_ctr + 1;
	 end
	 
	 NEXT_ADDY_AND_DATA:
	 begin
	   r_data_word1 <= r_data_word1 + 4;
	   r_data_word2 <= r_data_word2 + 4;
	   r_data_word3 <= r_data_word3 + 4;
	   r_data_word4 <= r_data_word4 + 4;
		
		current_state <= INIT_STATE;
		
		if (r_address >= 2047)
        r_address <= 0;
      else
        r_address <= r_address + 1; 
	 end
	 
  endcase
end

endmodule
