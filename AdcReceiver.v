module AdcReceiver
  #(parameter SPI_CLK_DIVISOR = 50)
  (input i_clk,
  input[5:0] i_tx_bits,
  input i_request_conversion,

  output o_rx_dv,
  output[11:0] o_rx_data,
  output o_conv_in_process,

  // Chip IO
  input i_serial_rx,
  output o_convst,
  output o_sck,
  output o_serial_tx
  );

  reg r_rx_dv = 0;
  reg[11:0] r_rx_data = 0;

  reg r_convst = 0;
  reg r_sck = 0;
  reg r_serial_tx = 0;

  reg [$clog2(SPI_CLK_DIVISOR*2):0] r_SPI_Clk_Ctr = 0;
  reg r_SPI_Clk = 0;
  reg[5:0] r_tx_bits;

  reg[6:0] r_clk_ctr = 0;

  reg[3:0] r_RX_Bit_Counter = 0;
  reg[2:0] r_TX_Bit_Counter = 0;

  reg r_conv_in_process = 0;

  //State machine nodes
  parameter READY_FOR_NEXT_CONVERSION = 3'b000;
  parameter SENDING_CONVST_HIGH = 3'b001;
  parameter WAITING_TCONV_PLUS_NAP_DELAY = 3'b010;
  parameter SENDING_CONVST_LOW = 3'b011;
  parameter TRANSFERING_DATA = 3'b100;
  parameter WAITING_TACQ_DELAY = 3'b101;
  parameter CLEANUP = 3'b110;

  reg[2:0] r_current_state = READY_FOR_NEXT_CONVERSION;

  always @(posedge i_clk)
  begin
    case(r_current_state)
      
      READY_FOR_NEXT_CONVERSION:
      begin
        if(i_request_conversion == 1)
        begin
          r_current_state <= SENDING_CONVST_HIGH;
          r_rx_dv <= 0;
        end
      end

      SENDING_CONVST_HIGH:
      begin
        r_convst <= 1;
        r_current_state <= WAITING_TCONV_PLUS_NAP_DELAY;
        r_conv_in_process <= 1;
      end

      WAITING_TCONV_PLUS_NAP_DELAY:
      begin
         if(r_clk_ctr >= 100) //Wait the minimum 1.6us for a conversion plus .4us 'nap' time
         begin
           r_clk_ctr <= 0;
           r_current_state <= SENDING_CONVST_LOW;
         end
         else
           r_clk_ctr <= r_clk_ctr + 1;
      end

      SENDING_CONVST_LOW:
      begin
        r_convst <= 0;
        r_current_state <= TRANSFERING_DATA;
      end

      TRANSFERING_DATA:
      begin
        if (r_clk_ctr == 0)
        begin
          r_sck <= 0;
          if (r_TX_Bit_Counter <= 5)
          begin
            r_serial_tx <= i_tx_bits[5 - r_TX_Bit_Counter];
            r_TX_Bit_Counter <= r_TX_Bit_Counter + 1;
          end
          if (r_RX_Bit_Counter > 11)
          begin
            r_current_state <= WAITING_TACQ_DELAY;
            r_RX_Bit_Counter <= 0;
            r_TX_Bit_Counter <= 0;
          end
          else
            r_RX_Bit_Counter <= r_RX_Bit_Counter + 1;
        end
        if (r_RX_Bit_Counter <= 12)
        begin
          if (r_clk_ctr == 25 && r_RX_Bit_Counter <= 11)
            r_sck <= 1;
          if (r_clk_ctr == 27)
            r_rx_data[11 - (r_RX_Bit_Counter - 1)] <= i_serial_rx;
        end
        r_clk_ctr <= r_clk_ctr + 1;
        if (r_clk_ctr >= 50)
          r_clk_ctr <= 0;
      end

      WAITING_TACQ_DELAY:
      begin
        r_current_state <= CLEANUP;
      end
 
      CLEANUP:
      begin
        r_rx_dv <= 1;
        r_conv_in_process <= 0;
        r_current_state <= READY_FOR_NEXT_CONVERSION;
      end
    endcase
  end

  assign o_rx_dv = r_rx_dv;
  assign o_rx_data = r_rx_data;
  assign o_conv_in_process = r_conv_in_process;

  assign o_convst = r_convst;
  assign o_sck = r_sck;
  assign o_serial_tx = r_serial_tx;


endmodule
