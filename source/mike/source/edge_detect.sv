// $Id: $
// File name:   edge_detect.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB edge detector

module edge_detect(
	input wire clk,
	input wire rst,
	input wire [1:0] USBdata,
	output wire edge_found
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

assign edge_found = (q2[1] ^ q1[1]) || (q2[0] ^ q1[0]); 

endmodule
	
		
