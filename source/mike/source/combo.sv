// $Id: $
// File name:   combo.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Combines Individual Packet Signals

module combo(
	//input wire clk,
	//input wire rst,
	input wire [7:0] PID_in,
    input wire [63:0] data_in,
    input wire [63:0] encrypted,
    input wire [15:0] CRC_in,
    input wire [15:0] CRC16_out,
    input wire CRC_done,
    input wire [2:0] data_sel,
    output wire ready,
	output wire [87:0] shift_data
);

assign ready = data_sel != 3'b100;

assign shift_data = (data_sel == 3'b010 ? {80'd0,PID_in} : (data_sel == 3'b000 || data_sel == 3'b011 ? {64'd0,CRC_in,PID_in} : (data_sel == 3'b001 && CRC_done ? {CRC16_out,encrypted,PID_in} : 88'd0)));

endmodule






