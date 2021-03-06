// $Id: $
// File name:   controller.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB Controller Module

module controller(
	input wire clk,
	input wire rst,
	input wire shift_enable,
    input read_val,
	input wire data_bit,
	input wire SR_shift_in,
	output wire data,
    output wire SR_shift_out,
    output wire SR_select
);

parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b11;
 
reg [2:0] one_count;
reg [2:0] next_one_count;
reg [3:0] PID_count;
reg [3:0] next_PID_count;
reg [1:0] curr_state;
reg [1:0]next_state;
reg out_data;
reg next_out_data;
reg reg_sel;
reg next_reg_sel;

assign SR_select = reg_sel;
assign data = out_data;
assign SR_shift_out = (one_count != 6 ? SR_shift_in : 1'b0);

always @ (posedge clk, negedge rst) begin : STATE_REG
	if(1'b0 == rst) begin
        curr_state <= IDLE;
        one_count <= 3'd0;
        PID_count <= 4'd0;
        out_data <= 1'b0;
        reg_sel <= 1'b0;
	end else begin
        curr_state <= next_state;
        one_count <= next_one_count;
        PID_count <= next_PID_count;
        out_data <= next_out_data;
        reg_sel <= next_reg_sel;
	end
end

always @ (curr_state, one_count, PID_count, shift_enable, data_bit, read_val, out_data, reg_sel) begin : NXT_STATE
    next_state = curr_state;
    next_one_count = one_count;
    next_PID_count = PID_count;
    next_out_data = out_data;
    next_reg_sel = reg_sel;
    case(curr_state)
        IDLE: begin
            if( shift_enable == 1 && read_val == 1 ) begin
                next_state = S1;
                next_reg_sel = 1'b0;
                next_out_data = data_bit;
                next_PID_count = PID_count + 1;
            end else begin
                next_reg_sel = 1'b0;
                next_state = IDLE;
            end
        end
        S1: begin
            if( shift_enable == 1 && PID_count < 4'd9 ) begin
                next_state = S1;
                next_reg_sel = 1'b0;
                next_PID_count = PID_count + 1;
                next_out_data = data_bit;
            end else if( shift_enable == 1 && PID_count == 4'd9 ) begin
                next_state = S2;
                next_reg_sel = 1'b1;
                next_PID_count = 4'd0;
                next_out_data = data_bit;
                next_one_count = data_bit ? one_count + 1 : 2'b0;
            end else begin
                next_state = S1;
                next_reg_sel = 1'b0;
                next_out_data = out_data;
            end
        end
        S2: begin
            if( shift_enable == 1 && read_val == 1) begin
                next_state = S2;
                next_reg_sel = 1'b1;
                if( one_count < 6 ) begin
                  next_out_data = data_bit;
                  next_one_count = data_bit ? one_count + 1 : 2'b0;
                end else if (one_count == 6) begin
                  next_out_data = 1'b1;
                  next_one_count = one_count + 1;
                end else begin
                  next_out_data = 1'b1;
                  next_one_count = 3'd0;
                end
            end else if( shift_enable == 1 && read_val == 0 ) begin
                next_state = IDLE;
                next_out_data = out_data;
                next_out_data = 1'b0;
            end else begin
                next_out_data = 1'b1;
                next_state = S2;
                next_out_data = out_data;
            end
        end
        default: next_state = IDLE;
    endcase
end

endmodule
            
