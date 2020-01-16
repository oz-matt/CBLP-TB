`timescale 10ns / 1ns

module CvBramCtrl();

  reg r_fakeclock = 0;
  always #1 r_fakeclock <= ~r_fakeclock;

  reg wbit = 0;

  reg[7:0] addy = 0;
  reg[7:0] addybuff = 0;

  reg [31:0] clk_ctr = 0;


  always @(posedge r_fakeclock)
  begin
    
    if (clk_ctr >= 12)
    begin
      addy <= 0;
      wbit <= 0;
    end
    else
    if (clk_ctr == 10)
    begin
      addybuff <= addybuff + 1;
      addy <= addybuff + 1;
      wbit <= 1;
    end
    
    if (clk_ctr >= 14)
    begin
      clk_ctr <= 0;
    end
    else
      clk_ctr <= clk_ctr + 1;
  end

endmodule
