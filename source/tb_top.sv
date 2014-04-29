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

always begin
    tb_clk = 1'b0;
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1;
    #(CLK_PERIOD / 2);
end

always begin
    tb_ulpi_clk = 1'b0;
    #(ULPI_CLK_PERIOD / 2);
    tb_ulpi_clk = 1'b1;
    #(ULPI_CLK_PERIOD / 2);
end

int i;

initial begin
    // Initial reset
    tb_n_rst = 1'b0;
    #CLK_PERIOD
    tb_n_rst = 1'b1;
    #CLK_PERIOD
   
    // Single number test data
    tb_nxt = 1'b0;
    tb_dir = 1'b0;
    @(posedge tb_ulpi_clk)
    #0.01
    tb_dir = 1'b1;
    @(posedge tb_ulpi_clk)
    tb_usb_in = 8'b00010000;
    @(posedge tb_ulpi_clk)
    tb_nxt = 1'b1;
    for (i=0; i<16; i++) begin
        tb_usb_in = 8'h12;
        @(posedge tb_ulpi_clk)
        tb_usb_in = 8'h34;
        @(posedge tb_ulpi_clk)
        tb_usb_in = 8'h56;
        @(posedge tb_ulpi_clk);
        tb_usb_in = 8'h78;
        @(posedge tb_ulpi_clk);
    end
    // crc hold
    tb_usb_in = 8'hFF;
    @(posedge tb_ulpi_clk)
    // crc value
    tb_usb_in = 8'b10000111;
    @(posedge tb_ulpi_clk)

    tb_dir = 1'b0;
    tb_nxt = 1'b0;
    @(posedge tb_ulpi_clk)
    @(posedge tb_ulpi_clk);

    for (i=0; i<1000; i++) begin
        @(posedge tb_ulpi_clk);
    end
end

endmodule
