// $Id: $
// File name:   timer4.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB Timer Module

module timer4 (
	input wire clk,
	input wire rst,
	input wire EOP_flag,
	output reg enc_done,
	output reg data_ready
);

parameter IDLE = 3'b000, S0 = 3'b001, S1 = 3'b010, S2 = 3'b011, S3 = 3'b100;

reg [3:0] count12;
reg [3:0] nxt_count12;
reg [2:0] curr_state;
reg [2:0] next_state;

always @ (posedge clk, negedge rst) begin : STATE_REG
	if(1'b0 == rst) begin
		curr_state <= IDLE;
		count12 <= 4'b0000;
	end else begin
    curr_state <= next_state;
		count12 <= nxt_count12;
	end
end

always @ (curr_state, count12, EOP_flag) begin : NEXT_STATE
    data_ready = 1'b0;
    enc_done = 1'b0;
    nxt_count12 = count12;
	  case(curr_state)
		IDLE: begin
			nxt_count12 = count12;
			if(count12 == 1) begin
			  next_state = S0;
			end else begin
			  next_state = IDLE;
			end
      if(EOP_flag == 1'b1) begin
            nxt_count12 = 1;
      end
		end
		S0: begin
			nxt_count12 = count12;
			if( count12 == 4'd10 ) begin 
				next_state = S1;
			end
			else begin
				next_state = S0;
				nxt_count12 = count12 + 1;
			end
		end
		S1: begin
			data_ready = 1'b1;
			nxt_count12 = 4'b0000;
			next_state = S2;
		end
		S2: begin
			nxt_count12 = count12;
			if( count12 == 4'd10 ) begin 
				next_state = S3;
			end
			else begin
				next_state = S2;
				nxt_count12 = count12 + 1;
			end
		end
		S3: begin
			enc_done = 1'b1;
			nxt_count12 = 4'b0000;
			next_state = IDLE;
		end
		default: next_state = IDLE;
	endcase
end

endmodule
