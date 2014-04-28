// $Id: $
// File name:   usb_crc5.sv
// Created:     4/21/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: CRC16 implementation

`timescale 1ns / 10ps

module usb_crc16
    (
        input reg n_rst,
        input reg clk,
        input reg [7:0] data_in,
        input reg crc_en,
        output reg [15:0] crc_out,
        output reg flag
    );

    reg [15:0] lfsr_q;
    reg [15:0] lfsr_c;

    assign crc_out = lfsr_q;
    assign flag = (crc_out == 16'b0000001100010010);

    always_comb begin
        lfsr_c[0] = lfsr_q[8] ^ lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15] ^ data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
        lfsr_c[1] = lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
        lfsr_c[2] = lfsr_q[8] ^ lfsr_q[9] ^ data_in[0] ^ data_in[1];
        lfsr_c[3] = lfsr_q[9] ^ lfsr_q[10] ^ data_in[1] ^ data_in[2];
        lfsr_c[4] = lfsr_q[10] ^ lfsr_q[11] ^ data_in[2] ^ data_in[3];
        lfsr_c[5] = lfsr_q[11] ^ lfsr_q[12] ^ data_in[3] ^ data_in[4];
        lfsr_c[6] = lfsr_q[12] ^ lfsr_q[13] ^ data_in[4] ^ data_in[5];
        lfsr_c[7] = lfsr_q[13] ^ lfsr_q[14] ^ data_in[5] ^ data_in[6];
        lfsr_c[8] = lfsr_q[0] ^ lfsr_q[14] ^ lfsr_q[15] ^ data_in[6] ^ data_in[7];
        lfsr_c[9] = lfsr_q[1] ^ lfsr_q[15] ^ data_in[7];
        lfsr_c[10] = lfsr_q[2];
        lfsr_c[11] = lfsr_q[3];
        lfsr_c[12] = lfsr_q[4];
        lfsr_c[13] = lfsr_q[5];
        lfsr_c[14] = lfsr_q[6];
        lfsr_c[15] = lfsr_q[7] ^ lfsr_q[8] ^ lfsr_q[9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15] ^ data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
    end

    always @ (posedge clk, negedge n_rst) begin
        if (~n_rst) begin
            lfsr_q <= {16{1'b1}};
        end else begin
            lfsr_q <= crc_en ? lfsr_c : lfsr_q;
        end
    end

endmodule
