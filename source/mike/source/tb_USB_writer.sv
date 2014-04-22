// $Id: $
// File name:   tb_USB_writter
// Created:     4/20/2013
// Author:      USB Encryption
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: SPI TestBench
// 


`timescale 1ns/100ps

module tb_USB_writer();
  
  parameter CLK_PER = 10; 
  reg [87:0] data_in;
  reg ready;
  reg shift;
  reg [2:0] data_select;
  reg clk;
  reg n_rst;
  reg [1:0] data_out; 

 
  always begin
    clk = 1'b1;
    #(CLK_PER/2);
    clk = 1'b0;
    #(CLK_PER/2);
  end

    always begin
    shift = 1'b1;
    #(CLK_PER);
    shift = 1'b0;
    #(CLK_PER*9);
  end

  USB_writer DUT (
 	 .data_in(data_in),
 	 .ready(ready),
 	 .shift(shift),
	 .data_select(data_select),
 	 .clk(clk),
 	 .n_rst(n_rst),
 	 .data_out(data_out)
  );
  
  initial begin
    ready = 1'b0;
    n_rst = 1'b0;
    #(CLK_PER);
    
// Reset is Set for 1 period
    n_rst = 1'b1;
    #(CLK_PER);
// SPI data is starts transmitting serially  #fffffffffffff
   
    data_in = 88'b1110001000110111000000001111111101110111101110110011001111011101010101011001100111000011;
    #(CLK_PER);
    ready = 1'b1;
    data_select = 3'b001;
    
    #(CLK_PER*100);
    ready = 1'b0; 
    
end

endmodule
