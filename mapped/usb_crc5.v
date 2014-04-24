
module usb_crc5 ( n_rst, clk, data_in, crc_en, crc_out );
  input [7:0] data_in;
  output [4:0] crc_out;
  input n_rst, clk, crc_en;
  wire   n25, n27, n29, n31, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55;

  DFFSR \lfsr_q_reg[0]  ( .D(n33), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        crc_out[0]) );
  DFFSR \lfsr_q_reg[2]  ( .D(n31), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        crc_out[2]) );
  DFFSR \lfsr_q_reg[4]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        crc_out[4]) );
  DFFSR \lfsr_q_reg[3]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        crc_out[3]) );
  DFFSR \lfsr_q_reg[1]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        crc_out[1]) );
  MUX2X1 U35 ( .B(n34), .A(n35), .S(crc_en), .Y(n33) );
  XNOR2X1 U36 ( .A(n36), .B(n37), .Y(n35) );
  MUX2X1 U37 ( .B(n38), .A(n39), .S(crc_en), .Y(n31) );
  XOR2X1 U38 ( .A(n40), .B(n41), .Y(n39) );
  XNOR2X1 U39 ( .A(data_in[2]), .B(n37), .Y(n40) );
  XNOR2X1 U40 ( .A(n42), .B(n43), .Y(n37) );
  XOR2X1 U41 ( .A(data_in[0]), .B(n44), .Y(n43) );
  INVX1 U42 ( .A(n45), .Y(n44) );
  MUX2X1 U43 ( .B(n46), .A(n47), .S(crc_en), .Y(n29) );
  XNOR2X1 U44 ( .A(n48), .B(n49), .Y(n47) );
  XNOR2X1 U45 ( .A(data_in[2]), .B(n36), .Y(n48) );
  XNOR2X1 U46 ( .A(n38), .B(data_in[5]), .Y(n36) );
  INVX1 U47 ( .A(crc_out[2]), .Y(n38) );
  INVX1 U48 ( .A(crc_out[4]), .Y(n46) );
  MUX2X1 U49 ( .B(n50), .A(n51), .S(crc_en), .Y(n27) );
  XOR2X1 U50 ( .A(n42), .B(n52), .Y(n51) );
  XOR2X1 U51 ( .A(n34), .B(data_in[3]), .Y(n42) );
  INVX1 U52 ( .A(crc_out[0]), .Y(n34) );
  MUX2X1 U53 ( .B(n53), .A(n54), .S(crc_en), .Y(n25) );
  XOR2X1 U54 ( .A(n45), .B(n52), .Y(n54) );
  XNOR2X1 U55 ( .A(n49), .B(n55), .Y(n52) );
  XOR2X1 U56 ( .A(data_in[1]), .B(n41), .Y(n55) );
  XOR2X1 U57 ( .A(crc_out[4]), .B(data_in[7]), .Y(n41) );
  XNOR2X1 U58 ( .A(crc_out[1]), .B(data_in[4]), .Y(n49) );
  XOR2X1 U59 ( .A(n50), .B(data_in[6]), .Y(n45) );
  INVX1 U60 ( .A(crc_out[3]), .Y(n50) );
  INVX1 U61 ( .A(crc_out[1]), .Y(n53) );
endmodule

