// $Id: $
// File name:   avg.sv
// Created:     4/16/2014
// Author:      Grant Gumina
// Lab Section: 02
// Version:     1.0  Initial Design Entry
// Description: Computation Controller
// 

module computation_controller
	(
		input wire clk,
		input wire n_rst,
		input wire [31:0] stock_price,
		input wire data_ready
	);

	typedef enum bit [3:0] {EIDLE, IDLE, STORE, SORT1, SORT2, SORT3, SORT4, ADD1, ADD2, ADD3} stateType;

	always_ff @ (posedge clk, negedge n_rst) begin

	end

	always_comb begin

	end
endmodule