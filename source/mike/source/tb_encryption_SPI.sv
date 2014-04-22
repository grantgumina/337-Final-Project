// $Id: $
// File name:   tb_encryption_SPI.sv
// Created:     4/10/2013
// Author:      Kyle Brockhoff
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Encryption test with SPI interface test bench
`timescale 1ns/1ps

module tb_encryption_SPI();

parameter CLK_PER = (10.0/3)*6; 

reg clk;
reg is_data;
reg spi_clk;
reg n_reset;
reg spi_data;
integer ii;
reg [63:0] in;
wire [63:0] encrypted;
wire [63:0] plain;
reg [47:0] key00;
reg [47:0] key01;
reg [47:0] key02;
reg [47:0] key03;
reg [47:0] key04;
reg [47:0] key05;
reg [47:0] key06;
reg [47:0] key07;
reg [47:0] key08;
reg [47:0] key09;
reg [47:0] key10;
reg [47:0] key11;
reg [47:0] key12;
reg [47:0] key13;
reg [47:0] key14;
reg [47:0] key15;
reg [63:0] tb_expected;

reg [47:0] key_tran00;
reg [47:0] key_tran01;
reg [47:0] key_tran02;
reg [47:0] key_tran03;
reg [47:0] key_tran04;
reg [47:0] key_tran05;
reg [47:0] key_tran06;
reg [47:0] key_tran07;
reg [47:0] key_tran08;
reg [47:0] key_tran09;
reg [47:0] key_tran10;
reg [47:0] key_tran11;
reg [47:0] key_tran12;
reg [47:0] key_tran13;
reg [47:0] key_tran14;
reg [47:0] key_tran15;

always begin
	clk = 1'b1;
	#1667ps;
	clk = 1'b0;
	#1667ps;
end

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
  .spi_out00(key00),
  .spi_out01(key01),
  .spi_out02(key02),
  .spi_out03(key03),
  .spi_out04(key04),
  .spi_out05(key05),
  .spi_out06(key06),
  .spi_out07(key07),
  .spi_out08(key08),
  .spi_out09(key09),
  .spi_out10(key10),
  .spi_out11(key11),
  .spi_out12(key12),
  .spi_out13(key13),
  .spi_out14(key14),
  .spi_out15(key15));

encryption E1(.in(in),.out(encrypted),.is_data(is_data),.key00(key00),
  .key01(key01),.key02(key02),.key03(key03),.key04(key04),
  .key05(key05),.key06(key06),.key07(key07),.key08(key08),
  .key09(key09),.key10(key10),.key11(key11),.key12(key12),
  .key13(key13),.key14(key14),.key15(key15));
  
encryption E2(.in(encrypted),.out(plain),.is_data(is_data),.key00(key15),
  .key01(key14),.key02(key13),.key03(key12),.key04(key11),
  .key05(key10),.key06(key09),.key07(key08),.key08(key07),
  .key09(key06),.key10(key05),.key11(key04),.key12(key03),
  .key13(key02),.key14(key01),.key15(key00));

initial begin
  
      
    n_reset = 1'b1;
    #(CLK_PER);
    
// Reset is Set for 1 period
    n_reset = 1'b0;
    #(CLK_PER);
// SPI data is starts transmitting serially  #fffffffffffff
    n_reset = 1'b1;
    
    key_tran00 = 48'h38acef46564a;
    key_tran01 = 48'h89bed4489d12;
    key_tran02 = 48'h547eee4d443c;
    key_tran03 = 48'hf2f5604958c8;
    key_tran04 = 48'hc8cf6780d03d;
    key_tran05 = 48'he1f31f831ea4;
    key_tran06 = 48'h2597e3980bb1;
    key_tran07 = 48'hf358f3134a15;
    key_tran08 = 48'h0cda7ba00ac6;
    key_tran09 = 48'ha7795e94a297;
    key_tran10 = 48'h2e6fc13706c1;
    key_tran11 = 48'h5b7d391aa143;
    key_tran12 = 48'hcda5d926e504;
    key_tran13 = 48'h57ce8f6825c2;
    key_tran14 = 48'h7bb982ecc00b;
    key_tran15 = 48'hd33a2d238d68;
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran00[ii];
      #(CLK_PER);
    end
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran01[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran02[ii];
      #(CLK_PER);
    end
  
        for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran03[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran04[ii];
      #(CLK_PER);
    end
    
    key_tran05 = 48'he1f31f831ea4;
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran05[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran06[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran07[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran08[ii];
      #(CLK_PER);
    end
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran09[ii];
      #(CLK_PER);
    end
    
  
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran10[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran11[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran12[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran13[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran14[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran15[ii];
      #(CLK_PER);
    end
    
    is_data = 1'b1;
    
    
    in = 64'h1122334455667788;
    tb_expected = 64'hb5219ee81aa7499d;
    
    #100ns
    
    in = 64'h99aabbccddeeff00;
    tb_expected = 64'h2196687e13973856;
  
end

endmodule