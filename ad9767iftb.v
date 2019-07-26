`timescale 10ns / 10ns

module ad9767iftb();

  reg r_fakeclock = 0;

  reg[7:0] r_sine_f = 0;

  wire[13:0] w_dac_data;
  wire w_dac_clk;

  always #1 r_fakeclock <= ~r_fakeclock;

  ad9767sine UUT 
  (.i_clk(r_fakeclock),
  .i_sine_f(r_sine_f),
  .o_dac_clk(w_dac_clk),
  .o_dac_data(w_dac_data));

  initial
  begin
    forever
    begin
      #1000
      r_sine_f <= r_sine_f + 1;
    end
    $finish;
  end

endmodule
