
`timescale 1 ns / 1 ns
module cinnabontb();

reg r_fakeclock;
//reg areset;
//wire locked;
wire oclk;
//wire oclk2;
reg rst =1;

wire ncodv;
wire[35:0] ncodata;
reg nco_in_valid = 1;
reg[31:0] nco_in_data  = 0;


wire CLK_65, CLK_125;


initial
begin
  r_fakeclock = 0;
  
  rst = 0;
  #300
  
  rst =1;
 nco_in_valid = 1;
end

always #20 r_fakeclock = ~r_fakeclock;


pll  pll_100   (
				 .inclk0(r_fakeclock),
                 .pllena(1),
                 .areset(0),
                 .c0    (CLK_125),
                 .c1	(CLK_65)
			   );


    cinnabon_qsys u0 (
        .clk_clk                                    (r_fakeclock),                                    //                        clk.clk
        .reset_reset_n                              (rst),
.nco_ii_0_in_valid                          (nco_in_valid),                          //                nco_ii_0_in.valid
        .nco_ii_0_in_data                           (nco_in_data),                           //                           .data
        .nco_ii_0_out_data                          (ncodata),                          //               nco_ii_0_out.data
        .nco_ii_0_out_valid                         (ncodv),                         //                           .valid
        .nco_ii_0_clk_clk                           (CLK_125),                           //               nco_ii_0_clk.clk
        .nco_ii_0_rst_reset_n                       (rst)                        //               nco_ii_0_rst.reset_n
    
    );


endmodule