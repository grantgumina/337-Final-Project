// $Id: $
// File name:   USB_writer.sv
// Created:     4/25/2013
// Author:      Birzhan Nurimbetov
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB Writer
// 

module USB_writer(
  input wire [87:0] data_in,
  input wire ready,
  input wire shift,
  input wire [2:0] data_select,
  input wire clk,
  input wire n_rst,
  output wire [1:0] data_out 
);

typedef enum {IDLE, SYNC, TOKEN, DATA, HAND, SPEC, EOP} state_def;
state_def state, next_state;
reg [6:0] count, next_count;
reg [1:0] data_out_t, data_out_temp;
assign data_out = data_out_temp;
reg val, next_val;


always @(posedge clk, negedge n_rst)
begin

  if (n_rst == 1'b0)
  begin
    state <= IDLE;
    count <= 7'd0;
    data_out_temp <= 2'b10; 
    val <= 1'b0;
  end
  else
  begin
    state <= next_state;
    count <= next_count;
    data_out_temp <= data_out_t;
    val <= next_val;
  end
end

always @(state, ready, count, data_select, shift, val)
begin: StateMachine
     next_state = state;
     next_count = count;
     next_val = val;
     
  case (state)
 
    IDLE: begin
      if (ready == 1'b1 && shift == 1'b1 && val == 1'b0) begin
        next_state = SYNC;
        next_count = 7'd0;
      end
      else begin
        next_state = IDLE;
       	next_count = 7'd0;
        
      end
    end
    SYNC: begin
     
    if (shift == 1'b1) begin
      next_count = count + 1;
      if (count < 7'd7  )
      begin
        next_state = SYNC;
      end
      else begin
        if (data_select == 3'b000)
          next_state = TOKEN;
        else if (data_select == 3'b001)
          next_state = DATA;
        else if (data_select == 3
        'b010)
          next_state = HAND;
        else
          next_state = SPEC;
         next_count = 7'd0;
      end  
    end
  
    end
    TOKEN: begin
      
    if (shift == 1'b1) begin
	   next_count = count + 1;
      if (count < 7'd23)
        next_state = TOKEN;
      else begin
        next_state = EOP;
        next_count = 7'd0;
      end
    end
    end
    DATA: begin
     
    if (shift == 1'b1) begin
	next_count = count + 1;
      if (count < 7'd87)
        next_state = DATA;
      else begin
        next_state = EOP;
        next_count = 7'd0;
      end
    end
    end
    HAND: begin
      
       if (shift == 1'b1) begin
	next_count = count + 1;
      if (count < 7'd7)
        next_state = HAND;
      else begin
        next_state = EOP;
        next_count = 7'd0;
      end
      end
    end
    SPEC: begin
      
       if (shift == 1'b1) begin
	next_count = count + 1;
      if (count < 7'd23)
         next_state = SPEC;
      else begin
        next_state = EOP;
        next_count = 7'd0;
      end
    end
    end
    EOP: begin
    
       if (shift == 1'b1) begin
	next_count = count + 1;
      if (count < 7'd2)
         next_state = EOP;
      else begin
        next_state = IDLE;
        next_val = 1'b1;
        next_count = 7'd0;
      end
    end
    end
    
  endcase
  
end

always @(state,  count, shift, data_in, data_out_temp )
begin: Output
 //    next_count = count;
  data_out_t = data_out_temp;
  case (state)
 
    IDLE: begin
  //      next_count = 7'd0;
        data_out_t = 2'b10;
    end
    SYNC: begin
   //     if (shift == 1'b1)
   //       next_count = count + 1;
   //     else
   //       next_count = count;
          data_out_t = data_out_temp;
        if (count[0] == 1'b0 && count<7'd5)
          data_out_t = 2'b01;
        else if (count[0] == 1'b1 && count<7'd6)
          data_out_t = 2'b10;
        else if (count == 7'd6 || count == 7'd7)
          data_out_t = 2'b01;
      
          
      
          
    end
    TOKEN: begin
      data_out_t = data_out_temp;
    if (shift == 1'b1) begin
  //    next_count = count + 1;
        if (count<=7'd23) begin
          if (data_in[count] == 1'b1)
            data_out_t = data_out_temp;
          else
            data_out_t = ~data_out_temp;
       end  
      
    end
    
    
    
    end
    DATA: begin
     data_out_t = data_out_temp;
    if (shift == 1'b1) begin
  //    next_count =count + 1;
        if (count<=7'd87) begin
          if (data_in[count] == 1'b1)
            data_out_t = data_out_temp;
          else
            data_out_t = ~data_out_temp;
        end
        
          
        end
    end
    
      
   
  
    HAND: begin
      data_out_t = data_out_temp;
    if (shift == 1'b1) begin
  //    next_count =count + 1;
        if (count<=7'd7) begin
          if (data_in[count] == 1'b1)
            data_out_t = data_out_temp;
          else
            data_out_t = ~data_out_temp;
       end  
        
         
        end
    end
   
 
    SPEC: begin
      data_out_t = data_out_temp;
    if (shift==1'b1) begin
 //     next_count =count + 1;
        if (count<=7'd23) begin
          if (data_in[count] == 1'b1)
            data_out_t = data_out_temp;
          else
            data_out_t = ~data_out_temp;
       end  
     
    end
    
 
    end
    EOP: begin
      data_out_t = data_out_temp;
    if (shift == 1'b1) begin
   //  next_count =count + 1;
        if (count <= 7'd3) begin
          data_out_t = 2'b00;
        end
        else begin
          data_out_t = 2'b10;
        end 
    end

    end
    
  endcase

 end
endmodule
