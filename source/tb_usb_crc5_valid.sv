// $Id: $
// File name:   tb_usb_crc5.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC5 testbench

`timescale 1ns / 10ps

module tb_usb_crc5_valid();

	parameter CLK_PERIOD = 10.0;
	
	reg tb_clk;	// on chip
	reg tb_clk_trans; // 480 - transceiver
	reg tb_n_rst;
	reg [10:0] tb_d;
	reg tb_crc5_valid;

	usb_crc5_valid CRC5
	(
		.clk(tb_clk),
		.clk_trans(tb_clk_trans),
		.n_rst(tb_n_rst),
		.d(tb_d),
		.valid(tb_crc5_valid)
	);

	always begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	always begin
		tb_clk_trans = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk_trans = 1'b1;
		#(CLK_PERIOD / 2);
	end

	initial begin
		tb_n_rst = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);

		tb_d = {4'he, 7'h15};
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		@(posedge tb_clk);
		#(CLK_PERIOD / 2);

		if ((tb_crc5_valid == 1)) begin
			$info("PASS CRC5_VALID = %d", tb_crc5_valid);
		end else begin
			$error("FAIL CRC5_VALID = %d", tb_crc5_valid);
		end


	end
endmodule