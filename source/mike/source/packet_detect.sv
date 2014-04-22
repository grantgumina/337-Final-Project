// $Id: $
// File name:   packet_detect.sv
// Created:     4/16/2013
// Author:      Michael Welling
// Lab Section: 337-03
// Version:     1.0  Initial Design Entry
// Description: USB packet start and stop finder

module packet_detect(
	input wire clk,
	input wire rst,
  input wire shift_enable,
	input wire [1:0] USBdata,
	output wire read_val,
	output wire EOP_found
);

parameter IDLE = 4'd0, EOP1 = 4'd1, EOP2 = 4'd2, EOP3 = 4'd3, EOPFOUND = 4'd4, SYNC1 = 4'd5, SYNC2 = 4'd6, SYNC3 = 4'd7, SYNC4 = 4'd8, SYNC5 = 4'd9, SYNC6 = 4'd10, SYNC7 = 4'd11, SYNC8 = 4'd12, SYNCFOUND = 4'd13, ERROR = 4'd14, EOPFINAL = 4'd15;

reg dv;
reg next_dv;
reg [3:0] curr_state;
reg [3:0] next_state;
reg eop1;
reg eop0;
reg end_found;

assign EOP_found = eop1;

always @ (posedge clk, negedge rst) begin : STATE_REG
	if(1'b0 == rst) begin
		curr_state <= IDLE;
    dv <= 1'b0;
    eop1 <= 1'b0;
    eop0 <= 1'b0;
    
	end else begin
    curr_state <= next_state;
    dv <= next_dv;
    eop1 <= eop0;
    eop0 <= end_found;
	end
end

always @ (curr_state, USBdata, dv, shift_enable) begin
    next_state = curr_state;
    next_dv = dv;
    end_found = eop0;
    case(curr_state)
        IDLE: begin
          end_found = 1'b0;
            if( dv == 1 && shift_enable == 1) begin
                next_state = EOP1;
            end else if( dv == 0 && shift_enable == 1) begin
                next_state = SYNC1;
            end else begin
                next_state = IDLE;
            end
        end
        EOP1: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b00) begin
                next_state = EOP2;
            end else if( shift_enable == 1 && USBdata != 2'b00) begin
                //next_state = ERROR;
                next_state = EOP1;
            end else begin
                next_state = EOP1;
            end                
        end
        EOP2: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b00) begin
                next_state = EOP3;
            end else if( shift_enable == 1 && USBdata != 2'b00) begin
                //next_state = ERROR;
                next_state = EOP2;
            end else begin
                next_state = EOP2;
            end
        end
        EOP3: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b10) begin
                next_state = EOPFOUND;
            end else if( shift_enable == 1 && USBdata != 2'b10) begin
                //next_state = ERROR;
                next_state = EOP3;
            end else begin
                next_state = EOP3;
            end                
        end
        EOPFOUND: begin
            next_dv = 0;
            //EOP_found = 1'b1;
            end_found = 1'b1;
            next_state = EOPFINAL;
        end
        EOPFINAL: begin
            next_dv = 0;
            //EOP_found = 1'b1;
            end_found = 1'b1;
            next_state = IDLE;
        end
        SYNC1: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b01) begin
                next_state = SYNC2;
            end else if( shift_enable == 1 && USBdata != 2'b01) begin
                next_state = SYNC1;
            end else begin
                next_state = SYNC1;
            end
        end
        SYNC2: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b10) begin
                next_state = SYNC3;
            end else if( shift_enable == 1 && USBdata != 2'b10) begin
                next_state = SYNC2;
            end else begin
                next_state = SYNC2;
            end                
        end
        SYNC3: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b01) begin
                next_state = SYNC4;
            end else if( shift_enable == 1 && USBdata != 2'b01) begin
                next_state = SYNC3;
            end else begin
                next_state = SYNC3;
            end                
        end
        SYNC4: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b10) begin
                next_state = SYNC5;
            end else if( shift_enable == 1 && USBdata != 2'b10) begin
                next_state = SYNC4;
            end else begin
                next_state = SYNC4;
            end                
        end
        SYNC5: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b01) begin
                next_state = SYNC6;
            end else if( shift_enable == 1 && USBdata != 2'b01) begin
                next_state = SYNC5;
            end else begin
                next_state = SYNC5;
            end                
        end
        SYNC6: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b10) begin
                next_state = SYNC7;
            end else if( shift_enable == 1 && USBdata != 2'b10) begin
                next_state = SYNC6;
            end else begin
                next_state = SYNC6;
            end                
        end
        SYNC7: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b01) begin
                next_state = SYNC8;
            end else if( shift_enable == 1 && USBdata != 2'b01) begin
                next_state = SYNC7;
            end else begin
                next_state = SYNC7;
            end                
        end
        SYNC8: begin
          end_found = 1'b0;
            if( shift_enable == 1 && USBdata == 2'b01) begin
                next_state = SYNCFOUND;
            end else if( shift_enable == 1 && USBdata != 2'b01) begin
                next_state = SYNC8;
            end else begin
                next_state = SYNC8;
            end
        end
        SYNCFOUND: begin
          end_found = 1'b0;
            next_dv = 1;
            next_state = IDLE;
        end
        ERROR: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

assign read_val = dv;
//assign EOP_found = end_found;

endmodule
	
		
