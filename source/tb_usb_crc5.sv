// $Id: $
// File name:   tb_usb_crc5.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC5 testbench

`timescale 1ns / 10ps

module tb_usb_crc5();

	parameter CLK_PERIOD = 10.0;
	
	reg tb_clk;	// on chip
	reg tb_clk_trans; // 480 - transceiver
	reg tb_n_rst;
	reg tb_crc_en;
	reg [7:0] tb_data_in;
	reg [4:0] tb_crc_out;

	usb_crc5 CRC5
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

	always begin
		tb_clk_trans = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk_trans = 1'b1;
		#(CLK_PERIOD / 2);
	end

	initial begin
		// TEST 1
		tb_n_rst = 1'b0;
		#(CLK_PERIOD);
		#(CLK_PERIOD);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);

		tb_data_in = 8'b10101010;
		tb_crc_en = 1'b1;

		#(270);
		#(CLK_PERIOD / 2);

		if (tb_crc_out == 5'b11110) begin
			$info("PASSED");
		end else begin
			$error("FAILED");
		end
	end
endmodule