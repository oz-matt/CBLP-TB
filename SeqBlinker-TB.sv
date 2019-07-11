module SeqBlinker-TB();

reg r_fakeclock = 1'b0;

	always #1 r_fakeclock <= ~r_fakeclock;

	SeqBlinker
		#(50, 25, 17, 10, 5) UUT
		(.i_Clk(r_fakeclock),
		.outreg1(),
		.outreg2(),
		.outreg3(),
		.outreg4(),
		.outreg5()
		);
		
	initial
	begin
		$display("Testbench... GO!");
		#200;
		$finish();
	end
	
	
		
endmodule