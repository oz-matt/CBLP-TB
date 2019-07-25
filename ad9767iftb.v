`timescale 10ns / 10ns

module ad9767iftb();

  reg r_fakeclock = 0;

  wire[13:0] w_dac_data;

  always #1 r_fakeclock <= ~r_fakeclock;

  ad9767if UUT 
  (.i_clk(r_fakeclock),
  .o_dac_data(w_dac_data));

  initial
  begin
    #10000
    $finish;
  end

endmodule
