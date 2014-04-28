// $Id: $
// File name:   tb_usb_crc16.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC16 testbench

`timescale 1ns / 10ps

module tb_usb_crc16();

	parameter CLK_PERIOD = 10.0;

	reg tb_clk;	
	reg tb_n_rst;
	reg [7:0] tb_data_in;
	reg [15:0] tb_crc_out;
	reg tb_crc_en;

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
		tb_n_rst = 1'b0;
		tb_crc_en = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);
		tb_crc_en = 1'b1;
		tb_data_in = 8'b10000111;

		#(400);
		#(CLK_PERIOD / 2);

		if (tb_crc_out == 16'b0100000100111111) begin
			tb_crc_en = 1'b0;
			@(posedge tb_clk);
			$info("CRC16 GENERATION PASSED");
		end else begin
			$error("CRC16 GENERATION FAILED");
		end
	end
endmodule