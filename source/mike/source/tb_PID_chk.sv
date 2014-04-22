// $Id: $
// File name:   tb_PID_chk.sv
// Created:     4/10/2013
// Author:      Tyler Leamon
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: CRC checking
//

`timescale 1ns / 10ps

module tb_PID_chk();
  parameter CLK_PERIOD = 3.3; //For 300 ns
  
  reg tb_clk;
  reg tb_rst;
  reg tb_PID_enable;
  reg [7:0] tb_PID_I;
  reg tb_EOP_flag;
  reg [1:0] tb_data_select;
  reg tb_crc16_enable;
  
  
  PID_chk DUT(.clk(tb_clk),.rst(tb_rst),.PID_enable(tb_PID_enable),.PID_I(tb_PID_I)
  ,.EOP_flag(tb_EOP_flag),.data_select(tb_data_select),.crc16_enable(tb_crc16_enable));
  
  always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2.0);
	end
  
  // Main test bench code
  initial begin
    // System Reset
    tb_rst = 0;
    #(CLK_PERIOD);
		tb_rst = 1;
		#(CLK_PERIOD);
    
    
    //Load PID data
    tb_PID_I = 8'b11000011;
    #(CLK_PERIOD);
    
    //PID Data is fully loaded
    tb_PID_enable = 1'b1;
    #(CLK_PERIOD);
    
    //All data from packet is loaded
    tb_EOP_flag = 1'b1;
    #(CLK_PERIOD);
    
    //Deassert signals to stop evaluation of packets
    tb_PID_enable = 1'b0;
    tb_EOP_flag = 1'b0;
    #(CLK_PERIOD);
    
    //Load PID values
    tb_PID_I = 8'b00111100;
    tb_PID_enable = 1'b1;
    tb_EOP_flag = 1'b1;
    #(CLK_PERIOD);
    
    //Deassert signals to stop evaluation of packets
    tb_PID_enable = 1'b0;
    tb_EOP_flag = 1'b0;
    
    // Done
  end
  
  

endmodule

		  

