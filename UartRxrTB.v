module UartRxrTB();

reg r_fakeclock;
reg r_dataline;
reg r_got_7a;

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
  r_got_7a = 0;
end

always #1 r_fakeclock = ~r_fakeclock;

always @(posedge r_fakeclock)
begin
  if (w_data_byte == 8'h7A) 
    r_got_7a <= 1;
end

task write_fake_byte;
input[7:0] byte;
integer i;
  begin

    r_dataline <= 0; //Start bit
    
    for(i=0;i<8;i=i+1)
    begin
      #20
      r_dataline <= byte[7-i];
    end

    #20
    r_dataline <= 1;  //Stop bit
    
  end
endtask

initial
begin
  #40
  
  write_fake_byte(8'h79);

  $display("Q sent");
  $finish;
end

endmodule
