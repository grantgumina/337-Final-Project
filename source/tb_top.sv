// $Id: $
// File name:   tb_tob.sv
// Created:     4/29/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: top level test bench

`timescale 1ns / 10ps

module tb_top ();

parameter CLK_PERIOD = 5.555555556;
parameter ULPI_CLK_PERIOD = 16.6666667;

reg tb_n_rst, tb_clk;
reg [7:0] tb_usb_in; 
reg tb_nxt, tb_dir, tb_ulpi_clk;
reg [7:0] tb_usb_out;
reg tb_stp;

top TOP (tb_n_rst, tb_clk, tb_usb_in, tb_nxt, tb_dir, tb_ulpi_clk, tb_usb_out, tb_stp);

initial begin
    $info("wow");
end

endmodule
