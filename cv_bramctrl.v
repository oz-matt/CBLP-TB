`timescale 10ns / 1ns

module CvBramCtrl();

  reg r_fakeclock = 0;
  always #1 r_fakeclock <= ~r_fakeclock;

  reg cs1 = 0;
  reg cs2 = 0;

  reg [31:0] clk_ctr = 0;


  //State machine nodes
  parameter READ_STATE = 3'b000;
  parameter IDLE_STATE_1 = 3'b001;
  parameter WRITE_STATE = 3'b010;
  parameter IDLE_STATE_2 = 3'b011;

  reg[2:0] r_current_state = READ_STATE;



  always @(posedge r_fakeclock)
  begin
    case (r_current_state)
      
      READ_STATE:
      begin
        clk_ctr <= clk_ctr + 1;
        cs1 <= 1;
        if(clk_ctr >= 10)
          r_current_state <= IDLE_STATE_1;
      end
      
      IDLE_STATE_1:
      begin
        clk_ctr <= clk_ctr + 1;
        cs1 <= 0;
        if(clk_ctr >= 20)
          r_current_state <= WRITE_STATE;
      end
      
      WRITE_STATE:
      begin
        clk_ctr <= clk_ctr + 1;
        cs2 <= 1;
        if(clk_ctr >= 30)
          r_current_state <= IDLE_STATE_2;
      end
      
      IDLE_STATE_2:
      begin
        clk_ctr <= clk_ctr + 1;
        cs2 <= 0;
        if(clk_ctr >= 40)
        begin
          r_current_state <= READ_STATE;
          clk_ctr <= 0;
        end
      end
    endcase
  end

endmodule
