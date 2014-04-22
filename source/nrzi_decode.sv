// $Id: $
// File name:   nrzi_decode.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: NRZI decoding module

`timescale 1ns / 10ps

module nrzi_decode
	(
	    input wire clk,
	    input wire clk_trans,
	    input wire i,
	    output wire o
	);

reg prev_i;
assign o = (prev_i == i);

always @(posedge clk) begin
    if (clk_trans) begin
        prev_i <= i;
    end
end

endmodule