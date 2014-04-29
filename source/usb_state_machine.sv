// $Id: $
// File name:   usb_state_machine.sv
// Created:     4/16/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: USB Protocol State Machine

module usb_state_machine
	(
	    input wire n_rst,
	    input wire clk,
        input wire shift_out,

		input wire [7:0] data_in,
		input wire [(16*4*8+2*8)-1:0] internal_data_in,
		input wire nxt,
		input wire dir,
		input wire ulpi_clk,
		
		output reg new_byte,
		output reg [7:0] data_out,
		output wire [7:0] internal_data_out,
		
		output reg stp
	);
	
typedef enum bit [3:0] {
  st_idle,
  st_turn_up,
  st_turn_down, // For what?
  st_receive_rx,
  st_err,
  st_prepare_for_byte,
  st_pass_through_byte,
  st_send_tx,
  st_send_data,
  st_done_sending
} stateType;

// Catch the edges
reg dir_rising, dir_falling, ulpi_clk_rising;
edge_detector DIR_EDGE_DETECTOR(clk, n_rst, dir, dir_rising);
edge_detector DIR_INVERSE_EDGE_DETECTOR(clk, n_rst, !dir, dir_falling);
edge_detector ULPI_CLK_EDGE_DETECTOR(clk, n_rst, ulpi_clk, ulpi_clk_rising);

// Model
stateType current_state;
stateType next_state;
reg [8:0] index;
reg [8:0] next_index;
reg [(16*4*8+2*8)-1:0] mega_shift;
reg [(16*4*8+2*8)-1:0] next_mega_shift;

// View
assign internal_data_out = data_in;

always_comb
begin: OUT_LOGIC
  new_byte <= 1'b0;
  stp <= 1'b0;
  data_out <= 8'b00000000;
  next_index <= 8'b00000000;
  next_mega_shift <= mega_shift;
  case(current_state)
    st_pass_through_byte:
        begin
            if (nxt && dir) begin
                new_byte <= 1'b1;
            end
        end

    st_send_data:
        begin
            next_index <= index;
            data_out <= mega_shift[(16*4*8+2*8)-1:(16*4*8+2*8)-1-8];
            if (ulpi_clk_rising) begin
                next_index <= index + 1;
                next_mega_shift <= {mega_shift[(16*4*8+2*8)-1-8:0], 8'h00};
            end
        end

    st_done_sending:
        begin
            stp <= 1'b1;
        end

    st_send_tx:
        begin
            data_out <= 8'b01000000;
            next_mega_shift <= internal_data_in;
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
          // Wait until dir goes high
          if (dir_rising) begin
            next_state <= st_turn_up;
          end else if (shift_out) begin
            next_state <= st_send_tx;
          end
        end
      
      st_turn_up:
        begin
          next_state <= st_turn_up;
          // As long as dir stays high, hold until the next rising edge
          if (!dir) begin
            next_state <= st_idle;
          end else if (ulpi_clk_rising) begin
            next_state <= st_receive_rx;
          end
        end
      
      st_turn_down:
        begin
            next_state <= st_idle;
        end
        
      st_receive_rx:
        begin
          next_state <= st_receive_rx;
          if (nxt) begin
            next_state <= st_err;
          end else if (dir && data_in[5:4] == 2'b01) begin
            next_state <= st_prepare_for_byte;
          end else if (dir_falling) begin
            next_state <= st_turn_down;
          end
        end
      
      st_prepare_for_byte:
        begin
          next_state <= st_prepare_for_byte;
          if (ulpi_clk_rising) begin
            next_state <= st_pass_through_byte;
          end else if(dir_falling) begin
            next_state <= st_turn_down;
          end
        end
        
      st_pass_through_byte:
        begin
          next_state <= st_pass_through_byte;
          if(dir && !nxt) begin
            next_state <= st_receive_rx;
          end else if(!dir && !nxt) begin
            next_state <= st_turn_down;
          end else if (nxt && dir) begin
            next_state <= st_prepare_for_byte;
          end
        end

      st_send_tx:
        begin
            next_state <= st_send_tx;
            if(ulpi_clk_rising) begin
              next_state <= st_send_data;
            end
        end

      st_send_data:
        begin
            next_state <= st_send_data;
            if (index == 65 && ulpi_clk_rising) begin
                next_state <= st_done_sending;
            end
        end

      st_done_sending:
        begin
            next_state <= st_done_sending;
            if (ulpi_clk_rising) begin
                next_state <= st_idle;
            end
        end
  endcase
end
	
always_ff @ (posedge clk, negedge n_rst)
begin : REG_LOGIC
  if (n_rst == 1'b0) begin
    current_state <= st_idle;
    index <= 8'b00000000;
    mega_shift <= '0;
  end else begin
    current_state <= next_state;
    index <= next_index;
    mega_shift <= next_mega_shift;
  end
end

endmodule
