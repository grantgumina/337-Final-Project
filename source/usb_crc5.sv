// $Id: $
// File name:   usb_crc5.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC5 implementation

`timescale 1ns / 10ps

module usb_crc5
	(
		input reg n_rst,
		input reg clk,
		input reg [7:0] data_in,
		input reg crc_en,
		output reg [4:0] crc_out
    );

	reg [4:0] lfsr_q;
	reg [4:0] lfsr_c;

	assign crc_out = lfsr_q;
	
	always_comb begin
		lfsr_c[0] = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[3] ^ data_in[0] ^ data_in[3] ^ data_in[5] ^ data_in[6];
		lfsr_c[1] = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[4] ^ data_in[1] ^ data_in[4] ^ data_in[6] ^ data_in[7];
		lfsr_c[2] = lfsr_q[0] ^ lfsr_q[3] ^ lfsr_q[4] ^ data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[6] ^ data_in[7];
		lfsr_c[3] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[4] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[7];
		lfsr_c[4] = lfsr_q[1] ^ lfsr_q[2] ^ data_in[2] ^ data_in[4] ^ data_in[5];
	end

	always @ (posedge clk, negedge n_rst) begin
		if (~n_rst) begin
			lfsr_q <= {5{1'b1}};
		end else begin
			lfsr_q <= crc_en ? lfsr_c : lfsr_q;
		end
	end

endmodule