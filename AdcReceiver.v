module AdcReceiver
  #(parameter SPI_CLK_DIVISOR = 50)
  (input i_clk,
  input[5:0] i_tx_bits,
  input i_convert_en,

  output o_rx_dv,
  output[11:0] o_rx_data,

  // Chip IO
  input i_serial_rx,
  output o_convst,
  output o_sck,
  output o_serial_tx
  );

  reg r_rx_dv = 0;
  reg[11:0] r_rx_data;

  reg r_convst = 0;
  reg r_sck = 0;
  reg r_serial_tx = 0;

  reg [$clog2(SPI_CLK_DIVISOR*2):0] r_SPI_Clk_Ctr = 0;
  reg r_SPI_Clk = 0;
  reg[5:0] r_tx_bits;
  reg r_tx_dv;

  reg[6:0] r_clk_ctr = 0;

  reg[3:0] r_RX_Bit_Count;
  reg[2:0] r_TX_Bit_Count;

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
    r_SPI_Clk_Ctr <=  r_SPI_Clk_Ctr + 1;
    if(r_SPI_Clk_Ctr >= SPI_CLK_DIVISOR - 1)
    begin
      r_SPI_Clk <= ~r_SPI_Clk;
      r_SPI_Clk_Ctr <= 0;
    end
  end

  always @(posedge i_clk)
  begin
    case(r_current_state)
      
      READY_FOR_NEXT_CONVERSION:
      begin
        if(i_convert_en == 1)
          r_current_state <= SENDING_CONVST_HIGH;
      end

      SENDING_CONVST_HIGH:
      begin
        r_convst <= 1;
        r_current_state <= WAITING_TCONV_PLUS_NAP_DELAY;
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
        if (r_bit_ctr == 0)
        begin
          r_sck <= 0;
          if (r_TX_Bit_Counter <= 5)
          begin
            r_serial_tx <= i_tx_bits[r_TX_Bit_Counter];
            r_TX_Bit_Counter <= r_TX_Bit_Counter + 1;
          end
          if (r_RX_Bit_Counter > 11)
            r_current_state <= WAITING_TACQ_DELAY;
        end
        if (r_RX_Bit_Counter <= 11)
        begin
          if (r_bit_ctr == 25)
            r_sck <= 1;
          if (r_bit_ctr == 27)
            r_rx_data[r_RX_Bit_Counter] <= i_serial_rx;
          r_RX_Bit_Counter <= r_RX_Bit_Counter + 1;
        end
        r_bit_ctr <= r_bit_ctr + 1;
        if (r_bit_ctr >= 50)
        begin
          if (r_RX_Bit_Counter > 11)
            r_current_state <= WAITING_TACQ_DELAY;
          r_bit_ctr <= 0;
        end
      end

    WAITING_TACQ_DELAY:
    begin
      r_current_state <= CLEANUP;
    end

    CLEANUP:
    begin
      r_current_state <= READY_FOR_NEXT_CONVERSION;
    end
      
  end

  assign o_rx_dv = r_rx_dv;
  assign o_rx_data = r_rx_data;

  assign o_convst = r_convst;
  assign o_sck = r_sck;
  assign o_serial_tx = r_serial_tx;


endmodule
