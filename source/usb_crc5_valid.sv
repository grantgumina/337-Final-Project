// $Id: $
// File name:   usb_crc5.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC5 implementation

`timescale 1ns / 10ps

module usb_crc5_valid
	(
	    input wire n_rst,
	    input wire clk,
	    input wire clk_trans,
	    input wire [10:0] d,
	    output wire valid
    );

/*
 * If all token bits are recieved without error 
 * the remainder will be 5'b01100.
 */
	reg [4:0] crc5_rem = 5'b00110;
	reg [4:0] crc5_poly = 5'b10100;
	reg [4:0] crc5 = 5'b11111;
	integer i;

	assign valid = (crc5 == crc5_rem);

	always @ (posedge clk, negedge n_rst) begin
		for (i = $right(d); i <= $left(d); i++) begin
			if (crc5[$right(crc5)]^d[i]) begin
				crc5 = (crc5 >> 1)^crc5_poly;
			end else begin
				crc5 = crc5 >> 1;
			end
		end
	end

endmodule