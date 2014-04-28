// $Id: $
// File name:   tb_bridge.sv
// Created:     4/27/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: Testbench for bridge

`timescale 1ns / 10ps

module tb_bridge();
	
	parameter CLK_PERIOD = 10.0;

	reg tb_clk;	
	reg tb_n_rst;
	reg tb_shift_en;
	reg [7:0] tb_data_in;
	reg [527:0] tb_data_out;

	reg [527:0] tb_desired;

	bridge BRIDGE
	(
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.data_in(tb_data_in),
		.shift_en(tb_shift_en),
		.data_out(tb_data_out)
	);

	always begin
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2);
	end

	initial begin
		tb_shift_en = 1'b0;
		tb_n_rst = 1'b0;
		tb_data_in = 8'b10000001;
		#(CLK_PERIOD);
		#(CLK_PERIOD);
		tb_n_rst = 1'b1;
		@(posedge tb_clk);

		// TEST 1		
		tb_data_in = 8'b10000001;
		tb_shift_en = 1'b1;
		@(posedge tb_clk);
		tb_shift_en = 1'b0;
		@(posedge tb_clk);

		tb_desired = {{520{1'b0}}, 8'b10000001};
		//{512{504{1'b0}, 8'b10000111}}
		if (tb_data_out == tb_desired) begin
			$info("PASSED TEST 1");
		end else begin
			$error("FAILED TEST 1");
		end

		// TEST 2
		tb_data_in = 8'b10000001;
		tb_shift_en = 1'b1;
		@(posedge tb_clk);
		tb_shift_en = 1'b0;
		@(posedge tb_clk);

		tb_desired = {{512{1'b0}}, 8'b10000001, 8'b10000001};
		if (tb_data_out == tb_desired) begin
			$info("PASSED TEST 2");
		end else begin
			$error("FAILED TEST 2");
		end
	end
endmodule