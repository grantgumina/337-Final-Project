// $Id: $
// File name:   average.sv
// Created:     4/22/2014
// Author:      Jack Hammons
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: This is the file in which there is so many things happening. Such WOW. Many A+.




module average (
	input wire clk, 
	input wire n_rst, 
	input wire addValue,
	input wire [31:0]inputData,
 	output reg averageReady, 
	output wire [31:0]outputData
);


//                        0      1        2            3             4             5        6     7        8       9
typedef enum bit [3:0] {idle, pullOld, pushNew, calcNewAddress, subFromTotal, addToTotal, init, waste1, waste2, waste3} stateType;
stateType currentState;
stateType nextState;


reg [31:0]newValue;
reg [31:0]oldValue;

reg [15:0]oldestAddress;
reg [15:0]next_oldestAddress;


reg [63:0]total; 
reg [63:0]next_total; 



reg [15:0]address; 		
reg [31:0]read_data;	
reg [31:0]write_data;
reg write_enable;
reg read_enable;
integer unsigned last_address;
integer unsigned start_address;
integer unsigned dump_file_number;
integer unsigned init_file_number;
reg verbose;
reg mem_dump;
reg mem_init;
reg mem_clr;




on_chip_sram_wrapper DUT
(
	// Test bench control signals
	.mem_clr(mem_clr),
	.mem_init(mem_init),
	.mem_dump(mem_dump),
	.verbose(verbose),
	.init_file_number(init_file_number),
	.dump_file_number(dump_file_number),
	.start_address(start_address),
	.last_address(last_address),
	// Memory interface signals
	.read_enable(read_enable),
	.write_enable(write_enable),
	.address(address),
	.read_data(read_data),
	.write_data(write_data)	
);








always_ff @ (posedge clk, negedge n_rst)
	begin

	if(1'b0 == n_rst) begin
		currentState <= init;
		oldestAddress <= 0;
		total <= 0;
		//newValue <= 0;
	end else begin
		currentState <= nextState;
		oldestAddress <= next_oldestAddress;
		total <= next_total;
	end
end





always_comb begin
	
	nextState = init;
	
	case(currentState)
		init:
			begin
				nextState = idle;
			end

		idle:
			begin	
				if(addValue == 1) begin
					nextState = pullOld;
				end else begin
					nextState = idle;
				end		
			end

		pullOld:
			begin	
				nextState = waste1;		
			end
		waste1:
			begin
				nextState = pushNew;
			end

		pushNew:
			begin	
				nextState = waste2;		
			end
		
		waste2:
			begin
				nextState = waste3;
			end

		waste3:
			begin
				nextState = calcNewAddress;
			end

		calcNewAddress:
			begin	
				nextState = subFromTotal;	
			end

		subFromTotal:
			begin	
				nextState = addToTotal;	
			end
		
		addToTotal:
			begin
				nextState = idle;
			end

	endcase
end





always_comb begin

      	next_oldestAddress = oldestAddress;
	next_total = total;
	averageReady = 0;
	write_enable = 0;
	read_enable = 0;

	
	if(currentState == init) begin
		next_oldestAddress = 16'b0000000000000000;
		next_total = 0;

		address = 0;		
		write_data = 0;

		last_address = 0;
		start_address = 0;
		dump_file_number = 0;
		init_file_number = 0;
		verbose = 0;
		mem_dump = 0;
		mem_init = 0;
		mem_clr = 0;

	end else if(currentState == idle) begin
		averageReady = 1;
		
	end else if(currentState == pullOld) begin
		newValue = inputData;
		read_enable = 1;
		address = oldestAddress;
		oldValue = read_data;

	end else if(currentState == waste1) begin
		newValue = inputData;
		read_enable = 1;
		address = oldestAddress;
		oldValue = read_data;

	end else if(currentState == pushNew) begin
		write_data = newValue;
		address = oldestAddress;
		write_enable = 1;

	end else if(currentState == waste2) begin
		write_data = newValue;
		address = oldestAddress;
		write_enable = 1;

	end else if(currentState == waste3) begin		

	
	end else if(currentState == calcNewAddress) begin
		if(oldestAddress == 252) begin
			next_oldestAddress = 0;
		end else begin
			next_oldestAddress = oldestAddress + 4;
		end

	end else if(currentState == subFromTotal) begin
		next_total = total - oldValue; //needs fix

	end else if(currentState == addToTotal) begin
		next_total = total + newValue; //needs fix
	end else begin
		next_oldestAddress = 0;
	end


end //end always

assign outputData = total[37:6];
//assign outputData = oldestAddress;


endmodule
