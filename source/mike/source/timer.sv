// $Id: $
// File name:   timer.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB Timer Module

module timer (
	input wire clk,
	input wire rst,
	input wire reset_timer,
	output wire shift_enable
);

parameter IDLE = 3'b000, S0 = 3'b001, S1 = 3'b010, S2 = 3'b011, S3 = 3'b100;

reg [3:0] count12;
reg [3:0] nxt_count12;
reg [4:0] count25;
reg [4:0] nxt_count25;
reg [2:0] curr_state;
reg [2:0] next_state;
reg enable;

assign shift_enable = enable;

always @ (posedge clk, negedge rst) begin : STATE_REG
	if(1'b0 == rst) begin
		curr_state <= IDLE;
		count12 <= 4'b0000;
		count25 <= 5'b00000;
	end else begin
        curr_state <= next_state;
		count12 <= nxt_count12;
		count25 <= nxt_count25;
	end
end

always @ (curr_state, count12, count25, reset_timer) begin : NEXT_STATE
    nxt_count12 = count12;
    nxt_count25 = count25;
    enable = 1'b0;
	 case(curr_state)
		IDLE: begin
			enable = 1'b0;
			nxt_count12 = 4'b0000;
			nxt_count25 = 5'b00000;
			next_state = S0;
			if( reset_timer == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		S0: begin
			enable = 1'b0;
			nxt_count12 = count12;
			nxt_count25 = count25;
			if( count12 == 4'd14 ) begin //was 10
				next_state = S1;
			end
			else begin
				next_state = S0;
				nxt_count12 = count12 + 1;
			end
			if( reset_timer == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		S1: begin
			enable = 1'b1;
			nxt_count12 = 4'b0000;
			nxt_count25 = 5'b00000;
			next_state = S2;
			if( reset_timer == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		S2: begin
			enable = 1'b0;
			nxt_count12 = count12;
			nxt_count25 = count25;
			if( count25 == 5'd28 ) begin
				next_state = S3;
			end
			else begin
				next_state = S2;
				nxt_count25 = count25 + 1;
			end
			if( reset_timer == 1'b1 ) begin
				next_state = IDLE;
			end
		end
		S3: begin
			enable = 1'b1;
			nxt_count12 = 4'b0000;
			nxt_count25 = 5'b00000;
			next_state = S2;
			if( reset_timer == 1'b1 ) begin
				next_state = S0;
			end
		end
		default: next_state = IDLE;
	endcase
end

endmodule
