// $Id: $
// File name:   toplevel.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Top Level USB Module

module toplevel(
	input wire clk,
	input wire rst,
    input wire spi_clk,
    input wire spi_serial,
	input wire [1:0] USBdata,
	
  output wire [1:0] USBdata_out

);

wire [7:0] PID_data;
wire [63:0] data;
wire [15:0] CRC_data;
wire crc16_enable;
wire [15:0] crc16_O;
wire [15:0] crc16chk;
wire crc16_err;
wire PID_enable;
wire EOP_flag;
wire [2:0] data_select;
wire [47:0] key00;
wire [47:0] key01;
wire [47:0] key02;
wire [47:0] key03;
wire [47:0] key04;
wire [47:0] key05;
wire [47:0] key06;
wire [47:0] key07;
wire [47:0] key08;
wire [47:0] key09;
wire [47:0] key10;
wire [47:0] key11;
wire [47:0] key12;
wire [47:0] key13;
wire [47:0] key14;
wire [47:0] key15;
wire [63:0] encrypted;
wire enc_done;
wire CRC_done;
wire read_ready;
wire [87:0] shift_data;
wire out_tim;
wire data_ready;
wire EOP_found;
wire [63:0] data_fixed;
wire [15:0] crc16_fixed;
wire [7:0] PID_fixed;


USB_reader USB(.clk(clk),.rst(rst),.USBdata(USBdata),.PID_data(PID_data),.data(data),.CRC_data(CRC_data),.EOP_found(EOP_flag));

//crc16_chk CHK16(.clk(clk),.rst(rst),.crc16_enable(crc16_enable),.crc16_I(crc16_fixed),.crc16_DI(data_fixed),.crc16_O(crc16chk),.crc16_err(crc16_err));

//crc16_calc CAL16(.clk(clk),.rst(rst),.crc16_DI(encrypted),.crc16_O(crc16_O),.enc_done(enc_done),.CRC_done(CRC_done));

PID_chk PCHK(.clk(clk),.rst(rst),.PID_I(PID_fixed),.EOP_flag(EOP_flag),.data_select(data_select),.crc16_enable(crc16_enable));

encryption ENCRYPT(.encrypt_done(EOP_found),.in_key00(key00),.in_key01(key01),.in_key02(key02),.in_key03(key03),.in_key04(key04),.in_key05(key05),.in_key06(key06),.in_key07(key07),.in_key08(key08),.in_key09(key09),.in_key10(key10),.in_key11(key11),.in_key12(key12),.in_key13(key13),.in_key14(key14),.in_key15(key15),.in_data(data_fixed),.out_data(encrypted),.clk(clk),.mode(1'b1),.EOP_flag(data_ready));

SPI SPI(.spi_clk(spi_clk),.n_reset(rst),.spi_data(spi_serial),.spi_out00(key00),.spi_out01(key01),.spi_out02(key02),.spi_out03(key03),.spi_out04(key04),.spi_out05(key05),.spi_out06(key06),.spi_out07(key07),.spi_out08(key08),.spi_out09(key09),.spi_out10(key10),.spi_out11(key11),.spi_out12(key12),.spi_out13(key13),.spi_out14(key14),.spi_out15(key15));

combo COM(.PID_in(PID_fixed),.data_in(data_fixed),.encrypted(encrypted),.CRC_in(crc16_fixed),.CRC16_out(16'b1111111111111111),/*.CRC16_out(crc16_O),*/.CRC_done(CRC_done),.data_sel(data_select),.ready(read_ready),.shift_data(shift_data));

USB_writer WRT(.data_in(shift_data),.ready(read_ready),.data_select(data_select),.clk(clk),.shift(out_tim),.n_rst(rst),.data_out(USBdata_out));

timer3 TM3(.clk(clk),.rst(rst),.data_shift(out_tim));

timer4 TM4(.clk(clk),.rst(rst),.EOP_flag(EOP_flag),.enc_done(EOP_found),.data_ready(data_ready));

fix_order FIX(.PID_in(PID_data),.crc16_in(CRC_data),.data_in(data),.PID_fixed(PID_fixed),.crc16_fixed(crc16_fixed),.data_fixed(data_fixed));

endmodule
