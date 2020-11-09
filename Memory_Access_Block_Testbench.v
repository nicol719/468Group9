// Memory Access Block Testbench
//Todo:
// use testbench
// standardize variables

// Instruction			Description													Op Code		Memory Access Block's Job
// ADD R1, R2, R3		(R1=R2+R3)													0000		Send ALU Result to LDR
// SUB R1, R2, R3		(R1=R2-R3)													0001		Send ALU Result to LDR
// MUL R1, R2, R3  		(R1=R2*R3) (assume the result is 32-bit maximum)			0010		Send ALU Result to LDR
// ORR R1, R2, R3		(R1=R2 OR R3)												0011		Send ALU Result to LDR
// AND R1, R2, R3		(R1=R2 AND R3)												0100		Send ALU Result to LDR
// EOR R1, R2, R3		(R1=R2 XOR R3)												0101		Send ALU Result to LDR
// MOV R1, n			Initialize R1 with an immediate number n, 0 <= n<= (2^16−1)	0110		Send ALU Result to LDR
// MOV R1, R2			Copy R2 to R1												0111		Send ALU Result to LDR Send Source1 to LDR (need to verify if source 1 or source 2), (might be easier to just send source 1 through ALU and take it as result)
// MOV R1, R2, LSR #n	(R1=R2 >>n),  1 <= n<= 31									1000		Send ALU Result to LDR
// MOV R1, R2, LSL #n	(R1=R2 <<n), 1 <= n<= 31									1001		Send ALU Result to LDR
// MOV R1, R2, ROR #n	(R1=Rotate right R2 by n-bit) , 1 <= n<= 31					1010		Send ALU Result to LDR
// CMP R1, R2			Compare R1 with R2 and set the status flags 				1011		Do Nothing
// ADR R1, n			Initialize R1 with a 16-bit address n, 0 <= n<= (2^16−1)	1100		Send ALU Result to LDR 
// LDR R2, [R1]			Load R2 with the contents at memory address R1				1101		Load data from ram at address(Source1), send loaded data to LDR
// STR R2, [R1]			Store R2 at memory address R1								1110		Store data Source2 at ram address(Source1)
// NOP					No Operation -Skip this instruction							1111		Do Nothing

//--------------------------
// Test Memory Access Block
//--------------------------
module test_memory_access_block;
	reg [3:0] OpCode_t;
	reg [15:0] PCInstruction_t;
	reg [31:0] Source1_t, Source2_t, Result_t, DataIn_t;
	wire ReadWrite_t;
	wire [15:0] Address_t;
	wire [31:0] DataOut_t, LDR_t;
	
	memory_access_block test_block(DataIn_t, DataOut_t, ReadWrite_t, Address_t, LDR_t, Source1_t, Source2_t, Result_t, OpCode_t, PCInstruction_t);
	
	initial
	begin
	//Test cases
	
	// do nothing op code
	// LDR should be Z's
	// Ram should stay in read mode
	// Don't care about address
	// Don't care about DataOut
	OpCode_t = 4'b1111; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEEEEE;
	
	// Write to ram op code
	// LDR should be Z's
	// Ram should be in write mode
	// Address should be Source 1
	// DataOut should be Source 2
	#5 OpCode_t = 4'b1110; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1110; PCInstruction_t = 16'hAAAA; Source1_t = 32'hBBBBAAAA; Source2_t = 32'hCCCCBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1110; PCInstruction_t = 16'hAAAA; Source1_t = 32'hDDDDAAAA; Source2_t = 32'hDDDDBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEEEEE;
	
	// Read from ram op code
	// LDR should be DataIn
	// Ram should stay in read mode
	// Address should be Source 1
	// Don't care about DataOut
	#5 OpCode_t = 4'b1101; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1101; PCInstruction_t = 16'hAAAA; Source1_t = 32'hBBBBAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEAAAA;
	#5 OpCode_t = 4'b1101; PCInstruction_t = 16'hAAAA; Source1_t = 32'hCCCCAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEBBBB;
	
	// Compare op code (should be the same as do nothing op code)
	// LDR should be Z's
	// Ram should stay in read mode
	// Don't care about address
	// Don't care about DataOut
	#5 OpCode_t = 4'b1011; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCCCCCC; DataIn_t = 32'hEEEEEEEE;
	
	// Rest of op codes (should be handled the same)
	// Result should be passed through LDR_t
	// Ram should stay in read mode
	// Don't care about address
	// Don't care about DataOut
	#5 OpCode_t = 4'b0000; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0000; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0001; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0001; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0010; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0010; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0011; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0011; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0100; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0100; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0101; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0101; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0110; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0110; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b0111; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC0111; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1000; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC1000; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1001; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC1001; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1010; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC1010; DataIn_t = 32'hEEEEEEEE;
	#5 OpCode_t = 4'b1100; PCInstruction_t = 16'hAAAA; Source1_t = 32'hAAAAAAAA; Source2_t = 32'hBBBBBBBB; Result_t = 32'hCCCC1100; DataIn_t = 32'hEEEEEEEE;
	end	
endmodule

//--------------------------
// Test 2 by 1 mux
//--------------------------
module test_mux2by1;
	reg Select_t;
	reg [31:0] In1_t, In2_t;
	wire [31:0] Out_t;
	
	mux_2by1 testmux(Select_t, In1_t, In2_t, Out_t);
	
	initial
	begin
	//Test cases
	Select_t = 1; In1_t = 32'hAAAAAAAA; In2_t = 32'hBBBBBBBB;
	#5 Select_t = 1; In1_t = 32'hAAAAAAAA; In2_t = 32'hBBBB0000;
	#5 Select_t = 1; In1_t = 32'hAAAA0000; In2_t = 32'hBBBB0000;
	#5 Select_t = 0; In1_t = 32'hAAAA0000; In2_t = 32'hBBBB0000;
	#5 Select_t = 0; In1_t = 32'hAAAABBBB; In2_t = 32'hBBBBAAAA;
	#5 Select_t = 1; In1_t = 32'hAAAABBBB; In2_t = 32'hBBBBAAAA;
	end


	initial
	begin
	$monitor($time, " select =%d, in1 =%h, in2 =%h, Out =%h", Select_t, In1_t, In2_t, Out_t);
	end
endmodule
	