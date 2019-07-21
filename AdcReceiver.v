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

  reg [$clog2(SPI_CLK_DIVISOR*2)-1:0]   reg r_SPI_Clk_Ctr;
  reg r_SPI_Clk;
  reg[7:0] r_tx_bits;
  reg r_tx_dv;

  reg[2:0] r_RX_Bit_Count;
  reg[2:0] r_TX_Bit_Count;

