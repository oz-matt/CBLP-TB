`timescale 10ns / 1ns

module AdcReceiverTB();

  reg r_fakeclock;
  reg[5:0] r_bits_to_send_to_adc = 6'b100000;
  reg r_request_conversion;

  wire w_adc_dv;
  wire[11:0] w_adc_data;
  wire w_conv_in_process;

  reg r_serial_rx;
  wire w_convst;
  wire w_sck;
  wire w_serial_tx;

  initial
  begin
    r_fakeclock <= 0;
    r_request_conversion <= 0;
    r_adc_dv <= 0;
    r_serial_rx <= 0;
  end

  always #1 r_fakeclock <= ~r_fakeclock;

  AdcReceiver #(50) UUT
  (.i_clk(r_fakeclock),
  .i_tx_bits(r_bits_to_send_to_adc),
  .i_request_conversion(r_request_conversion),
  .o_rx_dv(w_adc_dv),
  .o_rx_data(w_adc_data),
  .o_conv_in_process(w_conv_in_process),
  .i_serial_rx(r_serial_rx),
  .o_convst(w_convst),
  .o_sck(w_sck),
  .o_serial_tx(w_serial_tx)
  );
  

endmodule
