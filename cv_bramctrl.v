`timescale 10ns / 1ns

module CvBramCtrl();

  reg[63:0] wdata = 64'hAABBCCDDEEFF9988;
  reg[13:0] waddress = 14'b00000000000000;
	
  reg wbit = 0;
  reg cs = 0;

  reg [31:0] clk_ctr = 0;

  reg r_fakeclock = 0;

  always #1 r_fakeclock <= ~r_fakeclock;

  always @(posedge r_fakeclock)
  begin
    if (clk_ctr >= 5)
    begin
      wbit <= 1;
      cs <= 1;
      clk_ctr <= clk_ctr + 1;
      if (clk_ctr >= 8)
      begin
        clk_ctr <= 0;
        wbit <= 0;
        cs <= 0;
        if (waddress >= 14'b11111111111110)
        begin
          waddress <= 0;
        end
        else
          waddress <= waddress + 1;
      end
    end
    else
      clk_ctr <= clk_ctr + 1;
  end

endmodule
