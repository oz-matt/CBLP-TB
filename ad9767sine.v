module ad9767sine
  (input i_clk,
  input[7:0] i_sine_f,
  output o_dac_clk,
  output[13:0] o_dac_data);
  
  reg r_dac_clk = 0;

  reg[7:0] dac_clk_ctr = 0;
  reg[12:0] data_clk_ctr = 0;

  reg[6:0] r_address = 0;

  wire[13:0] q_sig;

  sinerom sinerom_inst(
	.address (r_address),
	.clock (i_clk),
	.q (q_sig)
	);

  always @(posedge i_clk)
  begin
    if (dac_clk_ctr == 48)
      if (data_clk_ctr >= i_sine_f)
      begin    
        data_clk_ctr <= 0;
        if (r_address > 100)
          r_address <= 0;
        else
          r_address <= r_address + 1;
      end  
      else
        data_clk_ctr <= data_clk_ctr + 1;
    else if (dac_clk_ctr == 31)
      r_dac_clk <= 1;
    if (dac_clk_ctr == 63)
    begin
      dac_clk_ctr <= 0;
      r_dac_clk <= 0;
    end
    else
      dac_clk_ctr <= dac_clk_ctr + 1;
  end

  assign o_dac_clk = r_dac_clk;
  assign o_dac_data = q_sig;


endmodule