// $Id: $
// File name:   tb_glue.sv
// Created:     4/28/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: teste

`timescale 1ns / 10ps

module tb_glue ();

parameter CLK_PERIOD = 5.555555556;
parameter ULPI_CLK_PERIOD = 16.6666667;

reg n_rst, clk, new_byte, usb_shift_out;
reg [7:0] usb_data_in;
reg [(16*4*8+2*8)-1:0] usb_data_out;

glue GLUE_STATE_MACHINE(n_rst, clk, usb_data_in, new_byte, usb_data_out, usb_shift_out);

initial begin
    $info("she runs");
end

endmodule
