// $Id: $
// File name:   glue.sv
// Created:     4/28/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Ties usb to averagers and performs crc

module glue 
(
    input wire n_rst,
    input wire clk,
    input wire [7:0] usb_data_in,
    input wire new_byte,
    
    output reg [(16*4*8+2*8)-1:0] usb_data_out,
    output wire usb_shift_out
);

typedef enum bit [2:0] {
    st_idle,
    st_shift_in,
    st_check_crc,
    st_err,
    st_add_value,
    st_prep_send,
    st_shift_out
} stateType;

wire crc_ready, crc_valid;
reg [7:0] crc_data_in;
reg [15:0] crc_out;
reg add_value, crc_enable, shift_out;

reg [6:0] count;
reg [6:0] next_count;
reg crc_invalid;
reg [(16*4*8+2*8)-1:0] input_sr;
reg [(16*4*8+2*8)-1:0] next_input_sr;

reg ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9, ar10, ar11, ar12, ar13, ar14, ar15, ar16;
reg average_ready;
assign average_ready = ar1&&ar2&&ar3&&ar4&&ar5&&ar6&&ar7&&ar8&&ar9&&ar10&&ar11&&ar12&&ar13&&ar14&&ar15&&ar16;

usb_crc16 CRC_CHECKER (n_rst, clk, crc_data_in, crc_enable, crc_out, crc_ready, crc_valid);

average AVERAGER_1 (clk, n_rst, add_value, input_sr[47:16], ar1, usb_data_out[47:16]);
average AVERAGER_2 (clk, n_rst, add_value, input_sr[79:48], ar2, usb_data_out[79:48]);
average AVERAGER_3 (clk, n_rst, add_value, input_sr[111:80], ar3, usb_data_out[111:80]);
average AVERAGER_4 (clk, n_rst, add_value, input_sr[143:112], ar4, usb_data_out[143:112]);
average AVERAGER_5 (clk, n_rst, add_value, input_sr[175:144], ar5, usb_data_out[175:144]);
average AVERAGER_6 (clk, n_rst, add_value, input_sr[207:176], ar6, usb_data_out[207:176]);
average AVERAGER_7 (clk, n_rst, add_value, input_sr[239:208], ar7, usb_data_out[239:208]);
average AVERAGER_8 (clk, n_rst, add_value, input_sr[271:240], ar8, usb_data_out[271:240]);
average AVERAGER_9 (clk, n_rst, add_value, input_sr[303:272], ar9, usb_data_out[303:272]);
average AVERAGER_10 (clk, n_rst, add_value, input_sr[335:304], ar10, usb_data_out[335:304]);
average AVERAGER_11 (clk, n_rst, add_value, input_sr[367:336], ar11, usb_data_out[367:336]);
average AVERAGER_12 (clk, n_rst, add_value, input_sr[399:368], ar12, usb_data_out[399:368]);
average AVERAGER_13 (clk, n_rst, add_value, input_sr[431:400], ar13, usb_data_out[431:400]);
average AVERAGER_14 (clk, n_rst, add_value, input_sr[463:432], ar14, usb_data_out[463:432]);
average AVERAGER_15 (clk, n_rst, add_value, input_sr[495:464], ar15, usb_data_out[495:464]);
average AVERAGER_16 (clk, n_rst, add_value, input_sr[527:496], ar16, usb_data_out[527:496]);

stateType current_state, next_state;

assign crc_invalid = (count == 100);
assign crc_data_in = input_sr[7:0];

// View
always_comb
begin: OUT_LOGIC
    next_count <= count;
    next_input_sr <= input_sr;
    add_value <= 1'b0;
    crc_enable <= 1'b0;
    case(current_state)
        st_add_value:
            begin
                add_value <= 1'b1;
            end

        st_shift_in:
            begin
                next_input_sr = {input_sr[519:8], 8'h00};
                next_count <= count + 1;
                if(count == 65) begin
                    next_count <= 7'b0000000;
                end
            end

        st_shift_out:
            begin
                shift_out <= 1'b1;
            end
       
        st_check_crc:
            begin
                crc_enable <= 1'b1;
                next_count <= count + 1;
                if (count == 100 || crc_valid) begin
                    next_count <= 7'b0000000;
                end
            end
    endcase
end


// Controller
always_comb
begin: NEXT_LOGIC
    next_state <= st_idle;
    case(current_state)
        st_idle:
            begin
                next_state <= st_idle;
                if (new_byte) begin
                    next_state <= st_shift_in;
                end else if(average_ready) begin
                    next_state <= st_shift_out;
                end
            end
        
        st_shift_in:
            begin
                if (count < 65 && !new_byte) begin
                    next_state <= st_idle;
                end else if(count < 65 && new_byte) begin
                    next_state <= st_shift_in;
                end else begin
                    next_state <= st_check_crc;
                end
            end

        st_check_crc:
            begin
                next_state <= st_check_crc;
                if (crc_ready) begin
                    if (crc_valid) begin
                        next_state <= st_add_value;
                    end else begin
                        next_state <= st_err;
                    end
                end
            end
    endcase
end

always_ff @ (posedge clk, negedge n_rst)
begin : REG_LOGIC
  if (n_rst == 1'b0) begin
    current_state <= st_idle;
    count <= 7'b0000000;
    input_sr <= '0;
  end else begin
    current_state <= next_state;
    count <= next_count;
    input_sr <= next_input_sr;
  end
end

endmodule
