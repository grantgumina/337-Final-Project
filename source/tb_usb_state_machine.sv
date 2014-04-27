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
parameter ULPI_CLK_PERIOD = 40.0;

reg n_rst, clk, shift_out, nxt, dir, ulpi_clk, new_byte, stp;
reg [7:0] data_in;
reg [7:0] internal_data_in;
reg [7:0] data_out;
reg [7:0] internal_data_out;

reg [3:0] test_case_num;

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
    #(ULPI_CLK_PERIOD / 2);
    ulpi_clk = 1'b1;
    #(ULPI_CLK_PERIOD / 2);
end

initial begin
    data_in = 8'hFF;
    internal_data_in = 8'hFF;
    shift_out = 1'b0;
    nxt = 1'b0;
    dir = 1'b0;

    // Initial reset
    test_case_num = 1;
    n_rst = 1'b0;
    #CLK_PERIOD
    n_rst = 1'b1;
    #CLK_PERIOD

    // Simple Rx CMD
    @(posedge ulpi_clk)
    test_case_num = 2;
    dir = 1'b1;
    @(posedge ulpi_clk)
    data_in = 8'hFF;
    @(posedge ulpi_clk)
    dir = 1'b0;
    @(posedge ulpi_clk)
    @(posedge ulpi_clk)

    // Double Rx CMD
    @(posedge ulpi_clk)
    test_case_num = 3;
    dir = 1'b1;
    @(posedge ulpi_clk)
    data_in = 8'hFF;
    @(posedge ulpi_clk)
    data_in = 8'h00;
    @(posedge ulpi_clk)
    dir = 1'b0;

    // Rx CMD with data byte (no nxt transition)
    @(posedge ulpi_clk)
    test_case_num = 4;
    dir = 1'b1;
    @(posedge ulpi_clk)
    data_in = 8'b00010000;
    @(posedge ulpi_clk)
    data_in = 8'b11111111;
    @(posedge ulpi_clk)
    dir = 1'b0;
    @(posedge ulpi_clk)
    @(posedge ulpi_clk)

    // Rx CMD with data byte 
    @(posedge ulpi_clk)
    test_case_num = 5;
    dir = 1'b1;
    @(posedge ulpi_clk)
    data_in = 8'b00010000;
    @(posedge ulpi_clk)
    nxt = 1'b1;
    data_in = 8'b11111111;
    @(posedge ulpi_clk)
    dir = 1'b0;
    nxt = 1'b0;
    @(posedge ulpi_clk)
    @(posedge ulpi_clk)

    // RX CMD with multiple data bytes
    @(posedge ulpi_clk)
    test_case_num = 6;
    dir = 1'b1;
    @(posedge ulpi_clk)
    data_in = 8'b00010000;
    @(posedge ulpi_clk)
    nxt = 1'b1;
    data_in = 8'b11111111;
    @(posedge ulpi_clk)
    data_in = 8'b10101010;
    @(posedge ulpi_clk)
    dir = 1'b0;
    nxt = 1'b0;
    @(posedge ulpi_clk)
    @(posedge ulpi_clk);

end

endmodule
