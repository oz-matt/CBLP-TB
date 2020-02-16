
`timescale 1 ns / 1 ns
module cinnabontb();

reg r_fakeclock;
wire locked;
wire oclk;

initial
begin
  r_fakeclock = 0;
end

always #20 r_fakeclock = ~r_fakeclock;

cinnabon_qsys u0 (
        .clk_clk(r_fakeclock),
		.altpll_0_c1_clk(oclk),
		.altpll_0_locked_conduit_export(locked)
    );

endmodule