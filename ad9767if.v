module ad9767if
  (input i_clk,
  output o_dac_clk,
  output[13:0] o_dac_data);
  
  reg r_dac_clk = 0;
  reg[13:0] r_dac_data = 0;

  reg[3:0] dac_clk_ctr = 0;
  reg[12:0] data_clk_ctr = 0;

  always @(posedge i_clk)
  begin
    if (dac_clk_ctr >= 3)
    begin
      r_dac_clk <= ~r_dac_clk;
      dac_clk_ctr <= 0;
    end
    else
      dac_clk_ctr <= dac_clk_ctr + 1;
  end

  always @(posedge i_clk)
  begin
    if (data_clk_ctr == 5)
      r_dac_data[13] = ~r_dac_data[13];
    if (data_clk_ctr > 6 + (8*2))
      data_clk_ctr <= 0;
    else
      data_clk_ctr <= data_clk_ctr + 1;
  end

  assign o_dac_clk = r_dac_clk;
  assign o_dac_data = r_dac_data;

endmodule
