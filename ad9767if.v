module ad9767if
  (input i_clk,
  output[13:0] o_dac_data);

  reg[13:0] r_dac_data = 0;

  reg[12:0] clk_ctr = 0;

  always @(posedge i_clk)
  begin
    if (clk_ctr > 5000)
    begin
      clk_ctr <= 0;
      r_dac_data[13] = ~r_dac_data[13];
    end
    else
      clk_ctr <= clk_ctr + 1;
  end

  assign o_dac_data = r_dac_data;

endmodule
