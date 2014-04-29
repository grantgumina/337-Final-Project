// $Id: $
// File name:   top.sv
// Created:     4/29/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: highest level file

module top
(
    input wire n_rst,
    input wire clk,
    input wire [7:0] usb_in,
    input wire nxt,
    input wire dir,
    input wire ulpi_clk,
    
    output wire [7:0] usb_out,
    output wire stp
);

reg shift_out, new_byte;

reg [(16*4*8+2*8)-1:0] internal_data_into_usb;
reg [7:0] internal_data_out_of_usb;

usb_state_machine USB_STATE_MACHINE (n_rst, clk, shift_out, usb_in, internal_data_into_usb, nxt, dir, ulpi_clk, new_byte, usb_out, internal_data_out_of_usb, stp);

glue GLUE (n_rst, clk, internal_data_out_of_usb, new_byte, internal_data_into_usb, shift_out);

endmodule
