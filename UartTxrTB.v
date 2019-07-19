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

wire w_data_ready;
wire[7:0] w_data_byte;

UartRxr #(10) UUT2
  (.i_clk(r_fakeclock),
  .i_rx_data_line(w_dataline),
  .o_data_ready(w_data_ready),
  .o_data_byte_out(w_data_byte));

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
  #270
  r_fakebyte <= w_data_byte;
  r_datavalid <= 1;
  
end


endmodule
