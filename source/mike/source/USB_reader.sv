// $Id: $
// File name:   USB_reader.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Top Level USB Reader Module

module USB_reader(
	input wire clk,
	input wire rst,
	input wire [1:0] USBdata,
	
    output wire [7:0] PID_data,
    output wire [63:0] data,
    output wire [15:0] CRC_data,
    output reg EOP_found

);

wire [1:0] sync_data;
wire shift_enable;
wire data_bit;
wire read_val;
wire reset_timer;
wire serial_data;
wire data_shift;
wire data_shift2;
wire eop;

sync SYN(.clk(clk),.rst(rst),.USBdata(USBdata),.USB_sync(sync_data));

decode DEC(.clk(clk),.rst(rst),.Dplus(sync_data[1]),.shift_enable(shift_enable),.data_bit(data_bit));

controller CON(.clk(clk),.rst(rst),.shift_enable(shift_enable),.read_val(read_val),.data_bit(data_bit),.data(serial_data),.SR_select(SR_select),.SR_shift_in(data_shift),.SR_shift_out(data_shift2));

packet_detect PKT(.clk(clk),.rst(rst),.shift_enable(shift_enable),.USBdata(sync_data),.read_val(read_val),.EOP_found(eop));

edge_detect EDG(.clk(clk),.rst(rst),.USBdata(sync_data),.edge_found(reset_timer));

timer TIM(.clk(clk),.rst(rst),.reset_timer(reset_timer),.shift_enable(shift_enable));

PID_sr PID(.clk(clk),.rst(rst),.in_data(serial_data),.data_shift(data_shift2),.read_val(read_val),.SR_select(SR_select),.PID_data(PID_data));

data_sr DSR(.clk(clk),.rst(rst),.in_data(serial_data),.data_shift(data_shift2),.SR_select(SR_select),.data(data),.CRC_data(CRC_data));

timer2 TM2(.clk(clk),.rst(rst),.shift_enable(shift_enable),.SR_shift(data_shift));

always @ (eop)
begin
  EOP_found = eop;
end

endmodule
