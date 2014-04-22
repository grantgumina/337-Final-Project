// $Id: $
// File name:   crc16_chk.sv
// Created:     4/10/2013
// Author:      Tyler Leamon
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: CRC checking
//

module crc16_chk(
  input reg clk,
  input reg rst,
  input reg crc16_enable,
  input reg [15:0] crc16_I,
  input reg [63:0] crc16_DI,
  output reg [15:0] crc16_O,
  output reg crc16_err 
  );
  
  //Note: crc16_I is assumed to be 64 bits because of compatibility with DES encryption
  reg crc16_currbit;
  reg [15:0] crc16_result;
  reg [6:0] bit_index;
  
  always @ (posedge clk, negedge rst) begin
    if (crc16_enable) begin
      crc16_err = 1'b0;
      crc16_O = 16'h0000;
      crc16_result = 16'hFFFF;
      
      for(bit_index = 0; bit_index < 64; bit_index = bit_index + 1) begin
        //Data coming in as if serial
        crc16_currbit = crc16_DI[bit_index];
        
        //Data being processed
        crc16_result[15] = crc16_result[14] ^ crc16_currbit ^ crc16_result[15];
        crc16_result[14:3] = crc16_result[13:2];
        crc16_result[2] = crc16_result[1] ^ crc16_currbit;
        crc16_result[1] = crc16_result[0];
        crc16_result[0] = crc16_currbit ^ crc16_result[15];
      end
      
      $display ("Current value of crc16_result is %b", crc16_result);
        
      if(crc16_result == crc16_I)  begin
        crc16_err = 1'b0;
        crc16_O = crc16_result;
      end else begin
        crc16_err = 1'b1;
        crc16_O = 16'h0000;
      end
        
    end
    
  end

endmodule