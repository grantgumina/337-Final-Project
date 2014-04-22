// $Id: $
// File name:   PID_chk.sv
// Created:     4/10/2013
// Author:      Tyler Leamon
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: PID checking
//

module PID_chk(
  input reg clk,
  input reg rst,
  input reg [7:0] PID_I,
  input reg EOP_flag,
  output reg [2:0] data_select,
  output reg crc16_enable
  );
    
  always @ (posedge clk, negedge rst) begin
    if(rst == 1'b0) begin
      data_select = 3'b100;
      crc16_enable = 1'b0;
    end else if (EOP_flag) begin
      $display ("Current value of PID_I[3:0] is %b", PID_I[3:0]);
      if((PID_I[3:0] == 4'b0001) || (PID_I[3:0] == 4'b1001) || (PID_I[3:0] == 4'b0101) || (PID_I[3:0] == 4'b1101)) begin
        //TOKEN Packet
        data_select = 3'b000;
        crc16_enable = 1'b0;
      end else if((PID_I[3:0] == 4'b0011) || (PID_I[3:0] == 4'b1011) || (PID_I[3:0] == 4'b0111) || (PID_I[3:0] == 4'b1111)) begin
        //DATA Packet
        data_select = 3'b001;
        crc16_enable = 1'b1;
      end else if((PID_I[3:0] == 4'b0010) || (PID_I[3:0] == 4'b1010) || (PID_I[3:0] == 4'b1110) || (PID_I[3:0] == 4'b0110)) begin
        //HANDSHAKE Packet
        data_select = 3'b010;
        crc16_enable = 1'b0;
      end else if((PID_I[3:0] == 4'b1100) || (PID_I[3:0] == 4'b1000) || (PID_I[3:0] == 4'b0100)) begin
        //SPECIAL Packet
        data_select = 3'b011;
        crc16_enable = 1'b0;
      end else begin
        //Default: Special Packet
        data_select = 3'b100;
        crc16_enable = 1'b0;
      end
      
    end 
     
  end

  

endmodule

		  


