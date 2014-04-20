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
	 
	 wire sram_mem_clr, sram_mem_init, sram_mem_dump, sram_verbose, sram_read_enable, sram_write_enable;
	 wire [4:0] sram_start_address;
	 wire [4:0] sram_last_address;
	 wire [4:0] sram_address;
	 wire [31:0] sram_read_data;
	 wire [31:0] sram_write_data;

on_chip_sram_wrapper( 
		.W_ADDR_SIZE_BITS(5),
		.W_DATA_SIZE_WORDS(4)
	) SRAM (
    .init_file_number(1),
		.dump_file_number(2),
		.mem_clr(sram_mem_clr),
    .mem_init(sram_mem_init),
    .mem_dump(sram_mem_dump),
    .start_address(sram_start_address),
    .last_address(sram_last_address),
    .verbose(sram_verbose),
		.read_enable(sram_read_enable),
		.write_enable(sram_write_enable),
		.address(sram_address),
		.read_data(sram_read_data),
		.write_data(sram_write_data)
	);


endmodule