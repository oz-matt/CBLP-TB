`timescale 10ns / 10ns

module sineTB();

reg r_fakeclock = 0;
reg[6:0] r_address = 0;

wire[13:0] q_sig;

sinerom	sinerom_inst(
	.address (r_address),
	.clock (r_fakeclock),
	.q (q_sig)
	);

always #1 r_fakeclock = ~r_fakeclock;

initial
begin
  #10
  r_address <= 1;
  #10
  r_address <= 2;
  #10
  r_address <= 3;
  #10
  r_address <= 4;
  #10
  $finish;
end

endmodule
