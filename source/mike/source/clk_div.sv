// $Id: $
// File name:   clk_div.sv
// Created:     4/16/2013
// Author:      Birzhan Nurimbetov
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Clock Divider (Birzhan)

module clk_div
(
  input wire clk,
  input wire n_reset,
  output wire spi_clk
);

reg n = 1'b1;
reg [3:0] count = 4'd0;
reg [3:0] next_count;

assign spi_clk = n;


always @ (posedge clk, negedge n_reset)
begin
  if (n_reset == 1'b0)
    count <= 4'd0;
  else
    count <= next_count;

end

always @ (count)
begin
  
  next_count = count + 1;

  if (count == 4'd5)
        next_count = 4'd0;

end

 always @ (count)
 begin
    if (count < 4'd3)
	     n = 1'b1; 
    else      
	     n = 1'b0;
end
      

endmodule
