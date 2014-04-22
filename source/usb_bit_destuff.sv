// $Id: $
// File name:   usb_bit_destuff.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: USB bit destuffing

`timescale 1ns / 10ps

module usb_bit_destuff
	(
	    input wire rst_n,
	    input wire clk,
	    input wire clk_trans,
	    input wire d,
	    output wire strobe
	);

reg[6:0] data;
assign strobe = clk_trans && (data != 7'b0111111);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data <= 7'b0000000;
    end else if (clk_trans) begin
        data <= { data[5:0], d };
    end
end

endmodule