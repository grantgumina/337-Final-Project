// $Id: $
// File name:   data_sr.sv
// Created:     4/22/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Data shift register

module data_sr(
	input wire clk,
	input wire rst,
	input wire in_data,
	input wire data_shift,
    input wire SR_select,
	output wire [63:0] data,
    output wire [15:0] CRC_data
);

reg [81:0] curr_val;
reg [81:0] nxt_val;

assign data = nxt_val[63:0];
assign CRC_data = nxt_val[79:64];

always @ (negedge rst, posedge clk) begin : REG_LOGIC
	if(rst == 1'b0) begin
		curr_val <= 82'd0;	// Reset all data bits to the idle line value
	end else begin
		curr_val <= nxt_val;
	end
end

always @ (in_data, data_shift, curr_val, SR_select) begin : NXT_LOGIC
	nxt_val = curr_val;

	if(1'b1 == data_shift && SR_select == 1'b1) begin
		nxt_val = {in_data,curr_val[81:1]}; // Shift in the serial data
	end
end

endmodule
