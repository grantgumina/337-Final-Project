// $Id: $
// File name:   crc16_calc.sv
// Created:     4/10/2013
// Author:      Tyler Leamon
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: CRC checking
//

module crc16_calc(
  input reg clk,
  input reg rst,
  input reg [63:0] crc16_DI,
  input reg enc_done,
  output reg [15:0] crc16_O,
  output reg CRC_done
  );
  //Note: crc16_I is assumed to be 64 bits because of compatibility with DES encryption
  reg crc16_currbit;
  reg [15:0] crc16_result;
  reg [15:0] next_crc16_O;
  reg next_CRC_done;
  
  always @ (posedge clk, negedge rst) begin
    if (rst == 1'b0) begin
      crc16_O = 16'd0;
      CRC_done = 1'b0;
    end else begin
      crc16_O = next_crc16_O;
      CRC_done = next_CRC_done;
    end
  end
  
  always @ (enc_done,crc16_DI ) begin
    if (enc_done == 1'b1) begin
      
      //Initial value
      crc16_result = 16'hFFFF;
      

      crc16_result[15] = crc16_result[14] ^ crc16_DI[0] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[0];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[0] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[1] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[1];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[1] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[2] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[2];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[2] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[3] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[3];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[3] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[4] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[4];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[4] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[5] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[5];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[5] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[6] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[6];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[6] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[7] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[7];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[7] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[8] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[8];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[8] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[9] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[9];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[9] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[10] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[10];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[10] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[11] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[11];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[11] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[12] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[12];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[12] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[13] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[13];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[13] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[14] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[14];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[14] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[15] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[15];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[15] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[16] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[16];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[16] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[17] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[17];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[17] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[18] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[18];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[18] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[19] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[19];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[19] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[20] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[20];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[20] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[21] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[21];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[21] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[22] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[22];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[22] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[23] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[23];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[23] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[24] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[24];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[24] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[25] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[25];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[25] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[26] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[26];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[26] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[27] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[27];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[27] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[28] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[28];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[28] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[29] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[29];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[29] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[30] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[30];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[30] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[31] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[31];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[31] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[32] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[32];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[32] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[33] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[33];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[33] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[34] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[34];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[34] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[35] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[35];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[35] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[36] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[36];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[36] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[37] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[37];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[37] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[38] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[38];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[38] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[39] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[39];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[39] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[40] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[40];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[40] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[41] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[41];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[41] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[42] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[42];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[42] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[43] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[43];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[43] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[44] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[44];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[44] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[45] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[45];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[45] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[46] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[46];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[46] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[47] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[47];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[47] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[48] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[48];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[48] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[49] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[49];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[49] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[50] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[50];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[50] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[51] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[51];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[51] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[52] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[52];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[52] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[53] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[53];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[53] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[54] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[54];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[54] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[55] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[55];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[55] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[56] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[56];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[56] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[57] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[57];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[57] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[58] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[58];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[58] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[59] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[59];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[59] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[60] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[60];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[60] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[61] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[61];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[61] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[62] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[62];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[62] ^ crc16_result[15];
      crc16_result[15] = crc16_result[14] ^ crc16_DI[63] ^ crc16_result[15];
      crc16_result[14:3] = crc16_result[13:2];
      crc16_result[2] = crc16_result[1] ^ crc16_DI[63];
      crc16_result[1] = crc16_result[0];
      crc16_result[0] = crc16_DI[63] ^ crc16_result[15];
      
      next_crc16_O = crc16_result;
      next_CRC_done = 1'b1;
    end else begin
      next_crc16_O = next_crc16_O; 
      next_CRC_done = next_CRC_done; 
    end

  end

endmodule
