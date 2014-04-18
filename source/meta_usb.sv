// $Id: $
// File name:   meta_usb.sv
// Created:     4/16/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: Top level USB block

module meta_usb
	(
		input wire output_ready,
		input reg [31:0] average_data,
		output reg [31:0] stock_data,
		output reg data_ready
	);

	reg shift_out;
	reg new_byte;
	reg [7:0] data_in;
	reg [7:0] data_out;



endmodule