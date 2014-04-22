// Run time is ??? ns

`timescale 1ns / 10ps

module tb_combo();
  
  // Inputs
	reg [7:0] PID_in;
    reg [63:0] data_in;
    reg [63:0] encrypted;
    reg [15:0] CRC_in;
    reg [15:0] CRC16_out;
    reg CRC_done;
    reg [2:0] data_sel;
  
  // Outputs
  reg ready;
  reg [87:0] shift_data;
  
  combo DUT(.PID_in(PID_in),.data_in(data_in),.encrypted(encrypted),.CRC_in(CRC_in),.CRC16_out(CRC16_out),.CRC_done(CRC_done),.data_sel(data_sel),.ready(ready),.shift_data(shift_data));
            
initial begin

    data_sel = 3'b100;
    PID_in = 8'd37;
    data_in = 64'd12341;
    encrypted = 64'd3333;
    CRC_in = 16'd92;
    CRC16_out = 16'd443;
    CRC_done = 1'b1;
    
    #100;
    
    data_sel = 3'b011;
    PID_in = 8'd37;
    data_in = 64'd12341;
    encrypted = 64'd3333;
    CRC_in = 16'd92;
    CRC16_out = 16'd443;
    CRC_done = 1'b1;
    
    #100;
    
    data_sel = 3'b010;
    PID_in = 8'd37;
    data_in = 64'd12341;
    encrypted = 64'd3333;
    CRC_in = 16'd92;
    CRC16_out = 16'd443;
    CRC_done = 1'b1;
    
    #100;
    
    data_sel = 3'b001;
    PID_in = 8'd37;
    data_in = 64'd12341;
    encrypted = 64'd3333;
    CRC_in = 16'd92;
    CRC16_out = 16'd443;
    CRC_done = 1'b1;
    
    #100;


end
  
  
endmodule
