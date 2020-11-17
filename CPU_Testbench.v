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
	wire [1:0] next_state, current_state;
	
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