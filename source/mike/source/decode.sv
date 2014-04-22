// $Id: $
// File name:   decode.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Decodes USB Input Signals

module decode(
	input wire clk,
	input wire rst,
	input wire Dplus,
  input wire shift_enable,
	output wire data_bit
);

reg q1, q2;

always @ (posedge clk, negedge rst) begin
	if(rst == 1'b0) begin
		q1 <= 0;
		q2 <= 0;
	end else begin
	  if(shift_enable == 1'b1) begin
		    q1 <= Dplus;
		    q2 <= q1;
		end
	end
end

assign data_bit = !(q2 ^ q1);
//assign data_bit = !(q2[1] ^ q1[1]) && !(q2[0] ^ q1[0]); 

endmodule
