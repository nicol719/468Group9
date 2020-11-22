//==================
// Test
// CPU
// By GN
//=================
module _load_instructions;
	wire read_write; // From MAB to RAM
	wire [31:0] data_out; 
	
	reg ram_read_write, Enable;
	reg [31:0] ram_data_in;
	reg [15:0] ram_address;

	//Submodules

	
	memory RAM_CPU(Enable,ram_read_write,ram_address,ram_data_in, data_out);
	
	initial
	begin
	//
	//{condition, op_code, s_bit, destination, source_2_sel, source_1_sel, 11b'0}
	//or
	//{condition, op_code, s_bit, destination, immediate_value, 3b'0}
	Enable = 0; ram_read_write = 0; ram_address = 16'd0; ram_data_in = 32'hAAAA0000;
	// Load R2 with number 5
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd0; ram_data_in = {4'b0, 4'b0110, 1'b0, 4'd2,16'd5, 3'b0};
	// Load R1 with number 22
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd1; ram_data_in = {4'b0, 4'b0110, 1'b0, 4'd1,16'd22, 3'b0};
	// Write R2 to Ram address R1
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd2; ram_data_in = {4'b0, 4'b1110, 1'b0, 4'd0,4'd2,4'd1, 11'b0};
	// Load R3 with number 7
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd3; ram_data_in = {4'b0, 4'b0110, 1'b0, 4'd3,16'd7, 3'b0};
	// Load R4 with R3 + R1
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd4; ram_data_in = {4'b0, 4'b0000, 1'b0, 4'd4,4'd3,4'd2, 11'b0};
	// Load R1 with number 23
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd5; ram_data_in = {4'b0, 4'b0110, 1'b0, 4'd1,16'd23, 3'b0};
	// Write R4 to Ram address R1
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd6; ram_data_in = {4'b0, 4'b1110, 1'b0, 4'd0,4'd4,4'd1, 11'b0};
	// Do Nothing
	#5 Enable = 1; ram_read_write = 0; ram_address = 16'd7; ram_data_in = {4'b0, 4'b1111, 1'b0, 4'd0,4'd2,4'd1, 11'b0};
	#10
	
	$writememb("load_ram.txt", RAM_CPU.Mem);
	end
	
endmodule

module test_CPU_read_ram;
	wire [15:0] address; //From MAB to RAM_CPU
	wire read_write; // From MAB to RAM
	wire [31:0] data_in; // From MAB to RAM
	wire [31:0] data_out; // From RAM to MAB and State Machine

	wire [31:0] source_1; // From RBT to ALU
	wire [31:0] source_2; // From RBT to ALU

	wire [31:0] result; // From ALU to MAB

	wire [31:0] LDR; // From MAB to RBT

	wire [15:0] PC_out; // From state machine to MAB

	wire [3:0] flags;
	
	reg Enable, clk, reset;

	//Break up instruction into components
	wire [31:0] instruction; // From state machine
	wire [3:0] condition;
	wire [3:0] op_code;
	wire s_bit;
	wire [3:0] destination;
	wire [3:0] source_2_sel;
	wire [3:0] source_1_sel;
	wire [15:0] immediate_value;

	assign condition = instruction[31:28];
	assign op_code = instruction[27:24];
	assign s_bit = instruction[23];
	assign destination = instruction[22:19];
	assign source_2_sel = instruction[18:15];
	assign source_1_sel = instruction[14:11];
	assign immediate_value = instruction[18:3];
	
	reg ram_read_write;
	reg [31:0] ram_data_in;
	reg [15:0] ram_address;

	//Submodules

	// TODO: Flags IO needs handling
	ALU ALU_CPU(op_code, source_1, source_2, immediate_value, condition, s_bit, result, flags);

	memory_access_block MAB_CPU(reset, data_in, data_out, read_write, address, LDR, source_1, source_2, result, op_code, PC_out);

	reg_bank_toplevel RBT_CPU(destination, LDR, source_1_sel, source_2_sel, source_1, source_2);

	// TODO: figure out how to handle enable
	memory RAM_CPU(Enable,ram_read_write,ram_address,ram_data_in, data_out);

	state_machine SM_CPU(clk, reset, data_out, instruction, PC_out);
	
	initial
	begin
	$readmemh("load_ram.txt", RAM_CPU.Mem);
	Enable = 0; ram_read_write = 1; ram_address = 16'd0; ram_data_in = 32'hAAAA0000;
	#5 Enable = 1; ram_read_write = 1; ram_address = 16'd0; ram_data_in = 32'hAAAA0000;
	#5 Enable = 1; ram_read_write = 1; ram_address = 16'd1; ram_data_in = 32'hBBBB0000;
	#5 Enable = 1; ram_read_write = 1; ram_address = 16'd2; ram_data_in = 32'hCCCC0000;
	#10
	
	$writememh("load_ram.txt", RAM_CPU.Mem);
	end
	initial
	begin
		$monitor($time, "data at address %d is %h", ram_address, data_out);
	end
endmodule


