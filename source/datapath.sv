// $Id: $
// File name:   datapath.sv
// Created:     4/16/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: Module for datapath block (interfaces with SRAM.
// 

module datapath
	(
		input wire [6,0] address_one,
		input wire [6,0] address_two,
		input wire [31,0] data_in,
		input wire [1,0] op_code,
		output wire [31,0] data_out
	);

endmodule