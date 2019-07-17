module UartRxrTB();

reg r_fakeclock;
reg r_dataline;

wire w_data_ready;
wire[7:0] w_data_byte;

UartRxr #(10) UUT
  (.i_clk(r_fakeclock),
  .i_rx_data_line(r_dataline),
  .o_data_ready(w_data_ready),
  .o_data_byte_out(w_data_byte));

initial
begin
  r_fakeclock = 0;
  r_dataline = 1;
end

always #1 r_fakeclock = ~r_fakeclock;

initial
begin
  #40
  r_dataline <= 0; //Start bit

  #20
  r_dataline <= 0;
  #20
  r_dataline <= 1;
  #20
  r_dataline <= 0;
  #20
  r_dataline <= 1;
  #20
  r_dataline <= 0;
  #20
  r_dataline <= 0;
  #20
  r_dataline <= 0;
  #20
  r_dataline <= 1;

  #20
  r_dataline <= 1;  //Stop bit


  $display("Q sent");
  $finish;
end

endmodule
