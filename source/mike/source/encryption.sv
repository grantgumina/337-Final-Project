// $Id: $
// File name:   encyryption.sv
// Created:     4/10/2013
// Author:      Kyle Brockhoff
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: Encryption/Decryption module

module encryption (
	input wire clk,
	input wire mode,
	input wire EOP_flag,
	input wire [47:0] in_key00,
	input wire [47:0] in_key01,
	input wire [47:0] in_key02,
	input wire [47:0] in_key03,
	input wire [47:0] in_key04,
	input wire [47:0] in_key05,
	input wire [47:0] in_key06,
	input wire [47:0] in_key07,
	input wire [47:0] in_key08,
	input wire [47:0] in_key09,
	input wire [47:0] in_key10,
	input wire [47:0] in_key11,
	input wire [47:0] in_key12,
	input wire [47:0] in_key13,
	input wire [47:0] in_key14,
	input wire [47:0] in_key15,
	input wire [63:0] in_data,
	output reg [63:0] out_data,
	input wire encrypt_done
);
reg [63:0] data;
wire [31:0] LE00;
wire [31:0] RE00;
wire [31:0] LE01;
wire [31:0] RE01;
wire [31:0] LE02;
wire [31:0] RE02;
wire [31:0] LE03;
wire [31:0] RE03;
wire [31:0] LE04;
wire [31:0] RE04;
wire [31:0] LE05;
wire [31:0] RE05;
wire [31:0] LE06;
wire [31:0] RE06;
wire [31:0] LE07;
wire [31:0] RE07;
wire [31:0] LE08;
wire [31:0] RE08;
wire [31:0] LE09;
wire [31:0] RE09;
wire [31:0] LE10;
wire [31:0] RE10;
wire [31:0] LE11;
wire [31:0] RE11;
wire [31:0] LE12;
wire [31:0] RE12;
wire [31:0] LE13;
wire [31:0] RE13;
wire [31:0] LE14;
wire [31:0] RE14;
wire [31:0] LE15;
wire [31:0] RE15;
wire [31:0] LE16;
wire [31:0] RE16;
wire [31:0] out00;
wire [31:0] out01;
wire [31:0] out02;
wire [31:0] out03;
wire [31:0] out04;
wire [31:0] out05;
wire [31:0] out06;
wire [31:0] out07;
wire [31:0] out08;
wire [31:0] out09;
wire [31:0] out10;
wire [31:0] out11;
wire [31:0] out12;
wire [31:0] out13;
wire [31:0] out14;
wire [31:0] out15;
wire [63:0] out16;
reg [31:0] RE02_reg;
reg [31:0] RE04_reg;
reg [31:0] RE06_reg;
reg [31:0] RE08_reg;
reg [31:0] RE10_reg;
reg [31:0] RE12_reg;
reg [31:0] RE14_reg;
wire [47:0] key00;
wire [47:0] key01;
wire [47:0] key02;
wire [47:0] key03;
wire [47:0] key04;
wire [47:0] key05;
wire [47:0] key06;
wire [47:0] key07;
wire [47:0] key08;
wire [47:0] key09;
wire [47:0] key10;
wire [47:0] key11;
wire [47:0] key12;
wire [47:0] key13;
wire [47:0] key14;
wire [47:0] key15;

always @ (EOP_flag, data, in_data)
begin
  if(EOP_flag == 1'b1) begin
    data = in_data;
  end else begin
    data = data;
  end
end

always @ (encrypt_done)
begin
  if(encrypt_done == 1'b1) begin
    out_data = out16;
  end else begin
    //out = out;
    out_data = 64'd0;
  end  
end

always @ (posedge clk)
begin
    RE02_reg = RE02;
    RE04_reg = RE04;
    RE06_reg = RE06;
    RE08_reg = RE08;
    RE10_reg = RE10;
    RE12_reg = RE12;
    RE14_reg = RE14;
end

assign key00 = (mode == 1'b1 ? in_key00 : in_key15);
assign key01 = (mode == 1'b1 ? in_key01 : in_key14);
assign key02 = (mode == 1'b1 ? in_key02 : in_key13);
assign key03 = (mode == 1'b1 ? in_key03 : in_key12);
assign key04 = (mode == 1'b1 ? in_key04 : in_key11);
assign key05 = (mode == 1'b1 ? in_key05 : in_key10);
assign key06 = (mode == 1'b1 ? in_key06 : in_key09);
assign key07 = (mode == 1'b1 ? in_key07 : in_key08);
assign key08 = (mode == 1'b1 ? in_key08 : in_key07);
assign key09 = (mode == 1'b1 ? in_key09 : in_key06);
assign key10 = (mode == 1'b1 ? in_key10 : in_key05);
assign key11 = (mode == 1'b1 ? in_key11 : in_key04);
assign key12 = (mode == 1'b1 ? in_key12 : in_key03);
assign key13 = (mode == 1'b1 ? in_key13 : in_key02);
assign key14 = (mode == 1'b1 ? in_key14 : in_key01);
assign key15 = (mode == 1'b1 ? in_key15 : in_key00);

initperm P0(.data(data),.LE(LE00),.RE(RE00));

feistel F00(.in_data(RE00),.out_data(out00),.key(key00));
assign LE01 = RE00;
assign RE01 = LE00 ^ out00;

feistel F01(.in_data(RE01),.out_data(out01),.key(key01));
assign LE02 = RE01;
assign RE02 = LE01 ^ out01;
	
feistel F02(.in_data(RE02_reg),.out_data(out02),.key(key02));
assign LE03 = RE02;
assign RE03 = LE02 ^ out02;

feistel F03(.in_data(RE03),.out_data(out03),.key(key03));
assign LE04 = RE03;
assign RE04 = LE03 ^ out03;
	
feistel F04(.in_data(RE04_reg),.out_data(out04),.key(key04));
assign LE05 = RE04;
assign RE05 = LE04 ^ out04;
	
feistel F05(.in_data(RE05),.out_data(out05),.key(key05));
assign LE06 = RE05;
assign RE06 = LE05 ^ out05;
	
feistel F06(.in_data(RE06_reg),.out_data(out06),.key(key06));
assign LE07 = RE06;
assign RE07 = LE06 ^ out06;
	
feistel F07(.in_data(RE07),.out_data(out07),.key(key07));
assign LE08 = RE07;
assign RE08 = LE07 ^ out07;
	
feistel F08(.in_data(RE08_reg),.out_data(out08),.key(key08));
assign LE09 = RE08;
assign RE09 = LE08 ^ out08;
	
feistel F09(.in_data(RE09),.out_data(out09),.key(key09));
assign LE10 = RE09;
assign RE10 = LE09 ^ out09;
	
feistel F10(.in_data(RE10_reg),.out_data(out10),.key(key10));
assign LE11 = RE10;
assign RE11 = LE10 ^ out10;
	
feistel F11(.in_data(RE11),.out_data(out11),.key(key11));
assign LE12 = RE11;
assign RE12 = LE11 ^ out11;
	
feistel F12(.in_data(RE12_reg),.out_data(out12),.key(key12));
assign LE13 = RE12;
assign RE13 = LE12 ^ out12;
	
feistel F13(.in_data(RE13),.out_data(out13),.key(key13));
assign LE14 = RE13;
assign RE14 = LE13 ^ out13;
	
feistel F14(.in_data(RE14_reg),.out_data(out14),.key(key14));
assign LE15 = RE14;
assign RE15 = LE14 ^ out14;
	
feistel F15(.in_data(RE15),.out_data(out15),.key(key15));
assign LE16 = RE15;
assign RE16 = LE15 ^ out15;

finalperm P1(.data({RE16,LE16}),.out_data(out16));

endmodule


module feistel (
	input wire [47:0] key,
	input wire [31:0] in_data,
	output wire [31:0] out_data
);

wire [47:0] EtoXOR;
wire [47:0] XORtoSUB;
wire [31:0] SUBtoP;

ebox E1(.data_block(in_data),.expanded(EtoXOR));
assign XORtoSUB = EtoXOR ^ key;
sbox1 S1(.addr(XORtoSUB[47:42]),.out_data(SUBtoP[31:28]));
sbox2 S2(.addr(XORtoSUB[41:36]),.out_data(SUBtoP[27:24]));
sbox3 S3(.addr(XORtoSUB[35:30]),.out_data(SUBtoP[23:20]));
sbox4 S4(.addr(XORtoSUB[29:24]),.out_data(SUBtoP[19:16]));
sbox5 S5(.addr(XORtoSUB[23:18]),.out_data(SUBtoP[15:12]));
sbox6 S6(.addr(XORtoSUB[17:12]),.out_data(SUBtoP[11:8]));
sbox7 S7(.addr(XORtoSUB[11:6]),.out_data(SUBtoP[7:4]));
sbox8 S8(.addr(XORtoSUB[5:0]),.out_data(SUBtoP[3:0]));
pbox P1(.data_block(SUBtoP),.mixed(out_data));

endmodule

module initperm (
	input wire [63:0] data,
	output wire [31:0] LE,
	output wire [31:0] RE
);

assign LE[31] = data[6];
assign LE[30] = data[14];
assign LE[29] = data[22];
assign LE[28] = data[30];
assign LE[27] = data[38];
assign LE[26] = data[46];
assign LE[25] = data[54];
assign LE[24] = data[62];
assign LE[23] = data[4];
assign LE[22] = data[12];
assign LE[21] = data[20];
assign LE[20] = data[28];
assign LE[19] = data[36];
assign LE[18] = data[44];
assign LE[17] = data[52];
assign LE[16] = data[60];
assign LE[15] = data[2];
assign LE[14] = data[10];
assign LE[13] = data[18];
assign LE[12] = data[26];
assign LE[11] = data[34];
assign LE[10] = data[42];
assign LE[9] = data[50];
assign LE[8] = data[58];
assign LE[7] = data[0];
assign LE[6] = data[8];
assign LE[5] = data[16];
assign LE[4] = data[24];
assign LE[3] = data[32];
assign LE[2] = data[40];
assign LE[1] = data[48];
assign LE[0] = data[56];
assign RE[31] = data[7];
assign RE[30] = data[15];
assign RE[29] = data[23];
assign RE[28] = data[31];
assign RE[27] = data[39];
assign RE[26] = data[47];
assign RE[25] = data[55];
assign RE[24] = data[63];
assign RE[23] = data[5];
assign RE[22] = data[13];
assign RE[21] = data[21];
assign RE[20] = data[29];
assign RE[19] = data[37];
assign RE[18] = data[45];
assign RE[17] = data[53];
assign RE[16] = data[61];
assign RE[15] = data[3];
assign RE[14] = data[11];
assign RE[13] = data[19];
assign RE[12] = data[27];
assign RE[11] = data[35];
assign RE[10] = data[43];
assign RE[9] = data[51];
assign RE[8] = data[59];
assign RE[7] = data[1];
assign RE[6] = data[9];
assign RE[5] = data[17];
assign RE[4] = data[25];
assign RE[3] = data[33];
assign RE[2] = data[41];
assign RE[1] = data[49];
assign RE[0] = data[57];

endmodule

module finalperm (
  input wire [63:0] data,
	output wire [63:0] out_data
);

assign out_data[63] = data[24];
assign out_data[62] = data[56];
assign out_data[61] = data[16];
assign out_data[60] = data[48];
assign out_data[59] = data[8];
assign out_data[58] = data[40];
assign out_data[57] = data[0];
assign out_data[56] = data[32];
assign out_data[55] = data[25];
assign out_data[54] = data[57];
assign out_data[53] = data[17];
assign out_data[52] = data[49];
assign out_data[51] = data[9];
assign out_data[50] = data[41];
assign out_data[49] = data[1];
assign out_data[48] = data[33];
assign out_data[47] = data[26];
assign out_data[46] = data[58];
assign out_data[45] = data[18];
assign out_data[44] = data[50];
assign out_data[43] = data[10];
assign out_data[42] = data[42];
assign out_data[41] = data[2];
assign out_data[40] = data[34];
assign out_data[39] = data[27];
assign out_data[38] = data[59];
assign out_data[37] = data[19];
assign out_data[36] = data[51];
assign out_data[35] = data[11];
assign out_data[34] = data[43];
assign out_data[33] = data[3];
assign out_data[32] = data[35];
assign out_data[31] = data[28];
assign out_data[30] = data[60];
assign out_data[29] = data[20];
assign out_data[28] = data[52];
assign out_data[27] = data[12];
assign out_data[26] = data[44];
assign out_data[25] = data[4];
assign out_data[24] = data[36];
assign out_data[23] = data[29];
assign out_data[22] = data[61];
assign out_data[21] = data[21];
assign out_data[20] = data[53];
assign out_data[19] = data[13];
assign out_data[18] = data[45];
assign out_data[17] = data[5];
assign out_data[16] = data[37];
assign out_data[15] = data[30];
assign out_data[14] = data[62];
assign out_data[13] = data[22];
assign out_data[12] = data[54];
assign out_data[11] = data[14];
assign out_data[10] = data[46];
assign out_data[9] = data[6];
assign out_data[8] = data[38];
assign out_data[7] = data[31];
assign out_data[6] = data[63];
assign out_data[5] = data[23];
assign out_data[4] = data[55];
assign out_data[3] = data[15];
assign out_data[2] = data[47];
assign out_data[1] = data[7];
assign out_data[0] = data[39];

endmodule

module ebox (
	input wire [31:0] data_block,
	output wire [47:0] expanded
);

assign expanded[47] = data_block[0];
assign expanded[46] = data_block[31];
assign expanded[45] = data_block[30];
assign expanded[44] = data_block[29];
assign expanded[43] = data_block[28];
assign expanded[42] = data_block[27];
assign expanded[41] = data_block[28];
assign expanded[40] = data_block[27];
assign expanded[39] = data_block[26];
assign expanded[38] = data_block[25];
assign expanded[37] = data_block[24];
assign expanded[36] = data_block[23];
assign expanded[35] = data_block[24];
assign expanded[34] = data_block[23];
assign expanded[33] = data_block[22];
assign expanded[32] = data_block[21];
assign expanded[31] = data_block[20];
assign expanded[30] = data_block[19];
assign expanded[29] = data_block[20];
assign expanded[28] = data_block[19];
assign expanded[27] = data_block[18];
assign expanded[26] = data_block[17];
assign expanded[25] = data_block[16];
assign expanded[24] = data_block[15];
assign expanded[23] = data_block[16];
assign expanded[22] = data_block[15];
assign expanded[21] = data_block[14];
assign expanded[20] = data_block[13];
assign expanded[19] = data_block[12];
assign expanded[18] = data_block[11];
assign expanded[17] = data_block[12];
assign expanded[16] = data_block[11];
assign expanded[15] = data_block[10];
assign expanded[14] = data_block[9];
assign expanded[13] = data_block[8];
assign expanded[12] = data_block[7];
assign expanded[11] = data_block[8];
assign expanded[10] = data_block[7];
assign expanded[9] = data_block[6];
assign expanded[8] = data_block[5];
assign expanded[7] = data_block[4];
assign expanded[6] = data_block[3];
assign expanded[5] = data_block[4];
assign expanded[4] = data_block[3];
assign expanded[3] = data_block[2];
assign expanded[2] = data_block[1];
assign expanded[1] = data_block[0];
assign expanded[0] = data_block[31];

endmodule

module pbox (
	input wire [31:0] data_block,
	output wire [31:0] mixed	
);

assign mixed[31] = data_block[16];
assign mixed[30] = data_block[25];
assign mixed[29] = data_block[12];
assign mixed[28] = data_block[11];
assign mixed[27] = data_block[3];
assign mixed[26] = data_block[20];
assign mixed[25] = data_block[4];
assign mixed[24] = data_block[15];
assign mixed[23] = data_block[31];
assign mixed[22] = data_block[17];
assign mixed[21] = data_block[9];
assign mixed[20] = data_block[6];
assign mixed[19] = data_block[27];
assign mixed[18] = data_block[14];
assign mixed[17] = data_block[1];
assign mixed[16] = data_block[22];
assign mixed[15] = data_block[30];
assign mixed[14] = data_block[24];
assign mixed[13] = data_block[8];
assign mixed[12] = data_block[18];
assign mixed[11] = data_block[0];
assign mixed[10] = data_block[5];
assign mixed[9] = data_block[29];
assign mixed[8] = data_block[23];
assign mixed[7] = data_block[13];
assign mixed[6] = data_block[19];
assign mixed[5] = data_block[2];
assign mixed[4] = data_block[26];
assign mixed[3] = data_block[10];
assign mixed[2] = data_block[21];
assign mixed[1] = data_block[28];
assign mixed[0] = data_block[7];

endmodule

module sbox1 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd14;
		6'b000010: out_data = 4'd4;
		6'b000100: out_data = 4'd13;
		6'b000110: out_data = 4'd1;
		6'b001000: out_data = 4'd2;
		6'b001010: out_data = 4'd15;
		6'b001100: out_data = 4'd11;
		6'b001110: out_data = 4'd8;
		6'b010000: out_data = 4'd3;
		6'b010010: out_data = 4'd10;
		6'b010100: out_data = 4'd6;
		6'b010110: out_data = 4'd12;
		6'b011000: out_data = 4'd5;
		6'b011010: out_data = 4'd9;
		6'b011100: out_data = 4'd0;
		6'b011110: out_data = 4'd7;
		6'b000001: out_data = 4'd0;
		6'b000011: out_data = 4'd15;
		6'b000101: out_data = 4'd7;
		6'b000111: out_data = 4'd4;
		6'b001001: out_data = 4'd14;
		6'b001011: out_data = 4'd2;
		6'b001101: out_data = 4'd13;
		6'b001111: out_data = 4'd1;
		6'b010001: out_data = 4'd10;
		6'b010011: out_data = 4'd6;
		6'b010101: out_data = 4'd12;
		6'b010111: out_data = 4'd11;
		6'b011001: out_data = 4'd9;
		6'b011011: out_data = 4'd5;
		6'b011101: out_data = 4'd3;
		6'b011111: out_data = 4'd8;
		6'b100000: out_data = 4'd4;
		6'b100010: out_data = 4'd1;
		6'b100100: out_data = 4'd14;
		6'b100110: out_data = 4'd8;
		6'b101000: out_data = 4'd13;
		6'b101010: out_data = 4'd6;
		6'b101100: out_data = 4'd2;
		6'b101110: out_data = 4'd11;
		6'b110000: out_data = 4'd15;
		6'b110010: out_data = 4'd12;
		6'b110100: out_data = 4'd9;
		6'b110110: out_data = 4'd7;
		6'b111000: out_data = 4'd3;
		6'b111010: out_data = 4'd10;
		6'b111100: out_data = 4'd5;
		6'b111110: out_data = 4'd0;
		6'b100001: out_data = 4'd15;
		6'b100011: out_data = 4'd12;
		6'b100101: out_data = 4'd8;
		6'b100111: out_data = 4'd2;
		6'b101001: out_data = 4'd4;
		6'b101011: out_data = 4'd9;
		6'b101101: out_data = 4'd1;
		6'b101111: out_data = 4'd7;
		6'b110001: out_data = 4'd5;
		6'b110011: out_data = 4'd11;
		6'b110101: out_data = 4'd3;
		6'b110111: out_data = 4'd14;
		6'b111001: out_data = 4'd10;
		6'b111011: out_data = 4'd0;
		6'b111101: out_data = 4'd6;
		6'b111111: out_data = 4'd13;
	endcase
end
endmodule


module sbox2 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd15;
		6'b000010: out_data = 4'd1;
		6'b000100: out_data = 4'd8;
		6'b000110: out_data = 4'd14;
		6'b001000: out_data = 4'd6;
		6'b001010: out_data = 4'd11;
		6'b001100: out_data = 4'd3;
		6'b001110: out_data = 4'd4;
		6'b010000: out_data = 4'd9;
		6'b010010: out_data = 4'd7;
		6'b010100: out_data = 4'd2;
		6'b010110: out_data = 4'd13;
		6'b011000: out_data = 4'd12;
		6'b011010: out_data = 4'd0;
		6'b011100: out_data = 4'd5;
		6'b011110: out_data = 4'd10;
		6'b000001: out_data = 4'd3;
		6'b000011: out_data = 4'd13;
		6'b000101: out_data = 4'd4;
		6'b000111: out_data = 4'd7;
		6'b001001: out_data = 4'd15;
		6'b001011: out_data = 4'd2;
		6'b001101: out_data = 4'd8;
		6'b001111: out_data = 4'd14;
		6'b010001: out_data = 4'd12;
		6'b010011: out_data = 4'd0;
		6'b010101: out_data = 4'd1;
		6'b010111: out_data = 4'd10;
		6'b011001: out_data = 4'd6;
		6'b011011: out_data = 4'd9;
		6'b011101: out_data = 4'd11;
		6'b011111: out_data = 4'd5;
		6'b100000: out_data = 4'd0;
		6'b100010: out_data = 4'd14;
		6'b100100: out_data = 4'd7;
		6'b100110: out_data = 4'd11;
		6'b101000: out_data = 4'd10;
		6'b101010: out_data = 4'd4;
		6'b101100: out_data = 4'd13;
		6'b101110: out_data = 4'd1;
		6'b110000: out_data = 4'd5;
		6'b110010: out_data = 4'd8;
		6'b110100: out_data = 4'd12;
		6'b110110: out_data = 4'd6;
		6'b111000: out_data = 4'd9;
		6'b111010: out_data = 4'd3;
		6'b111100: out_data = 4'd2;
		6'b111110: out_data = 4'd15;
		6'b100001: out_data = 4'd13;
		6'b100011: out_data = 4'd8;
		6'b100101: out_data = 4'd10;
		6'b100111: out_data = 4'd1;
		6'b101001: out_data = 4'd3;
		6'b101011: out_data = 4'd15;
		6'b101101: out_data = 4'd4;
		6'b101111: out_data = 4'd2;
		6'b110001: out_data = 4'd11;
		6'b110011: out_data = 4'd6;
		6'b110101: out_data = 4'd7;
		6'b110111: out_data = 4'd12;
		6'b111001: out_data = 4'd0;
		6'b111011: out_data = 4'd5;
		6'b111101: out_data = 4'd14;
		6'b111111: out_data = 4'd9;
	endcase
end
endmodule


module sbox3 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd10;
		6'b000010: out_data = 4'd0;
		6'b000100: out_data = 4'd9;
		6'b000110: out_data = 4'd14;
		6'b001000: out_data = 4'd6;
		6'b001010: out_data = 4'd3;
		6'b001100: out_data = 4'd15;
		6'b001110: out_data = 4'd5;
		6'b010000: out_data = 4'd1;
		6'b010010: out_data = 4'd13;
		6'b010100: out_data = 4'd12;
		6'b010110: out_data = 4'd7;
		6'b011000: out_data = 4'd11;
		6'b011010: out_data = 4'd4;
		6'b011100: out_data = 4'd2;
		6'b011110: out_data = 4'd8;
		6'b000001: out_data = 4'd13;
		6'b000011: out_data = 4'd7;
		6'b000101: out_data = 4'd0;
		6'b000111: out_data = 4'd9;
		6'b001001: out_data = 4'd3;
		6'b001011: out_data = 4'd4;
		6'b001101: out_data = 4'd6;
		6'b001111: out_data = 4'd10;
		6'b010001: out_data = 4'd2;
		6'b010011: out_data = 4'd8;
		6'b010101: out_data = 4'd5;
		6'b010111: out_data = 4'd14;
		6'b011001: out_data = 4'd12;
		6'b011011: out_data = 4'd11;
		6'b011101: out_data = 4'd15;
		6'b011111: out_data = 4'd1;
		6'b100000: out_data = 4'd13;
		6'b100010: out_data = 4'd6;
		6'b100100: out_data = 4'd4;
		6'b100110: out_data = 4'd9;
		6'b101000: out_data = 4'd8;
		6'b101010: out_data = 4'd15;
		6'b101100: out_data = 4'd3;
		6'b101110: out_data = 4'd0;
		6'b110000: out_data = 4'd11;
		6'b110010: out_data = 4'd1;
		6'b110100: out_data = 4'd2;
		6'b110110: out_data = 4'd12;
		6'b111000: out_data = 4'd5;
		6'b111010: out_data = 4'd10;
		6'b111100: out_data = 4'd14;
		6'b111110: out_data = 4'd7;
		6'b100001: out_data = 4'd1;
		6'b100011: out_data = 4'd10;
		6'b100101: out_data = 4'd13;
		6'b100111: out_data = 4'd0;
		6'b101001: out_data = 4'd6;
		6'b101011: out_data = 4'd9;
		6'b101101: out_data = 4'd8;
		6'b101111: out_data = 4'd7;
		6'b110001: out_data = 4'd4;
		6'b110011: out_data = 4'd15;
		6'b110101: out_data = 4'd14;
		6'b110111: out_data = 4'd3;
		6'b111001: out_data = 4'd11;
		6'b111011: out_data = 4'd5;
		6'b111101: out_data = 4'd2;
		6'b111111: out_data = 4'd12;
	endcase
end
endmodule


module sbox4 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd7;
		6'b000010: out_data = 4'd13;
		6'b000100: out_data = 4'd14;
		6'b000110: out_data = 4'd3;
		6'b001000: out_data = 4'd0;
		6'b001010: out_data = 4'd6;
		6'b001100: out_data = 4'd9;
		6'b001110: out_data = 4'd10;
		6'b010000: out_data = 4'd1;
		6'b010010: out_data = 4'd2;
		6'b010100: out_data = 4'd8;
		6'b010110: out_data = 4'd5;
		6'b011000: out_data = 4'd11;
		6'b011010: out_data = 4'd12;
		6'b011100: out_data = 4'd4;
		6'b011110: out_data = 4'd15;
		6'b000001: out_data = 4'd13;
		6'b000011: out_data = 4'd8;
		6'b000101: out_data = 4'd11;
		6'b000111: out_data = 4'd5;
		6'b001001: out_data = 4'd6;
		6'b001011: out_data = 4'd15;
		6'b001101: out_data = 4'd0;
		6'b001111: out_data = 4'd3;
		6'b010001: out_data = 4'd4;
		6'b010011: out_data = 4'd7;
		6'b010101: out_data = 4'd2;
		6'b010111: out_data = 4'd12;
		6'b011001: out_data = 4'd1;
		6'b011011: out_data = 4'd10;
		6'b011101: out_data = 4'd14;
		6'b011111: out_data = 4'd9;
		6'b100000: out_data = 4'd10;
		6'b100010: out_data = 4'd6;
		6'b100100: out_data = 4'd9;
		6'b100110: out_data = 4'd0;
		6'b101000: out_data = 4'd12;
		6'b101010: out_data = 4'd11;
		6'b101100: out_data = 4'd7;
		6'b101110: out_data = 4'd13;
		6'b110000: out_data = 4'd15;
		6'b110010: out_data = 4'd1;
		6'b110100: out_data = 4'd3;
		6'b110110: out_data = 4'd14;
		6'b111000: out_data = 4'd5;
		6'b111010: out_data = 4'd2;
		6'b111100: out_data = 4'd8;
		6'b111110: out_data = 4'd4;
		6'b100001: out_data = 4'd3;
		6'b100011: out_data = 4'd15;
		6'b100101: out_data = 4'd0;
		6'b100111: out_data = 4'd6;
		6'b101001: out_data = 4'd10;
		6'b101011: out_data = 4'd1;
		6'b101101: out_data = 4'd13;
		6'b101111: out_data = 4'd8;
		6'b110001: out_data = 4'd9;
		6'b110011: out_data = 4'd4;
		6'b110101: out_data = 4'd5;
		6'b110111: out_data = 4'd11;
		6'b111001: out_data = 4'd12;
		6'b111011: out_data = 4'd7;
		6'b111101: out_data = 4'd2;
		6'b111111: out_data = 4'd14;
	endcase
end
endmodule


module sbox5 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd2;
		6'b000010: out_data = 4'd12;
		6'b000100: out_data = 4'd4;
		6'b000110: out_data = 4'd1;
		6'b001000: out_data = 4'd7;
		6'b001010: out_data = 4'd10;
		6'b001100: out_data = 4'd11;
		6'b001110: out_data = 4'd6;
		6'b010000: out_data = 4'd8;
		6'b010010: out_data = 4'd5;
		6'b010100: out_data = 4'd3;
		6'b010110: out_data = 4'd15;
		6'b011000: out_data = 4'd13;
		6'b011010: out_data = 4'd0;
		6'b011100: out_data = 4'd14;
		6'b011110: out_data = 4'd9;
		6'b000001: out_data = 4'd14;
		6'b000011: out_data = 4'd11;
		6'b000101: out_data = 4'd2;
		6'b000111: out_data = 4'd12;
		6'b001001: out_data = 4'd4;
		6'b001011: out_data = 4'd7;
		6'b001101: out_data = 4'd13;
		6'b001111: out_data = 4'd1;
		6'b010001: out_data = 4'd5;
		6'b010011: out_data = 4'd0;
		6'b010101: out_data = 4'd15;
		6'b010111: out_data = 4'd10;
		6'b011001: out_data = 4'd3;
		6'b011011: out_data = 4'd9;
		6'b011101: out_data = 4'd8;
		6'b011111: out_data = 4'd6;
		6'b100000: out_data = 4'd4;
		6'b100010: out_data = 4'd2;
		6'b100100: out_data = 4'd1;
		6'b100110: out_data = 4'd11;
		6'b101000: out_data = 4'd10;
		6'b101010: out_data = 4'd13;
		6'b101100: out_data = 4'd7;
		6'b101110: out_data = 4'd8;
		6'b110000: out_data = 4'd15;
		6'b110010: out_data = 4'd9;
		6'b110100: out_data = 4'd12;
		6'b110110: out_data = 4'd5;
		6'b111000: out_data = 4'd6;
		6'b111010: out_data = 4'd3;
		6'b111100: out_data = 4'd0;
		6'b111110: out_data = 4'd14;
		6'b100001: out_data = 4'd11;
		6'b100011: out_data = 4'd8;
		6'b100101: out_data = 4'd12;
		6'b100111: out_data = 4'd7;
		6'b101001: out_data = 4'd1;
		6'b101011: out_data = 4'd14;
		6'b101101: out_data = 4'd2;
		6'b101111: out_data = 4'd13;
		6'b110001: out_data = 4'd6;
		6'b110011: out_data = 4'd15;
		6'b110101: out_data = 4'd0;
		6'b110111: out_data = 4'd9;
		6'b111001: out_data = 4'd10;
		6'b111011: out_data = 4'd4;
		6'b111101: out_data = 4'd5;
		6'b111111: out_data = 4'd3;
	endcase
end
endmodule


module sbox6 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd12;
		6'b000010: out_data = 4'd1;
		6'b000100: out_data = 4'd10;
		6'b000110: out_data = 4'd15;
		6'b001000: out_data = 4'd9;
		6'b001010: out_data = 4'd2;
		6'b001100: out_data = 4'd6;
		6'b001110: out_data = 4'd8;
		6'b010000: out_data = 4'd0;
		6'b010010: out_data = 4'd13;
		6'b010100: out_data = 4'd3;
		6'b010110: out_data = 4'd4;
		6'b011000: out_data = 4'd14;
		6'b011010: out_data = 4'd7;
		6'b011100: out_data = 4'd5;
		6'b011110: out_data = 4'd11;
		6'b000001: out_data = 4'd10;
		6'b000011: out_data = 4'd15;
		6'b000101: out_data = 4'd4;
		6'b000111: out_data = 4'd2;
		6'b001001: out_data = 4'd7;
		6'b001011: out_data = 4'd12;
		6'b001101: out_data = 4'd9;
		6'b001111: out_data = 4'd5;
		6'b010001: out_data = 4'd6;
		6'b010011: out_data = 4'd1;
		6'b010101: out_data = 4'd13;
		6'b010111: out_data = 4'd14;
		6'b011001: out_data = 4'd0;
		6'b011011: out_data = 4'd11;
		6'b011101: out_data = 4'd3;
		6'b011111: out_data = 4'd8;
		6'b100000: out_data = 4'd9;
		6'b100010: out_data = 4'd14;
		6'b100100: out_data = 4'd15;
		6'b100110: out_data = 4'd5;
		6'b101000: out_data = 4'd2;
		6'b101010: out_data = 4'd8;
		6'b101100: out_data = 4'd12;
		6'b101110: out_data = 4'd3;
		6'b110000: out_data = 4'd7;
		6'b110010: out_data = 4'd0;
		6'b110100: out_data = 4'd4;
		6'b110110: out_data = 4'd10;
		6'b111000: out_data = 4'd1;
		6'b111010: out_data = 4'd13;
		6'b111100: out_data = 4'd11;
		6'b111110: out_data = 4'd6;
		6'b100001: out_data = 4'd4;
		6'b100011: out_data = 4'd3;
		6'b100101: out_data = 4'd2;
		6'b100111: out_data = 4'd12;
		6'b101001: out_data = 4'd9;
		6'b101011: out_data = 4'd5;
		6'b101101: out_data = 4'd15;
		6'b101111: out_data = 4'd10;
		6'b110001: out_data = 4'd11;
		6'b110011: out_data = 4'd14;
		6'b110101: out_data = 4'd1;
		6'b110111: out_data = 4'd7;
		6'b111001: out_data = 4'd6;
		6'b111011: out_data = 4'd0;
		6'b111101: out_data = 4'd8;
		6'b111111: out_data = 4'd13;
	endcase
end
endmodule


module sbox7 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd4;
		6'b000010: out_data = 4'd11;
		6'b000100: out_data = 4'd2;
		6'b000110: out_data = 4'd14;
		6'b001000: out_data = 4'd15;
		6'b001010: out_data = 4'd0;
		6'b001100: out_data = 4'd8;
		6'b001110: out_data = 4'd13;
		6'b010000: out_data = 4'd3;
		6'b010010: out_data = 4'd12;
		6'b010100: out_data = 4'd9;
		6'b010110: out_data = 4'd7;
		6'b011000: out_data = 4'd5;
		6'b011010: out_data = 4'd10;
		6'b011100: out_data = 4'd6;
		6'b011110: out_data = 4'd1;
		6'b000001: out_data = 4'd13;
		6'b000011: out_data = 4'd0;
		6'b000101: out_data = 4'd11;
		6'b000111: out_data = 4'd7;
		6'b001001: out_data = 4'd4;
		6'b001011: out_data = 4'd9;
		6'b001101: out_data = 4'd1;
		6'b001111: out_data = 4'd10;
		6'b010001: out_data = 4'd14;
		6'b010011: out_data = 4'd3;
		6'b010101: out_data = 4'd5;
		6'b010111: out_data = 4'd12;
		6'b011001: out_data = 4'd2;
		6'b011011: out_data = 4'd15;
		6'b011101: out_data = 4'd8;
		6'b011111: out_data = 4'd6;
		6'b100000: out_data = 4'd1;
		6'b100010: out_data = 4'd4;
		6'b100100: out_data = 4'd11;
		6'b100110: out_data = 4'd13;
		6'b101000: out_data = 4'd12;
		6'b101010: out_data = 4'd3;
		6'b101100: out_data = 4'd7;
		6'b101110: out_data = 4'd14;
		6'b110000: out_data = 4'd10;
		6'b110010: out_data = 4'd15;
		6'b110100: out_data = 4'd6;
		6'b110110: out_data = 4'd8;
		6'b111000: out_data = 4'd0;
		6'b111010: out_data = 4'd5;
		6'b111100: out_data = 4'd9;
		6'b111110: out_data = 4'd2;
		6'b100001: out_data = 4'd6;
		6'b100011: out_data = 4'd11;
		6'b100101: out_data = 4'd13;
		6'b100111: out_data = 4'd8;
		6'b101001: out_data = 4'd1;
		6'b101011: out_data = 4'd4;
		6'b101101: out_data = 4'd10;
		6'b101111: out_data = 4'd7;
		6'b110001: out_data = 4'd9;
		6'b110011: out_data = 4'd5;
		6'b110101: out_data = 4'd0;
		6'b110111: out_data = 4'd15;
		6'b111001: out_data = 4'd14;
		6'b111011: out_data = 4'd2;
		6'b111101: out_data = 4'd3;
		6'b111111: out_data = 4'd12;
	endcase
end
endmodule


module sbox8 (
	input wire [5:0] addr,
	output reg [3:0] out_data
);

always @ (addr) begin
	case(addr)
		6'b000000: out_data = 4'd13;
		6'b000010: out_data = 4'd2;
		6'b000100: out_data = 4'd8;
		6'b000110: out_data = 4'd4;
		6'b001000: out_data = 4'd6;
		6'b001010: out_data = 4'd15;
		6'b001100: out_data = 4'd11;
		6'b001110: out_data = 4'd1;
		6'b010000: out_data = 4'd10;
		6'b010010: out_data = 4'd9;
		6'b010100: out_data = 4'd3;
		6'b010110: out_data = 4'd14;
		6'b011000: out_data = 4'd5;
		6'b011010: out_data = 4'd0;
		6'b011100: out_data = 4'd12;
		6'b011110: out_data = 4'd7;
		6'b000001: out_data = 4'd1;
		6'b000011: out_data = 4'd15;
		6'b000101: out_data = 4'd13;
		6'b000111: out_data = 4'd8;
		6'b001001: out_data = 4'd10;
		6'b001011: out_data = 4'd3;
		6'b001101: out_data = 4'd7;
		6'b001111: out_data = 4'd4;
		6'b010001: out_data = 4'd12;
		6'b010011: out_data = 4'd5;
		6'b010101: out_data = 4'd6;
		6'b010111: out_data = 4'd11;
		6'b011001: out_data = 4'd0;
		6'b011011: out_data = 4'd14;
		6'b011101: out_data = 4'd9;
		6'b011111: out_data = 4'd2;
		6'b100000: out_data = 4'd7;
		6'b100010: out_data = 4'd11;
		6'b100100: out_data = 4'd4;
		6'b100110: out_data = 4'd1;
		6'b101000: out_data = 4'd9;
		6'b101010: out_data = 4'd12;
		6'b101100: out_data = 4'd14;
		6'b101110: out_data = 4'd2;
		6'b110000: out_data = 4'd0;
		6'b110010: out_data = 4'd6;
		6'b110100: out_data = 4'd10;
		6'b110110: out_data = 4'd13;
		6'b111000: out_data = 4'd15;
		6'b111010: out_data = 4'd3;
		6'b111100: out_data = 4'd5;
		6'b111110: out_data = 4'd8;
		6'b100001: out_data = 4'd2;
		6'b100011: out_data = 4'd1;
		6'b100101: out_data = 4'd14;
		6'b100111: out_data = 4'd7;
		6'b101001: out_data = 4'd4;
		6'b101011: out_data = 4'd10;
		6'b101101: out_data = 4'd8;
		6'b101111: out_data = 4'd13;
		6'b110001: out_data = 4'd15;
		6'b110011: out_data = 4'd12;
		6'b110101: out_data = 4'd9;
		6'b110111: out_data = 4'd0;
		6'b111001: out_data = 4'd3;
		6'b111011: out_data = 4'd5;
		6'b111101: out_data = 4'd6;
		6'b111111: out_data = 4'd11;
	endcase
end
endmodule
