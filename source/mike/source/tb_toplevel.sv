// Run time is ??? ns

`timescale 1ns / 10ps

module tb_toplevel();
  
  // Inputs
  reg tb_clk;
  reg tb_rst;
  reg [1:0] tb_USBdata;
  reg spi_clk;
  reg spi_data;
  
  
  // Outputs
  reg [1:0] tb_USBout;
  
  integer ii;
  
  parameter CLK_PERIOD = 10.0/3;
  parameter CRCGOLD = 16'b1110001000110111;
  parameter PIDGOLD = 8'b11000011;
  parameter COMP = 64'b0000000011111111011101111011101100110011110111010101010110011001;
  
  toplevel DUT(.clk(tb_clk),
                .rst(tb_rst),
                .spi_clk(spi_clk),
                .spi_serial(spi_data),
                .USBdata(tb_USBdata),
                .USBdata_out(tb_USBout));
            
  always
  begin // system clock is 300 MHz or 3.33 ns per clock cycle
    tb_clk = 1'b0;
    #1667ps;
    tb_clk = 1'b1;
    #1667ps;
  end
  
  // Function for resets
  task reset;
    begin
      // Default values
      tb_rst          = 1'b1;
      tb_USBdata      = 2'b11;
      #100ns;
      tb_rst = 1'b0;
      #100ns;
      tb_rst = 1'b1;
    end
  endtask
  
  task setJ;
    begin
      tb_USBdata = 2'b10;
      #100ns;
    end
  endtask
  
  task setK;
    begin
      tb_USBdata = 2'b01;
      #100ns;
    end
  endtask
  
  task setSE0;
    begin
      tb_USBdata = 2'b00;
      #100ns;
    end
  endtask
  
  task send_sync; // KJKJKJKK
    begin
      #100ns;
      setK();
      setJ();
      setK();
      setJ();
      setK();
      setJ();
      setK();
      setK();
    end
  endtask
  
  task send_EOP; // XXJ
    begin
      setSE0();
      setSE0();
      setJ();
    end
  endtask
  
  task send_data; 
    begin
      //send_sync last sends a setK();
      setK(); //1
      setK(); //1
      setJ(); //0
      setK(); //0
      setJ(); //0
      setK(); //0
      setK(); //1
      setK(); //1
      //END PID
      setK(); //1
      setJ(); //0
      setK(); //0
      setK(); //1
      
      setK(); //1      
      setJ(); //0
      setK(); //0
      setK(); //1
      
      setK(); //1
      setJ(); //0      
      setJ(); //1
      setK(); //0
      
      setK(); //1
      setJ(); //0
      setJ(); //1      
      setK(); //0
      
      setK(); //1
      setJ(); //0
      setJ(); //1
      setJ(); //1 
           
      setJ(); //1
      setK(); //0
      setK(); //1
      setK(); //1
      
      setK(); //1      
      setK(); //1
      setJ(); //0
      setK(); //0
      
      setK(); //1
      setK(); //1      
      setJ(); //0
      setK(); //0
      
      setK(); //1
      setK(); //1
      setJ(); //0      
      setJ(); //1
      
      setJ(); //1
      setJ(); //1
      setK(); //0
      setK(); //1 
           
      setK(); //1
      setK(); //1
      setK(); //1
      setJ(); //0
      
      setJ(); //1      
      setJ(); //1
      setJ(); //1
      setK(); //0
      
      setK(); //1      
      setK(); //1      
      setK(); //1
      setK(); //1
      #1;
      setK(); //1      
      setK(); //1
      setJ(); //GET STUFFED
      setJ(); //1      
      setJ(); //1
      
      setK(); //0
      setJ(); //0
      setK(); //0          
      setJ(); //0
      
      setK(); //0
      setJ(); //0
      setK(); //0
      setJ(); //0     

      //start CRC
      setJ(); //1
      setJ(); //1
      setJ(); //1
      setK(); //0 //error here
      setK(); //1
      setK(); //1
      setJ(); //0
      setK(); //0
      setJ(); //0
      setJ(); //1
      setK(); //0
      setJ(); //0
      setK(); //0
      setK(); //1
      setK(); //1
      setK(); //1
      
    end
  endtask
  
  parameter CLK_PER = (10.0/3)*6; 
   always begin
    spi_clk = 1'b1;
    #(CLK_PER/2);
    spi_clk = 1'b0;
    #(CLK_PER/2);
  end
  
    reg [47:0] key_tran00;
    reg [47:0] key_tran01;
    reg [47:0] key_tran02;
    reg [47:0] key_tran03;
    reg [47:0] key_tran04;
    reg [47:0] key_tran05;
    reg [47:0] key_tran06;
    reg [47:0] key_tran07;
    reg [47:0] key_tran08;
    reg [47:0] key_tran09;
    reg [47:0] key_tran10;
    reg [47:0] key_tran11;
    reg [47:0] key_tran12;
    reg [47:0] key_tran13;
    reg [47:0] key_tran14;
    reg [47:0] key_tran15;

initial begin
    // Function reset
    
    $display ("CLK_PERIOD is %f", CLK_PERIOD);
    $display ("Send Reset");
    reset();
    
    key_tran00 = 48'h38acef46564a;
    key_tran01 = 48'h89bed4489d12;
    key_tran02 = 48'h547eee4d443c;
    key_tran03 = 48'hf2f5604958c8;
    key_tran04 = 48'hc8cf6780d03d;
    key_tran05 = 48'he1f31f831ea4;
    key_tran06 = 48'h2597e3980bb1;
    key_tran07 = 48'hf358f3134a15;
    key_tran08 = 48'h0cda7ba00ac6;
    key_tran09 = 48'ha7795e94a297;
    key_tran10 = 48'h2e6fc13706c1;
    key_tran11 = 48'h5b7d391aa143;
    key_tran12 = 48'hcda5d926e504;
    key_tran13 = 48'h57ce8f6825c2;
    key_tran14 = 48'h7bb982ecc00b;
    key_tran15 = 48'hd33a2d238d68;
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran00[ii];
      #(CLK_PER);
    end
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran01[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran02[ii];
      #(CLK_PER);
    end
  
        for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran03[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran04[ii];
      #(CLK_PER);
    end
    
    key_tran05 = 48'he1f31f831ea4;
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran05[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran06[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran07[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran08[ii];
      #(CLK_PER);
    end
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran09[ii];
      #(CLK_PER);
    end
    
  
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran10[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran11[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran12[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran13[ii];
      #(CLK_PER);
    end
    
   
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran14[ii];
      #(CLK_PER);
    end
    
    
    for (ii = 47; ii >= 0; ii=ii-1)
    begin
      spi_data = key_tran15[ii];
      #(CLK_PER);
    end
      
    #150
    $display ("Send Sync");
    send_sync();
    $display ("Send Data");
    send_data();
    $display ("Send EOP");
    send_EOP();

end
  
  
endmodule
