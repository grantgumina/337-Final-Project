// $Id: $
// File name:   tb_average.sv
// Created:     4/26/2014
// Author:      Jack Hammons
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: this is the file in which there is the test bench for the file that was created at an earlier time named average.sv




`timescale 1ns / 100ps

module tb_average ();

	localparam TB_CLK_PERIOD	= 5.5555555; // changed

	reg tb_clk;
	reg tb_n_rst;
	reg tb_addValue;
	reg [31:0]tb_inputData;
	reg tb_averageReady;
	reg [31:0]tb_outputData;



	average DUT (
		.clk(tb_clk), 
		.n_rst(tb_n_rst), 
		.addValue(tb_addValue),
		.inputData(tb_inputData),
	 	.averageReady(tb_averageReady), 
		.outputData(tb_outputData)
	);


	always begin
		tb_clk = 1;
		#(TB_CLK_PERIOD / 2);
		tb_clk = 0;
		#(TB_CLK_PERIOD / 2);
	end



	initial begin
		tb_n_rst = 1;		
		@(posedge tb_clk)
		tb_n_rst = 0;
		@(posedge tb_clk)
		tb_n_rst = 1;
		@(posedge tb_clk)
		

		tb_addValue = 1;
		tb_inputData = 1;
		@(posedge tb_clk);
		tb_addValue = 0;

		#(TB_CLK_PERIOD * 10)
		@(posedge tb_clk)
		tb_addValue = 1;
		tb_inputData = 1;
		@(posedge tb_clk)
		tb_addValue = 0;
		@(posedge tb_clk);


		repeat(150) begin
   	  	
			#(TB_CLK_PERIOD * 10)
			@(posedge tb_clk)
			tb_addValue = 1;
			tb_inputData = 54321;
			@(posedge tb_clk)
			tb_addValue = 0;
			@(posedge tb_clk);

		end




	end



endmodule


