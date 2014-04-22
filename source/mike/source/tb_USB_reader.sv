// Run time is ??? ns

`timescale 1ns / 10ps

module tb_USB_reader();
  
  // Inputs
  reg tb_clk;
  reg tb_rst;
  reg [1:0] tb_USBdata;
  
  // Outputs
  reg [7:0] tb_PID_data;
  reg [63:0] tb_data;
  reg [15:0] tb_CRC_data;
  reg tb_EOP_found;
  
  parameter CLK_PERIOD = 10.0/3;
  parameter CRCGOLD = 16'b1110001000110111;
  parameter PIDGOLD = 8'b11000011;
  parameter COMP = 64'b0000000011111111011101111011101100110011110111010101010110011001;
  
  USB_reader DUT(.clk(tb_clk),
                .rst(tb_rst),
                .USBdata(tb_USBdata),
                .PID_data(tb_PID_data),
                .data(tb_data),
                .CRC_data(tb_CRC_data),
                .EOP_found(tb_EOP_found));
            
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
  
initial begin
    // Function reset
    
    $display ("CLK_PERIOD is %f", CLK_PERIOD);
    $display ("Send Reset");
    reset();
    #50;
    $display ("Send Sync");
    send_sync();
    $display ("Send Data");
    send_data();
    $display ("Send EOP");
    send_EOP();
    
    #100
    
    assert(tb_PID_data == PIDGOLD) begin
        $display("PID Data Output Correct");
    end else begin
        $display("Incorrect PID data");
    end
    
    assert(tb_data == COMP) begin
        $display("Data Output Correct");
    end else begin
        $display("Incorrect output data");
    end
    
    assert(tb_CRC_data == CRCGOLD) begin
        $display("CRC Data Output Correct");
    end else begin
        $display("Incorrect CRC data");
    end
    

end
  
  
endmodule
