// $Id: $
// File name:   bridge.sv
// Created:     4/27/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: Bridge between Luke and Jack's module

`timescale 1ns / 10ps

module bridge
	(
		input reg clk,
		input reg n_rst,
		input reg shift_en,
		input reg [7:0] data_in,
		output reg [511:0] data_out
	);

	reg [511:0] current;
	reg [511:0] next;
	reg [511:0] i;

	assign data_out = current;

	always_ff @ (posedge clk, negedge n_rst) begin
		if (n_rst == 0) begin
			current	<= {512{1'b0}};
		end else begin
			current <= next;
		end
	end

	always_comb begin
		next <= current;
		if (shift_en) begin
			next <= {current[511 - 8:0], data_in};
		end else begin
			next <= current;
		end
	end
endmodule