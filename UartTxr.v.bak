module UartTxr #(
  parameter CLKS_PER_BIT = 434)
  (input i_clk,
  input[7:0] i_byte_to_send,
  input i_data_valid,
  output o_dataline,
  output o_good_to_reset_dv,
  output o_send_complete
  );

parameter WAIT_FOR_DATA_VALID = 3'b000;
parameter SEND_START_BIT = 3'b001;
parameter SEND_DATA_BITS = 3'b010;
parameter SEND_STOP_BIT = 3'b011;
parameter CLEANUP = 3'b100;

reg r_dataline = 1;
reg r_good_to_reset_dv = 0;
reg r_send_complete = 1;

reg[9:0] clk_ctr = 0;
reg[3:0] bit_ctr = 0;

reg[2:0] r_current_state = WAIT_FOR_DATA_VALID;

always @(posedge i_clk)
begin
  case (r_current_state)
  WAIT_FOR_DATA_VALID:
    begin
      if(i_data_valid == 1)
      begin
        r_current_state <= SEND_START_BIT;
        r_send_complete <= 0;
      end
    end

  SEND_START_BIT:
    begin
      r_dataline <= 0;
      clk_ctr <= clk_ctr + 1;
      if (clk_ctr > CLKS_PER_BIT - 1)
      begin
        clk_ctr <= 0;
        r_good_to_reset_dv <= 1;
        r_current_state <= SEND_DATA_BITS;
      end
    end

  SEND_DATA_BITS:
    begin
      r_dataline <= i_byte_to_send[bit_ctr];
      clk_ctr <= clk_ctr + 1;
      if (clk_ctr > CLKS_PER_BIT - 1)
      begin
        clk_ctr <= 0;
        bit_ctr <= bit_ctr + 1;
        if (bit_ctr >= 7)
        begin
          bit_ctr <= 0;
          r_current_state <= SEND_STOP_BIT;
        end
      end
    end

  SEND_STOP_BIT:
    begin
      r_dataline <= 1;
      clk_ctr <= clk_ctr + 1;
      if (clk_ctr > CLKS_PER_BIT - 1)
      begin
        clk_ctr <= 0;
        r_send_complete <= 1;
        r_current_state <= CLEANUP;
      end
    end

  CLEANUP:
    begin
      r_send_complete <= 0;
      r_current_state <= WAIT_FOR_DATA_VALID;
      r_good_to_reset_dv <= 0;
    end

  endcase
end

assign o_dataline = r_dataline;
assign o_good_to_reset_dv = r_good_to_reset_dv;
assign o_send_complete = r_send_complete;

endmodule
