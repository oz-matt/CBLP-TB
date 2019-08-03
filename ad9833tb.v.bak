`timescale 10ns / 10ns

module ad9833tb();

reg r_fakeclock, go;

reg[15:0] control;
reg[15:0] adreg0;
reg[15:0] adreg1;

wire good_to_reset_go, fsync, sclk, sdata;

initial
begin
  r_fakeclock <= 0;
  go <= 0;
  control <= 16'b1010101010101101;
  adreg0 <= 16'b1110101010101101;
  adreg1 <= 16'b1011101010101101;
end

always #1 r_fakeclock <= ~r_fakeclock;

ad9833 UUT
  (
  .clk(r_fakeclock),
  .go(go),
  .control(control),
  .adreg0(adreg0),
  .adreg1(adreg1),
  .good_to_reset_go(good_to_reset_go),
  .fsync(fsync),
  .sclk(sclk),
  .sdata(sdata)
  );

always @(posedge r_fakeclock)
begin
  if(good_to_reset_go == 1) go <= 0;
end

initial
begin
  #10
  go <= 1;
  #1000
  $finish;
end

endmodule
