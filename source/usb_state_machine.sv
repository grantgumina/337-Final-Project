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
		input wire nxt,
		input wire dir,
		input wire ulpi_clk,
		
		output wire new_byte,
		output wire [7:0] data_out,
		
		output wire stp
	);
	
typedef enum bit [3:0] {
  st_idle,
  st_turn_around,
  st_receive_rx_cmd,
  st_prepare_to_receive_byte,
  st_receive_byte
} stateType;

// Catch the edges
reg dir_rising, dir_falling, nxt_rising, nxt_falling, ulpi_clk_rising, ulpi_clk_falling;
edge_detector DIR_EDGE_DETECTOR(clk, n_rst, dir, dir_rising, dir_falling);
edge_detector NXT_EDGE_DETECTOR(clk, n_rst, nxt, nxt_rising, nxt_falling);
edge_detector ULPI_CLK_EDGE_DETECTOR(clk, n_rst, ulpi_clk, ulpi_clk_rising, ulpi_clk_ralling);

// Model
stateType current_state;
stateType next_state;

// View
always_comb
begin: OUT_LOGIC
  new_byte <= 1'b0;
  data_out <= 8'b0;
  stp <= 1'b0;
  case(current_state)
    st_idle:
      begin
        // Do shit
      end
  endcase
end

// Controller
always_comb
begin: NEXT_LOGIC
  next_state <= st_idle;
  case(current_state)
    begin
      st_idle:
        begin
          // Wait until dir goes high
          if (dir_rising) begin
            next_state <= st_turn_around;
          end
        end
      
      st_turn_around:
        begin
          // As long as dir stays high, hold until the next rising edge
          if (!dir)
            next_state <= st_idle
          if (ulpi_clk_rising)
            next_state <= st_receive_rx_cmd;
        end
    
        
      st_receive_rx_cmd:
        begin
          if (dir && !nxt) begin
            // This is an Rx command
            if (data[5:4] && 2'b01) begin
              // Rx Active signal
              next_state <= st_prepare_to_receive_byte;
            end
          end
          if (dir && nxt)
            next_state <= st_prepare_to_receive_byte;
        end
      
      st_prepare_to_receive_byte:
        begin
          if (ulpi_clk_rising)
            next_state <= receive_byte;
        end
      
      st_check_byte:
        begin
          // Stay here for one clock cycle just to pass through the data
        end
    end
  endcase
end
	
always_ff @ (posedge clk, negedge n_rst)
begin : REG_LOGIC
  if (n_rst == 1'b0) begin
    current_state <= st_idle;
  end else begin
    current_state <= next_state;
  end
end

endmodule