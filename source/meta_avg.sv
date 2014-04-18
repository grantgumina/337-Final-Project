// $Id: $
// File name:   meta_avg.sv
// Created:     4/16/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: Average Computational Block

module meta_avg
	(
		input wire clk,
		input wire n_rst,
		input wire [31:0] stock_price,
		input wire data_ready
		output wire [31:0] average
	);

	 wire [5:1] address_one;
	 wire [5:1] address_two;
	 wire [1:0] op_code;
	 wire [31:0] data_out;

	 computation_controller COMP_CONTROLLER
	 (
		.clk(clk),
	 	.n_rst(n_rst),
	 	.stock_price(stock_price),
	 	.data_ready(data_ready)
	 );

	 datapath DATAPATH_BLOCK
	 (
	 	.clk(clk),
	 	.n_rst(n_rst),
	 	.address_one(address_one),
	 	.address_two(address_two),
	 	.op_code(op_code),
	 	.data_out(data_out)
	 );


endmodule