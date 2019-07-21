`timescale 10ns / 1ns

module AdcReceiverTB();

  reg r_fakeclock;

  initial
  begin
    r_fakeclock <= 0;
  end

  always #1 r_fakeclock <= ~r_fakeclock;

  AdcReceiver #(50) UUT
  (.i_clk(r_fakeclock));

endmodule
