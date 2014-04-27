// $Id: $
// File name:   tb_usb_state_machine.sv
// Created:     4/23/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: such testing

`timescale 1ns / 10ps

module tb_usb_state_machine ();

parameter CLK_PERIOD = 10.0;

reg n_rst, clk, shift_out, nxt, dir, ulpi_clk, new_byte, stp;
reg [7:0] data_in;
reg [7:0] internal_data_in;
reg [7:0] data_out;
reg [7:0] internal_data_out;

usb_state_machine USB_STATE_MACHINE
(
    .n_rst(n_rst),
    .clk(clk),
    .shift_out(shift_out),
    .data_in(data_in),
    .internal_data_in(internal_data_in),
    .nxt(nxt),
    .dir(dir),
    .ulpi_clk(ulpi_clk),
    .new_byte(new_byte),
    .data_out(data_out),
    .internal_data_out(internal_data_out),
    .stp(stp)
);

always begin
    clk = 1'b0;
    #(CLK_PERIOD / 2);
    clk = 1'b1;
    #(CLK_PERIOD / 2);
end

always begin
    ulpi_clk = 1'b0;
    #(CLK_PERIOD / 2);
    ulpi_clk = 1'b1;
    #(CLK_PERIOD / 2);
end

initial begin
    $info("verilog party");
end

endmodule
