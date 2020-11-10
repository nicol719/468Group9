// Memory Access Block Testbench
// By GN
//Todo:
// standardize variables

// Instruction			Description													Op Code		Memory Access Block's Job
// ADD R1, R2, R3		(R1=R2+R3)													0000		Send ALU ALU_result to LDR
// SUB R1, R2, R3		(R1=R2-R3)													0001		Send ALU ALU_result to LDR
// MUL R1, R2, R3  		(R1=R2*R3) (assume the ALU_result is 32-bit maximum)			0010		Send ALU ALU_result to LDR
// ORR R1, R2, R3		(R1=R2 OR R3)												0011		Send ALU ALU_result to LDR
// AND R1, R2, R3		(R1=R2 AND R3)												0100		Send ALU ALU_result to LDR
// EOR R1, R2, R3		(R1=R2 XOR R3)												0101		Send ALU ALU_result to LDR
// MOV R1, n			Initialize R1 with an immediate number n, 0 <= n<= (2^16−1)	0110		Send ALU ALU_result to LDR
// MOV R1, R2			Copy R2 to R1												0111		Send ALU ALU_result to LDR Send source_1 to LDR (need to verify if source 1 or source 2), (might be easier to just send source 1 through ALU and take it as ALU_result)
// MOV R1, R2, LSR #n	(R1=R2 >>n),  1 <= n<= 31									1000		Send ALU ALU_result to LDR
// MOV R1, R2, LSL #n	(R1=R2 <<n), 1 <= n<= 31									1001		Send ALU ALU_result to LDR
// MOV R1, R2, ROR #n	(R1=Rotate right R2 by n-bit) , 1 <= n<= 31					1010		Send ALU ALU_result to LDR
// CMP R1, R2			Compare R1 with R2 and set the status flags 				1011		Do Nothing
// ADR R1, n			Initialize R1 with a 16-bit ram_address n, 0 <= n<= (2^16−1)	1100		Send ALU ALU_result to LDR 
// LDR R2, [R1]			Load R2 with the contents at memory ram_address R1				1101		Load data from ram at ram_address(source_1), send loaded data to LDR
// STR R2, [R1]			Store R2 at memory ram_address R1								1110		Store data source_2 at ram ram_address(source_1)
// NOP					No Operation -Skip this instruction							1111		Do Nothing

//--------------------------
// Test Memory Access Block
//--------------------------
module test_memory_access_block;
	reg [3:0] op_code_t;
	reg [15:0] PC_instruction_t;
	reg [31:0] source_1_t, source_2_t, ALU_result_t, data_in_t;
	wire read_write_t;
	wire [15:0] ram_address_t;
	wire [31:0] data_out_t, LDR_t;
	
	memory_access_block test_block(data_in_t, data_out_t, read_write_t, ram_address_t, LDR_t, source_1_t, source_2_t, ALU_result_t, op_code_t, PC_instruction_t);
	
	initial
	begin
	//Test cases
	
	// Do nothing op code
	// LDR should be ALU_result (Z's should be passed from ALU)
	// Ram should stay in read mode (1)
	// Don't care about ram_address
	// Don't care about data_out
	op_code_t = 4'b1111; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEEEEE;
	
	// Write to ram op code
	// LDR should be ALU_result (Z's should be passed from ALU)
	// Ram should be in write mode (0)
	// ram_address should be Source 1
	// data_out should be Source 2
	#5 op_code_t = 4'b1110; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAF; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1110; PC_instruction_t = 16'hDDDD; source_1_t = 32'hBBBBAAFA; source_2_t = 32'hCCCCBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1110; PC_instruction_t = 16'hDDDD; source_1_t = 32'hDDDDAFAA; source_2_t = 32'hDDDDBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEEEEE;
	
	// Read from ram op code
	// LDR should be data_in
	// Ram should stay in read mode (1)
	// ram_address should be Source 1
	// Don't care about data_out
	#5 op_code_t = 4'b1101; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAF; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1101; PC_instruction_t = 16'hDDDD; source_1_t = 32'hBBBBAAFA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEAAAA;
	#5 op_code_t = 4'b1101; PC_instruction_t = 16'hDDDD; source_1_t = 32'hCCCCAFAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEBBBB;
	
	// Compare op code (should be the same as do nothing op code)
	// LDR should be ALU_result (Z's should be passed from ALU)
	// Ram should stay in read mode (1)
	// Don't care about ram_address
	// Don't care about data_out
	#5 op_code_t = 4'b1011; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCCCCCC; data_in_t = 32'hEEEEEEEE;
	
	// Rest of op codes (should be handled the same)
	// ALU_result should be passed through LDR_t
	// Ram should stay in read mode
	// Don't care about ram_address
	// Don't care about data_out
	#5 op_code_t = 4'b0000; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0000; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0001; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0001; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0010; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0010; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0011; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0011; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0100; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0100; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0101; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0101; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0110; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0110; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b0111; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC0111; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1000; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC1000; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1001; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC1001; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1010; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC1010; data_in_t = 32'hEEEEEEEE;
	#5 op_code_t = 4'b1100; PC_instruction_t = 16'hDDDD; source_1_t = 32'hAAAAAAAA; source_2_t = 32'hBBBBBBBB; ALU_result_t = 32'hCCCC1100; data_in_t = 32'hEEEEEEEE;
	end	
	
	
	initial
	begin
	$monitor($time, "\nINPUTS:\nop_code = %b, PCI = %h, source_1 = %h, source_2 = %h, ALU_result = %h, data_in = %h\noutPUTS\n read_write = %b, ram_address = %h, data_out = %h, LDR = %h", op_code_t, PC_instruction_t, source_1_t, source_2_t, ALU_result_t, data_in_t, read_write_t, ram_address_t, data_out_t, LDR_t);
	end
endmodule

//--------------------------
// Test 2 by 1 mux
//--------------------------
module test_mux2by1;
	reg select_t;
	reg [31:0] in_1_t, in_2_t;
	wire [31:0] out_t;
	
	mux_2by1 testmux(select_t, in_1_t, in_2_t, out_t);
	
	initial
	begin
	//Test cases
	select_t = 1; in_1_t = 32'hAAAAAAAA; in_2_t = 32'hBBBBBBBB;
	#5 select_t = 1; in_1_t = 32'hAAAAAAAA; in_2_t = 32'hBBBB0000;
	#5 select_t = 1; in_1_t = 32'hAAAA0000; in_2_t = 32'hBBBB0000;
	#5 select_t = 0; in_1_t = 32'hAAAA0000; in_2_t = 32'hBBBB0000;
	#5 select_t = 0; in_1_t = 32'hAAAABBBB; in_2_t = 32'hBBBBAAAA;
	#5 select_t = 1; in_1_t = 32'hAAAABBBB; in_2_t = 32'hBBBBAAAA;
	end


	initial
	begin
	$monitor($time, " select =%d, in_1 =%h, in_2 =%h, out =%h", select_t, in_1_t, in_2_t, out_t);
	end
endmodule
	