// $Id: $
// File name:   PID_sr.sv
// Created:     2/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: PID shift register

module PID_sr(
	input wire clk,
	input wire rst,
	input wire in_data,
	input wire data_shift,
  input wire SR_select,
  input wire read_val,
	output wire [7:0] PID_data
);

reg [7:0] curr_val;
reg [7:0] nxt_val;
//reg [3:0] curr_count;
//reg [3:0] nxt_count;

assign PID_data = nxt_val;

always @ (negedge rst, posedge clk) begin : REG_LOGIC
	if(rst == 1'b0) begin
		curr_val <= 8'd0;	// Reset all data bits to the idle line value
//		curr_count <= 4'd0;
	end else begin
		curr_val <= nxt_val;
//		curr_count <= nxt_count;
	end
	
end

always @ (in_data, data_shift, curr_val, SR_select, read_val) begin : NXT_LOGIC
	nxt_val = curr_val;
//  nxt_count <= curr_count;
  
	if(1'b1 == data_shift && SR_select == 1'b0 && read_val == 1'b1) begin
//	  nxt_count <= curr_count + 1;
//	  if(curr_count != 4'd1) begin
		  nxt_val = {in_data,curr_val[7:1]}; // Shift in the serial data
//		end
//		if(curr_count == 4'd9) begin
//      nxt_count = 0;
//    end
	end
end

endmodule
