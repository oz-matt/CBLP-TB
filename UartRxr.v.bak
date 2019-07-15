module UartRxr
  #(parameter CLKS_PER_BAUD_PERIOD = 434)
  (input i_clk,
  input i_rx_data_line,
  output o_data_ready,
  output [7:0] o_data_byte_out
  );

  // Uart receiver state machine nodes
  parameter WAITING_FOR_START_BIT = 3'b000;
  parameter CONFIRMING_START_BIT = 3'b001;
  parameter GETTING_NEXT_DATA_BIT = 3'b010;
  parameter WAITING_FOR_STOP_BIT = 3'b011;

  reg[2:0] current_state = WAITING_FOR_START_BIT;
  reg data_ready = 0;

  reg[9:0] clk_ctr = 0;

  always @(posedge i_clk)
  begin
    case (current_state)
      WAITING_FOR_START_BIT :
      begin
        if (i_rx_data_line == 0)
        begin
          current_state <= CONFIRMING_START_BIT;
        end
      end
      CONFIRMING_START_BIT :
      begin
        if (i_rx_data_line == 1)
        begin
          clk_ctr <= 0;
          current_state <= WAITING_FOR_START_BIT;
        end
        else
        begin
          if (clk_ctr < (CLKS_PER_BAUD_PERIOD/2))
          begin
            clk_ctr <= clk_ctr + 1;
          end
          else
          begin
            data_ready <= 1;
          end
        end
      end
    endcase
  end
endmodule

