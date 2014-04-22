// $Id: $
// File name:   tb_PID.sv
// Created:     4/20/2013
// Author:      USB Encryption
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: SPI TestBench
// 


`timescale 1ns/100ps

module tb_SPI();
  
  parameter CLK_PER = (10.0/3)*6; 
  
 	reg spi_clk;
	reg n_reset;
	reg spi_data; 
	reg [47:0] spi_out00;
	reg [47:0] spi_out01;
	reg [47:0] spi_out02;
	reg [47:0] spi_out03;
	reg [47:0] spi_out04;
	reg [47:0] spi_out05;
	reg [47:0] spi_out06;
	reg [47:0] spi_out07;
	reg [47:0] spi_out08;
	reg [47:0] spi_out09;
	reg [47:0] spi_out10;
	reg [47:0] spi_out11;
	reg [47:0] spi_out12;
	reg [47:0] spi_out13;
	reg [47:0] spi_out14;
	reg [47:0] spi_out15;
	reg [5:0] ii;

  always begin
    spi_clk = 0'b1;
    #(CLK_PER/2);
    spi_clk = 0'b0;
    #(CLK_PER/2);
  end

  SPI DUT (
  .spi_clk(spi_clk), 
  .n_reset(n_reset), 
  .spi_data(spi_data), 
  .spi_out00(spi_out00),
  .spi_out01(spi_out01),
  .spi_out02(spi_out02),
  .spi_out03(spi_out03),
  .spi_out04(spi_out04),
  .spi_out05(spi_out05),
  .spi_out06(spi_out06),
  .spi_out07(spi_out07),
  .spi_out08(spi_out08),
  .spi_out09(spi_out09),
  .spi_out10(spi_out10),
  .spi_out11(spi_out11),
  .spi_out12(spi_out12),
  .spi_out13(spi_out13),
  .spi_out14(spi_out14),
  .spi_out15(spi_out15));
  
  initial begin
    
    n_reset = 1'b1;
    #(CLK_PER);
    
// Reset is Set for 1 period
    n_reset = 1'b0;
    #(CLK_PER);
// SPI data is starts transmitting serially  #fffffffffffff
   
    n_reset = 1'b1;
    spi_data = 1'b1;
    #(CLK_PER*48);
// #0000000000000
    spi_data = 1'b0;
    #(CLK_PER*48);
// #ffffff000000, #000000ffffff
    spi_data = 1'b1;
    #(CLK_PER*24);
    spi_data = 1'b0;
    #(CLK_PER*48)
    spi_data = 1'b1;
    #(CLK_PER*24) ;
// #aaaaaaaaaaaa
    for (ii = 0; ii<24; ii=ii+1)
    begin
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
    end
// #555555555555
    for (ii = 0; ii<24; ii=ii+1)
    begin
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
    end     
// #cccccccccccc
    for (ii = 0; ii<12; ii=ii+1)
    begin
      spi_data = 1'b1;
      #(CLK_PER*2);
      spi_data = 1'b0;
      #(CLK_PER*2);
    end
// #333333333333
    for (ii = 0; ii<12; ii=ii+1)
    begin
      spi_data = 1'b0;
      #(CLK_PER*2);
      spi_data = 1'b1;
      #(CLK_PER*2);
    end
// #249249249249       
    for (ii = 0; ii<16; ii=ii+1)
    begin
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
    end    
// #492492492492
    for (ii = 0; ii<16; ii=ii+1)
    begin
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
    end   
// #6db6db6db6db
    for (ii = 0; ii<16; ii=ii+1)
    begin
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
    end   
// #924924924924
    for (ii = 0; ii<16; ii=ii+1)
    begin
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
    end    
// #b6db6db6db6d 
    for (ii = 0; ii<16; ii=ii+1)
    begin
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
    end   
// #db6db6db6db6   
    for (ii = 0; ii<16; ii=ii+1)
    begin
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
    end     
// #999999999999        
    for (ii = 0; ii<12; ii=ii+1)
    begin
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
    end
// #666666666666
    for (ii = 0; ii<12; ii=ii+1)
    begin
      spi_data = 1'b0;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b1;
      #(CLK_PER);
      spi_data = 1'b0;
      #(CLK_PER);
    end
      spi_data = 1'b0; // blank
      #(CLK_PER*2)
      
    //error checking from spi_out00 to spi_out15  
    assert (spi_out00 == 48'hffffffffffff)
    else $error("Error in key00 = %x", spi_out00);
      
    assert (spi_out01 == 48'h000000000000)
    else $error("Error in key01 = %x", spi_out01);
    
    assert (spi_out02 == 48'hffffff000000)
    else $error("Error in key02 = %x", spi_out02);
    
    assert (spi_out03 == 48'h000000ffffff)
    else $error("Error in key03 = %x", spi_out03);
    
    assert (spi_out04 == 48'haaaaaaaaaaaa)
    else $error("Error in key04 = %x", spi_out04);
    
    assert (spi_out05 == 48'h555555555555)
    else $error("Error in key05 = %x", spi_out05);
    
    assert (spi_out06 == 48'hcccccccccccc)
    else $error("Error in key06 = %x", spi_out06);
    
    assert (spi_out07 == 48'h333333333333)
    else $error("Error in key07 = %x", spi_out07);
    
    assert (spi_out08 == 48'h249249249249)
    else $error("Error in key08 = %x", spi_out08);
    
    assert (spi_out09 == 48'h492492492492)
    else $error("Error in key09 = %x", spi_out09);
    
    assert (spi_out10 == 48'h6db6db6db6db)
    else $error("Error in key10 = %x", spi_out10);
    
    assert (spi_out11 == 48'h924924924924)
    else $error("Error in key11 = %x", spi_out11);
    
    assert (spi_out12 == 48'hb6db6db6db6d)
    else $error("Error in key12 = %x", spi_out12);
    
    assert (spi_out13 == 48'hdb6db6db6db6)
    else $error("Error in key13 = %x", spi_out13);
    
    assert (spi_out14 == 48'h999999999999)
    else $error("Error in key14 = %x", spi_out14);
    
    assert (spi_out15 == 48'h666666666666)
    else $error("Error in key15 = %x", spi_out15); 
    
     
    
end

endmodule
