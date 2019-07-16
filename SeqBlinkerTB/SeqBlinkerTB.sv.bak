module SeqBlinkerTB();

wire w1,w2,w3,w4,w5;

reg r_fakeclock;

	
	SeqBlinker
		#(50, 25, 17, 10, 5) UUT
		(.i_clk(r_fakeclock),
		.outreg1(w1),
		.outreg2(w2),
		.outreg3(w3),
		.outreg4(w4),
		.outreg5(w5)
		);

initial
begin

r_fakeclock = 0;
end

always #1 r_fakeclock = !r_fakeclock;

		
/*	initial
	begin
		$display("Testbench... GO!");
		$monitor("%d,\t%b,\t%b,\t%b,\t%d",$time, r_fakeclock,w1,w2,w3);
		#200;
		$finish;
	end
	
	*/
		
endmodule