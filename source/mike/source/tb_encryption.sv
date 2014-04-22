// $Id: $
// File name:   tb_encryption.sv
// Created:     4/10/2013
// Author:      Kyle Brockhoff
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Encryption test bench
`timescale 1ns/1ps

module tb_encryption();

reg clk;
reg mode;
reg EOP_flag;
reg encrypt_done;
reg [63:0] in;
wire [63:0] out;
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

always begin
	clk = 1'b1;
	#1667ps;
	clk = 1'b0;
	#1667ps;
end

encryption E1(.clk(clk),.EOP_flag(EOP_flag),.mode(mode),.in(in),.out(out),.in_key00(key00),
  .in_key01(key01),.in_key02(key02),.in_key03(key03),.in_key04(key04),
  .in_key05(key05),.in_key06(key06),.in_key07(key07),.in_key08(key08),
  .in_key09(key09),.in_key10(key10),.in_key11(key11),.in_key12(key12),
  .in_key13(key13),.in_key14(key14),.in_key15(key15),.encrypt_done(encrypt_done));

initial begin
    EOP_flag = 1'b0;
    encrypt_done = 1'b0;
    mode = 1'b1;
    
    key00 = 48'h38acef46564a;
    key01 = 48'h89bed4489d12;
    key02 = 48'h547eee4d443c;
    key03 = 48'hf2f5604958c8;
    key04 = 48'hc8cf6780d03d;
    key05 = 48'he1f31f831ea4;
    key06 = 48'h2597e3980bb1;
    key07 = 48'hf358f3134a15;
    key08 = 48'h0cda7ba00ac6;
    key09 = 48'ha7795e94a297;
    key10 = 48'h2e6fc13706c1;
    key11 = 48'h5b7d391aa143;
    key12 = 48'hcda5d926e504;
    key13 = 48'h57ce8f6825c2;
    key14 = 48'h7bb982ecc00b;
    key15 = 48'hd33a2d238d68;
    
    in = 64'h1122334455667788;
    tb_expected = 64'hb5219ee81aa7499d;
    #6667ps;
    
    EOP_flag = 1'b1;
    #3333ps;
    EOP_flag = 1'b0;
    #33330ps;
    encrypt_done = 1'b1;
    #3333ps;
    encrypt_done = 1'b0;
    #10000ps;

    tb_expected = in;
    in = out;
    #3333ps;
    mode = 1'b0;
    EOP_flag = 1'b1;
    #3333ps;
    EOP_flag = 1'b0;
    #33330ps;
    encrypt_done = 1'b1;
    #3333ps;
    encrypt_done = 1'b0;
    #10000ps;
    
    in = 64'h99aabbccddeeff00;
    tb_expected = 64'h2196687e13973856;
    mode = 1'b1;
    #3333ps
    EOP_flag = 1'b1;
    #3333ps;
    EOP_flag = 1'b0;
    #33330ps;
    encrypt_done = 1'b1;
    #3333ps;
    encrypt_done = 1'b0;
    #10000ps;

    tb_expected = in;
    in = out;
    #3333ps;
    mode = 1'b0;
    #3333ps;
    EOP_flag = 1'b1;
    #3333ps;
    EOP_flag = 1'b0;
    #33330ps;
    encrypt_done = 1'b1;
    #3333ps;
    encrypt_done = 1'b0;
    #10000ps;
  
end

endmodule
