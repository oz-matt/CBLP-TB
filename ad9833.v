module ad9833
  #(parameter CLKS_PER_BIT = 10)
  (
  input clk,
  input go,
  input[15:0] control,
  input[15:0] adreg0,
  input[15:0] adreg1,
  output reg good_to_reset_go = 0,
  output reg send_complete = 0,
  output reg fsync = 1,
  output reg sclk = 0,
  output reg sdata = 0
  );

  //State machine nodes
  parameter IDLE 			= 4'b0000;
  parameter START_SCLK 			= 4'b0001;
  parameter START_FSYNC			= 4'b0010;
  parameter WORD_TRANSFER_1	 	= 4'b0011;
  parameter FSYNC_WAIT_HIGH_1		= 4'b0100;
  parameter FSYNC_WAIT_LOW_1		= 4'b0101;
  parameter SEND_COMPLETE		= 4'b0110;
  parameter CLEANUP	                = 4'b0111;

  reg[3:0] current_node = 0;

  reg[15:0] clk_ctr = 0;
  reg[5:0] bit_ctr = 0;
  reg[2:0] word_ctr = 0;
  
  always @(posedge clk)
  begin
    case(current_node)
  
    IDLE:
      begin  
        if (go)
          current_node <= START_SCLK;
      end

    START_SCLK:
      begin
        if (clk_ctr == 0)
        begin
          sclk <= 1;
          good_to_reset_go <= 1;
        end
        if (clk_ctr >= CLKS_PER_BIT * 2)
        begin
          clk_ctr <= 0;
          current_node <= START_FSYNC;
        end
        else
          clk_ctr <= clk_ctr + 1;
      end

    START_FSYNC:
      begin
        if (clk_ctr == 0)
          fsync <= 0;
        if (clk_ctr >= CLKS_PER_BIT)
        begin
          clk_ctr <= 0;
          current_node <= WORD_TRANSFER_1;
        end
        else
          clk_ctr <= clk_ctr + 1;
      end

    WORD_TRANSFER_1:
      begin
        if (clk_ctr == 0)
        begin
          sclk <= 0;
          if (word_ctr == 0)
            sdata <= control[15-bit_ctr];
          else if (word_ctr == 1)
            sdata <= adreg0[15-bit_ctr];
          else
            sdata <= adreg1[15-bit_ctr];
        end
        if (clk_ctr == CLKS_PER_BIT / 2)
          sclk <= 1;
        if (bit_ctr >= 15 && clk_ctr >= ((CLKS_PER_BIT * 3) / 4))
        begin
          bit_ctr <= 0;
          clk_ctr <= 0;
          current_node <= FSYNC_WAIT_HIGH_1;
        end
        else if (clk_ctr >= CLKS_PER_BIT)
        begin
          clk_ctr <= 0;
          bit_ctr <= bit_ctr + 1;   
        end
        else
          clk_ctr <= clk_ctr + 1;     
      end

    FSYNC_WAIT_HIGH_1:
      begin
        if (clk_ctr == 0)
          fsync <= 1;
        if (clk_ctr >= CLKS_PER_BIT * 2)
        begin
          clk_ctr <= 0;
          current_node <= FSYNC_WAIT_LOW_1;
        end
        else
          clk_ctr <= clk_ctr + 1;
      end

    FSYNC_WAIT_LOW_1:
      begin
        if (clk_ctr == 0)
          fsync <= 0;
        if (clk_ctr >= CLKS_PER_BIT)
        begin
          clk_ctr <= 0;
          if (word_ctr >= 2)
            current_node <= SEND_COMPLETE;
          else
          begin
            word_ctr <= word_ctr + 1;
            current_node <= WORD_TRANSFER_1;
          end
        end
        else
          clk_ctr <= clk_ctr + 1;
      end



    SEND_COMPLETE:
      begin
        send_complete <= 1;
        current_node <= CLEANUP;
      end

    CLEANUP:
      begin
        send_complete <= 0;
        good_to_reset_go <= 0;
        clk_ctr <= 0;
        bit_ctr <= 0;
        word_ctr <= 0;
        current_node <= IDLE;
      end

    endcase
  end

endmodule
