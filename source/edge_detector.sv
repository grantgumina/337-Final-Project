// $Id: $
// File name:   scl_edge.sv
// Created:     3/10/2014
// Author:      Luke Walsh
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: edge my bedge

module edge_detector (
  input wire clk,
  input wire n_rst,
  input wire scl,
  output wire rising_edge_found,
  output wire falling_edge_found
);

reg scl_intermediate;
reg scl_end;

always_ff @(posedge clk, negedge n_rst)
begin : SCL_FF1
  if (n_rst == 1'b0)
    scl_intermediate <= 1;
  else
    scl_intermediate <= scl;
end

always_ff @(posedge clk, negedge n_rst)
begin : SCL_FF2
  if (n_rst == 1'b0)
    scl_end <= 1;
  else
    scl_end <= scl_intermediate;
end

// Catch the edges
assign falling_edge_found = ~scl_intermediate && scl_end;
assign rising_edge_found = scl_intermediate && ~scl_end;

endmodule