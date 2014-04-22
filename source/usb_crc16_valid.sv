// $Id: $
// File name:   usb_crc16.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC16 implementation

`timescale 1ns / 10ps

module usb_crc16_valid
	(
	    input wire rst_n,
	    input wire clk,
	    input wire clk_trans,
	    input wire d,
	    
	    input wire dump,
	    output wire out,
	    output wire valid
    );

    reg[15:0] r;
    reg[15:0] next;

    assign out = r[15];
    assign valid = (next == 16'b1000000000001101);

    always @(*) begin
        if (dump || out == d)
            next = { r[14:0], 1'b0 };
        else
            next = { !r[14], r[13:2], !r[1], r[0], 1'b1 };
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r <= 16'hffff;
        end else if (clk_trans) begin
            r <= next;
        end
    end

endmodule

