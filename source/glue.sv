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
    
    output wire [(16*4*8+2*8)-1:0] usb_data_out,
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

usb_crc16 CRC_CHECKER (n_rst, clk, crc_data_in, crc_enable, crc_out, crc_ready, crc_valid);

stateType current_state, next_state;

reg [6:0] count;
reg [6:0] next_count;
reg crc_invalid;
reg [(16*4*8+2*8)-1:0] input_sr;
reg [(16*4*8+2*8)-1:0] next_input_sr;

reg average_ready;

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
