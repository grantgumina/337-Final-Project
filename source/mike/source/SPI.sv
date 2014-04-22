// $Id: $
// File name:   SPI.sv
// Created:     4/16/2013
// Author:      Birzhan Nurimbetov
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: SPI for the encryption key (Birzhan)

module SPI (
	input wire spi_clk,
	input wire n_reset,
	input wire spi_data, 
	output wire [47:0] spi_out00,
	output wire [47:0] spi_out01,
	output wire [47:0] spi_out02,
	output wire [47:0] spi_out03,
	output wire [47:0] spi_out04,
	output wire [47:0] spi_out05,
	output wire [47:0] spi_out06,
	output wire [47:0] spi_out07,
	output wire [47:0] spi_out08,
	output wire [47:0] spi_out09,
	output wire [47:0] spi_out10,
	output wire [47:0] spi_out11,
	output wire [47:0] spi_out12,
	output wire [47:0] spi_out13,
	output wire [47:0] spi_out14,
	output wire [47:0] spi_out15

);

reg [767:0] Reg_ff;
reg [47:0] spi_out_t;
integer ii;
reg [9:0] count;
reg [9:0] next_count;

genvar gg;

always @(posedge spi_clk, negedge n_reset)
begin
	if (n_reset == 1'b0)
	begin
		count <= 10'd0;
		Reg_ff <= 768'd0;
	end
	else begin 
	  count <=next_count;
	  if (count <= 767) begin
		  for (ii=767; ii>0; ii=ii-1)
		    Reg_ff[ii] <= Reg_ff[ii - 1];
		  
		  Reg_ff[0] <= spi_data;
		  end
		else
		  Reg_ff[0] <= Reg_ff[0];
	end
end

always @(count)
begin
	next_count = count + 1;
	if (count >= 10'd768)
		next_count = 10'd1000;
end


generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out00[gg] = Reg_ff[(15-0)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out01[gg] = Reg_ff[(15-1)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out02[gg] = Reg_ff[(15-2)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out03[gg] = Reg_ff[(15-3)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out04[gg] = Reg_ff[(15-4)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out05[gg] = Reg_ff[(15-5)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out06[gg] = Reg_ff[(15-6)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out07[gg] = Reg_ff[(15-7)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out08[gg] = Reg_ff[(15-8)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out09[gg] = Reg_ff[(15-9)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out10[gg] = Reg_ff[(15-10)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out11[gg] = Reg_ff[(15-11)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out12[gg] = Reg_ff[(15-12)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out13[gg] = Reg_ff[(15-13)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out14[gg] = Reg_ff[(15-14)*48 + gg];
  end
endgenerate

generate 
  for (gg=0; gg<48; gg=gg+1)
  begin
    assign spi_out15[gg] = Reg_ff[(15-15)*48 + gg];
  end
endgenerate



endmodule	
