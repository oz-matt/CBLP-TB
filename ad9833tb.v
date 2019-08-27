`timescale 10ns / 10ns

module ad9833tb();

reg r_fakeclock, go;

reg[15:0] control;

reg[27:0] freq = 28'h0f00000;

wire good_to_reset_go, send_complete, fsync, sclk, sdata;

initial
begin
  r_fakeclock <= 0;
  go <= 0;
  control <= 16'b1010101010101101;
end

always #1 r_fakeclock <= ~r_fakeclock;

ad9833 UUT
  (
  .clk(r_fakeclock),
  .go(go),
  .control(control),
  .freq(freq),
  .good_to_reset_go(good_to_reset_go),
  .send_complete(send_complete),
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
  #1500
  go <= 1;
  #10000
  $finish;
end

endmodule
