module ramwriter();

reg r_fakeclock = 0;
always #1 r_fakeclock <= ~r_fakeclock;


parameter INIT_STATE = 3'b000;
parameter START_WRITE = 3'b001;
parameter END_WRITE = 3'b010;
parameter WAIT_STATE = 3'b011;
parameter STOP_ALL = 3'b100;

reg[3:0] current_state = INIT_STATE;

reg  [15:0] r_data_word1 = 0;
reg  [15:0] r_data_word2 = 1;
reg  [15:0] r_data_word3 = 2;
reg  [15:0] r_data_word4 = 3;

reg[13:0] r_address = 0;

reg[7:0] r_byteen = 8'hFF;
reg r_wbit = 0;

reg[3:0] clk_ctr = 0;

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
	   r_wbit <= 1;
      //r_address <= r_address + 1; 
		
	   r_data_word1 <= r_data_word1 + 4;
	   r_data_word2 <= r_data_word2 + 4;
	   r_data_word3 <= r_data_word3 + 4;
	   r_data_word4 <= r_data_word4 + 4;
		
		current_state <= END_WRITE;
		
		if (r_address == 14'h3FFF)
		  r_address <= 1;
		else
		  r_address <= r_address + 1;
		
	 end
	 
	 END_WRITE:
	 begin
	 	r_wbit <= 0;
		//if(r_address[13] == 1)
		//  current_state <= STOP_ALL;
		//else
		current_state <= WAIT_STATE;
		  
		  
	 end
	 
	 WAIT_STATE:
	 begin
	   if(clk_ctr >= 10) //Start with 100samples/sec for testing
           begin
		  current_state <= START_WRITE;
		  clk_ctr <= 0;
	   end
           else
		  clk_ctr <= clk_ctr + 1;
	 end
	 
	 
	 STOP_ALL:
	 begin
	   clk_ctr <= 0;
	 end
	 
  endcase
end

endmodule
