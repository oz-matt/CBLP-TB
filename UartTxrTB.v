module UartTxrTB();

reg r_fakeclock;
reg[7:0] r_fakebyte;
reg r_datavalid;

wire w_dataline;
wire w_good_to_reset_dv;
wire w_send_complete;

UartTxr #(10) UUT
  (.i_clk(r_fakeclock),
  .i_byte_to_send(r_fakebyte),
  .i_data_valid(r_datavalid),
  .o_dataline(w_dataline),
  .o_good_to_reset_dv(w_good_to_reset_dv),
  .o_send_complete(w_send_complete)
  );

initial
begin
  r_fakeclock <= 0;
  r_fakebyte <= 8'h55;
  r_datavalid <= 0;
end

always #1 r_fakeclock <= ~r_fakeclock;

always @(posedge r_fakeclock)
begin
  if(w_good_to_reset_dv == 1) r_datavalid <= 0;
end

initial
begin
  #30
  r_datavalid <= 1;
  /*#30
  forever
  begin
    #1
    if(w_send_complete == 1)
      r_datavalid <= 0;
  end*/
end

endmodule
