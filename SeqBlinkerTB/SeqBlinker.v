module SeqBlinker
  #(parameter n_clks_1hz = 25000000,
  parameter n_clks_2hz = 12500000,
  parameter n_clks_3hz = 8333333,
  parameter n_clks_5hz = 5000000,
  parameter n_clks_10hz = 2500000
  )
  (input i_clk,
  output reg outreg1,
  output reg outreg2,
  output reg outreg3,
  output reg outreg4,
  output reg outreg5
  );
  
  
  
  reg[25:0] ctr_1hz;
  reg[25:0] ctr_2hz;
  reg[25:0] ctr_3hz;
  reg[25:0] ctr_5hz;
  reg[25:0] ctr_10hz;
  
  always @(posedge i_clk)
  begin
    ctr_1hz <= ctr_1hz + 1;
    if (ctr_1hz >= n_clks_1hz)
	 begin
	   outreg1 <= ~outreg1;
		ctr_1hz <= 0;
    end
  end
  
  always @(posedge i_clk)
  begin
    ctr_2hz <= ctr_2hz + 1;
    if (ctr_2hz >= n_clks_2hz)
	 begin
	   outreg2 <= ~outreg2;
		ctr_2hz <= 0;
    end
  end
  
  always @(posedge i_clk)
  begin
    ctr_3hz <= ctr_3hz + 1;
    if (ctr_3hz >= n_clks_3hz)
	 begin
	   outreg3 <= ~outreg3;
		ctr_3hz <= 0;
    end
  end
  
  always @(posedge i_clk)
  begin
    ctr_5hz <= ctr_5hz + 1;
    if (ctr_5hz >= n_clks_5hz)
	 begin
	   outreg4 <= ~outreg4;
		ctr_5hz <= 0;
    end
  end
  
  always @(posedge i_clk)
  begin
    ctr_10hz <= ctr_10hz + 1;
    if (ctr_10hz >= n_clks_10hz)
	 begin
	   outreg5 <= ~outreg5;
		ctr_10hz <= 0;
    end
  end
  
endmodule