//==================
// Test
// CPU
// By GN
//=================
module _CPU;
	wire [15:0] address; //From MAB to RAM_CPU
	wire read_write; // From MAB to RAM
	wire [31:0] data_in; // From MAB to RAM
	wire [31:0] data_out; // From RAM to MAB and State Machine

	wire [31:0] source_1; // From RBT to ALU
	wire [31:0] source_2; // From RBT to ALU

	wire [31:0] result; // From ALU to MAB

	wire [31:0] LDR; // From MAB to RBT

	wire [15:0] PC_out; // From state machine to MAB
	
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
	wire [1:0] current_state;
	wire [3:0] flags;

	assign condition = instruction[31:28];
	assign op_code = instruction[27:24];
	assign s_bit = instruction[23];
	assign destination = instruction[22:19];
	assign source_2_sel = instruction[18:15];
	assign source_1_sel = instruction[14:11];
	assign immediate_value = instruction[18:3];

	//Submodules

	ALU ALU_CPU(op_code, source_2, source_1, immediate_value, condition, s_bit, result, flags);

	memory_access_block MAB_CPU(reset, data_out, data_in, read_write, address, LDR, source_1, source_2, result, op_code, PC_out);

	reg_bank_toplevel RBT_CPU(destination, LDR, source_1_sel, source_2_sel, source_1, source_2);

	
	memory RAM_CPU(Enable,read_write,address,data_in, data_out);

	state_machine SM_CPU(clk, reset, data_out, instruction, PC_out, current_state);
	
	initial
	begin
	$readmemb("example.txt", RAM_CPU.Mem);
	reset = 1; clk = 0; Enable = 0;
	#5 reset = 0;
	#5 reset = 1; Enable = 1;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	#5 clk = 1;
	#5 clk = 0;
	
	#10
	$writememb("ram_results.txt", RAM_CPU.Mem);
	end
	initial
	begin
	$monitor($time, "\n ---------- \n op_code = %b,\n result = %d,\n destination = %d,\n current_state = %d,\n PC_out = %d,\n instruction = %b,\n address = %d,\n data_out = %h,\n read_write = %b,\n source_1 = %b,\n source_2 = %b\n flags = %b",op_code,result, destination, current_state, PC_out, instruction, address, data_out, read_write, source_1, source_2, flags);
	end
endmodule


//==================
// Test
// StateMachine
// Initialize R1 with an immediate address n
// By GN
//=================

module test_state_machine;
	reg clk, reset;
	reg [31:0] instruction_in;
	wire [31:0] instruction_out;
	wire [15:0] PC_out;
	
	state_machine test_state_machine(clk, reset, instruction_in, instruction_out, PC_out, next_state, current_state);
	
	initial
	begin
	//Test cases
	instruction_in = 32'h00000000; clk = 0; reset = 1; //S?
	instruction_in = 32'h00000000; clk = 0; reset = 0;
	instruction_in = 32'h00000000; clk = 0; reset = 1;
	#5 instruction_in = 32'h00000000; clk = 1; //S?
	#5 instruction_in = 32'h00000000; clk = 0; //S?
	#5 instruction_in = 32'h00000000; clk = 1; //S0
	#5 instruction_in = 32'h00000000; clk = 0; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 1; //S1
	#5 instruction_in = 32'h00000000; clk = 0; //S1
	#5 instruction_in = 32'h00000000; clk = 1; //S2
	#5 instruction_in = 32'hAAAAAAAA; clk = 0; //S2
	#5 instruction_in = 32'hAAAAAAAA; clk = 1; //S0
	#5 instruction_in = 32'hAAAAAAAA; clk = 0; //S0
	#5 instruction_in = 32'hBBBBBBBB; clk = 1; //S1
	#5 instruction_in = 32'hBBBBBBBB; clk = 0; //S1
	#5 instruction_in = 32'hCCCCCCCC; clk = 1; //S2
	#5 instruction_in = 32'hDDDDDDDD; clk = 0; //S2
	#5 instruction_in = 32'hEEEEEEEE; clk = 1; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 0; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 1; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 0; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 1; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 0; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 1; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 0; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 1; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 0; //S0
	#5 instruction_in = 32'hFFFFFFFF; clk = 1; //S0
	end
	initial
	begin
	$monitor($time, "clk %b,instruction_in = %h, instruction_out = %h, PC_out =%d, next_state = %b, current_state = %b",clk,instruction_in, instruction_out, PC_out, next_state, current_state);
	end
endmodule