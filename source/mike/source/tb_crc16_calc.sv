// $Id: $
// File name:   tb_crc16_calc.sv
// Created:     4/10/2013
// Author:      Tyler Leamon
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: CRC checking
//

`timescale 1ns / 10ps

module tb_crc16_calc();
  parameter CLK_PERIOD = 3.3; //For 300 ns
  
  reg tb_clk;
	reg tb_rst;
	reg tb_initialize;
  reg tb_crc16_enable;
  reg [15:0] tb_crc16_I;
  reg [63:0] tb_crc16_DI;
  reg [15:0] tb_crc16_O;
  reg tb_crc16_err;
  
  
  crc16 DUT(.clk(tb_clk),.rst(tb_rst),.initialize(tb_initialize),.crc16_enable(tb_crc16_enable)
  ,.crc16_I(tb_crc16_I),.crc16_DI(tb_crc16_DI),.crc16_O(tb_crc16_O),.crc16_err(tb_crc16_err));
  
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
    
    //Load data into register
    tb_crc16_DI = 64'hFFFFFFFFFFFFFFFF;
    #(CLK_PERIOD);
    
    //Enable CRC - DATA IS READY
    tb_crc16_enable = 1;
    #(CLK_PERIOD);
    tb_crc16_enable = 0;
    #(CLK_PERIOD);
    
    
		
    // Done
  end
  
  

endmodule

		  

