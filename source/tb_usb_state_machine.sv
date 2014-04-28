// $Id: $
// File name:   tb_usb_state_machine.sv
// Created:     4/23/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: such testing

`timescale 1ns / 10ps

module tb_usb_state_machine ();

parameter CLK_PERIOD = 5.555555556;
parameter ULPI_CLK_PERIOD = 16.6666667;

reg n_rst, clk, shift_out, nxt, dir, ulpi_clk, new_byte, stp;
reg [7:0] data_in;
reg [(16*4*8+2*8)-1:0] internal_data_in;
reg [7:0] data_out;
reg [7:0] internal_data_out;
int i;

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
    assert(new_byte == 1'b0)
        $info("Power on reset passed");
    else
        $error("Power on reset failed");
    n_rst = 1'b1;
    #CLK_PERIOD

    // Simple Rx CMD
    @(posedge ulpi_clk)
    test_case_num = 2;
    dir = 1'b1;
    @(posedge ulpi_clk)
    data_in = 8'hFF;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(negedge clk)
    assert(new_byte == 1'b0)
        $info("Test case %d passed", test_case_num);
    else
        $error("Test case %d failed", test_case_num);
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
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(negedge clk)
    assert(new_byte == 1'b0)
        $info("Test case %d passed pt a", test_case_num);
    else
        $error("Test case %d failed pt a", test_case_num);
    @(posedge ulpi_clk)
    data_in = 8'h00;
    @(posedge clk)
    assert(new_byte == 1'b0)
        $info("Test case %d passed pt b", test_case_num);
    else
        $error("Test case %d failed pt b", test_case_num);
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
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(negedge clk)
    assert(new_byte == 1'b0)
        $info("Test case %d passed", test_case_num);
    else
        $error("Test case %d failed", test_case_num);
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
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(negedge clk)
    assert(new_byte == 1'b1)
        $info("Test case %d passed", test_case_num);
    else
        $error("Test case %d failed", test_case_num);
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
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(negedge clk)
    assert(new_byte == 1'b1)
        $info("Test case %d passed pt a", test_case_num);
    else
        $error("Test case %d failed pt a", test_case_num);
    @(posedge ulpi_clk)
    data_in = 8'b10101010;
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(negedge clk)
    assert(new_byte == 1'b1)
        $info("Test case %d passed pt b", test_case_num);
    else
        $error("Test case %d failed pt b", test_case_num);
    @(posedge ulpi_clk)
    dir = 1'b0;
    nxt = 1'b0;
    @(posedge ulpi_clk)
    @(posedge ulpi_clk);

    // TX CMD for shift out
    test_case_num = 7;
    internal_data_in = {33{8'hAA, 8'hBB}};
    shift_out = 1'b1;
    @(posedge ulpi_clk);
    shift_out = 1'b0;
    assert(data_out == 8'hAA)
        $info("Tx AA test case passed");
    else
        $error("Tx AA test case failed");
    for (i=0; i<65; i++) begin
        @(posedge ulpi_clk)
        @(negedge clk)
        if (i%2 == 1) begin
            assert(data_out == 8'hBB)
                $info("Tx test case %d (BB) passed", i);
            else
                $error("Tx test case %d (BB) failed", i);
        end else begin
            assert(data_out == 8'hAA)
                $info("Tx test case %d (AA) passed", i);
            else
                $error("Tx test case %d (AA) failed", i);
        end
    end
end

endmodule
