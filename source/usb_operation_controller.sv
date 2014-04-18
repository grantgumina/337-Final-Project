// $Id: $
// File name:   operation_controller.sv
// Created:     4/16/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: USB Operation Controller

module usb_operation_controller
	(
		input wire output_ready,
		input wire [31:0] average_data,
		output wire [31:0] stock_data,
		output wire data_ready
	);
	
	wire shift_out;
	wire new_packet;
	wire [7:0] data_in;
	wire [7:0] data_out;

endmodule