// $Id: $
// File name:   timer2.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB Timer Module

module timer2 (
	input wire clk,
	input wire rst,
	input wire shift_enable,
	output wire SR_shift
);

parameter IDLE = 3'b000, S0 = 3'b001, S1 = 3'b010, S2 = 3'b011, S3 = 3'b100;

reg [3:0] count;
reg [3:0] nxt_count;
reg [2:0] curr_state;
reg [2:0] next_state;
reg enable;

assign SR_shift = enable;

always @ (posedge clk, negedge rst) begin : STATE_REG
	if(1'b0 == rst) begin
		curr_state <= IDLE;
		count <= 4'b0000;
	end else begin
     		curr_state <= next_state;
		count <= nxt_count;
	end
end

always @ (curr_state, count, shift_enable) begin : NEXT_STATE
    nxt_count = count;
    enable = 1'b0;
	 case(curr_state)
		IDLE: begin
			enable = 1'b0;
			nxt_count = 4'b0000;
			next_state = S0;
			if( shift_enable == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		S0: begin
			enable = 1'b0;
			nxt_count = count;
			if( count== 4'd15 ) begin
				next_state = S1;
			end
			else begin
				next_state = S0;
				nxt_count = count + 1;
			end
			if( shift_enable == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		S1: begin
			enable = 1'b1;
			nxt_count = 4'b0000;
			next_state = S0;
			if( shift_enable == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		default: next_state = IDLE;
	endcase
end

endmodule