module AdcReceiver
  #(parameter SPI_CLK_DIVISOR=50)
  (input i_clk,
  input[7:0] i_tx_bits,
  input i_tx_dv,

  output reg o_rx_dv,
  output reg[11:0] o_rx_data,

  // Chip IO
  input i_serial_rx,
  output reg o_convst,
  output reg o_sck,
  output reg o_serial_tx
  );

  reg [$clog2(SPI_CLK_DIVISOR*2):0] r_SPI_Clk_Ctr = 0;
  reg r_SPI_Clk = 0;
  reg[7:0] r_tx_bits;
  reg r_tx_dv;

  reg[2:0] r_RX_Bit_Count;
  reg[2:0] r_TX_Bit_Count;

  //State machine nodes
  parameter READY_FOR_NEXT_CONVERSION = 3'b000;
  parameter SENDING_CONVST_HIG = 3'b001;
  parameter WAITING_TCONV_PLUS_NAP_DELA = 3'b010;
  parameter SENDING_CONVST_LOW = 3'b011;
  parameter TRANSFERING_DATA = 3'b100;
  parameter WAITING_TACQ_DELAY = 3'b101;
  parameter CLEANUP = 3'b110;

  reg[2:0] r_current_state;

  always @(posedge i_clk)
  begin
    r_SPI_Clk_Ctr <=  r_SPI_Clk_Ctr + 1;
    if(r_SPI_Clk_Ctr >= SPI_CLK_DIVISOR - 1)
    begin
      r_SPI_Clk <= ~r_SPI_Clk;
      r_SPI_Clk_Ctr <= 0;
    end
  end

endmodule
