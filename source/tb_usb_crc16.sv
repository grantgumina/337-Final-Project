// $Id: $
// File name:   tb_usb_crc16.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC16 testbench

`timescale 1ns / 10ps

module tb_usb_crc16_valid();
	reg tb_clk;	
	reg tb_n_rst;
	reg tb_crc_en;
	reg [7:0] tb_data_in;
	reg [15:0] tb_crc_out;

	usb_crc16 CRC16
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.data_in(tb_data_in),
		.crc_en(tb_crc_en),
		.crc_out(tb_crc_out)
	);

	always begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	initial begin
		tb_data_in = 8'b10101010;
		tb_crc_en = 1'b1;

		#(270);
		#(CLK_PERIOD / 2);

		if (tb_crc_out == 5'b11110) begin
			$info("CRC16 GENERATION PASSED");
		end else begin
			$error("CRC16 GENERATION FAILED");
		end
	end
endmodule