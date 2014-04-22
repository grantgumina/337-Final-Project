// $Id: $
// File name:   fix_order.sv
// Created:     4/10/2013
// Author:      Kyle Brockhoff
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Fixes the order of several bit registers

module fix_order (
	input wire [7:0] PID_in,
	input wire [63:0] data_in,
	input wire [15:0] crc16_in,
	output wire [7:0] PID_fixed,
	output wire [63:0] data_fixed,
	output wire [15:0] crc16_fixed
);

assign PID_fixed[0] = PID_in[7];
assign PID_fixed[1] = PID_in[6];
assign PID_fixed[2] = PID_in[5];
assign PID_fixed[3] = PID_in[4];
assign PID_fixed[4] = PID_in[3];
assign PID_fixed[5] = PID_in[2];
assign PID_fixed[6] = PID_in[1];
assign PID_fixed[7] = PID_in[0];

assign crc16_fixed[0] = crc16_in[15];
assign crc16_fixed[1] = crc16_in[14];
assign crc16_fixed[2] = crc16_in[13];
assign crc16_fixed[3] = crc16_in[12];
assign crc16_fixed[4] = crc16_in[11];
assign crc16_fixed[5] = crc16_in[10];
assign crc16_fixed[6] = crc16_in[9];
assign crc16_fixed[7] = crc16_in[8];
assign crc16_fixed[8] = crc16_in[7];
assign crc16_fixed[9] = crc16_in[6];
assign crc16_fixed[10] = crc16_in[5];
assign crc16_fixed[11] = crc16_in[4];
assign crc16_fixed[12] = crc16_in[3];
assign crc16_fixed[13] = crc16_in[2];
assign crc16_fixed[14] = crc16_in[1];
assign crc16_fixed[15] = crc16_in[0];

assign data_fixed[0] = data_in[63];
assign data_fixed[1] = data_in[62];
assign data_fixed[2] = data_in[61];
assign data_fixed[3] = data_in[60];
assign data_fixed[4] = data_in[59];
assign data_fixed[5] = data_in[58];
assign data_fixed[6] = data_in[57];
assign data_fixed[7] = data_in[56];
assign data_fixed[8] = data_in[55];
assign data_fixed[9] = data_in[54];
assign data_fixed[10] = data_in[53];
assign data_fixed[11] = data_in[52];
assign data_fixed[12] = data_in[51];
assign data_fixed[13] = data_in[50];
assign data_fixed[14] = data_in[49];
assign data_fixed[15] = data_in[48];
assign data_fixed[16] = data_in[47];
assign data_fixed[17] = data_in[46];
assign data_fixed[18] = data_in[45];
assign data_fixed[19] = data_in[44];
assign data_fixed[20] = data_in[43];
assign data_fixed[21] = data_in[42];
assign data_fixed[22] = data_in[41];
assign data_fixed[23] = data_in[40];
assign data_fixed[24] = data_in[39];
assign data_fixed[25] = data_in[38];
assign data_fixed[26] = data_in[37];
assign data_fixed[27] = data_in[36];
assign data_fixed[28] = data_in[35];
assign data_fixed[29] = data_in[34];
assign data_fixed[30] = data_in[33];
assign data_fixed[31] = data_in[32];
assign data_fixed[32] = data_in[31];
assign data_fixed[33] = data_in[30];
assign data_fixed[34] = data_in[29];
assign data_fixed[35] = data_in[28];
assign data_fixed[36] = data_in[27];
assign data_fixed[37] = data_in[26];
assign data_fixed[38] = data_in[25];
assign data_fixed[39] = data_in[24];
assign data_fixed[40] = data_in[23];
assign data_fixed[41] = data_in[22];
assign data_fixed[42] = data_in[21];
assign data_fixed[43] = data_in[20];
assign data_fixed[44] = data_in[19];
assign data_fixed[45] = data_in[18];
assign data_fixed[46] = data_in[17];
assign data_fixed[47] = data_in[16];
assign data_fixed[48] = data_in[15];
assign data_fixed[49] = data_in[14];
assign data_fixed[50] = data_in[13];
assign data_fixed[51] = data_in[12];
assign data_fixed[52] = data_in[11];
assign data_fixed[53] = data_in[10];
assign data_fixed[54] = data_in[9];
assign data_fixed[55] = data_in[8];
assign data_fixed[56] = data_in[7];
assign data_fixed[57] = data_in[6];
assign data_fixed[58] = data_in[5];
assign data_fixed[59] = data_in[4];
assign data_fixed[60] = data_in[3];
assign data_fixed[61] = data_in[2];
assign data_fixed[62] = data_in[1];
assign data_fixed[63] = data_in[0];

endmodule
