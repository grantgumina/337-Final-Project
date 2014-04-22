// $Id: $
// File name:   sync.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Synchronizer module

module sync(
	input wire clk,
	input wire rst,
	input wire [1:0] USBdata,
	output wire [1:0] USB_sync
);

reg [1:0] q1, q2;

always @ (posedge clk, negedge rst) begin
	if(rst == 1'b0) begin
		q1 <= 0;
		q2 <= 0;
	end else begin
		q1 <= USBdata;
		q2 <= q1;
	end
end

assign USB_sync = q2; 

endmodule 
