// ALU Testbench
//----------
// OP Codes
//----------
// Instruction			Description														Op Code
// ADD R1, R2, R3		(R1=R2+R3)														0000
// SUB R1, R2, R3		(R1=R2-R3)														0001
// MUL R1, R2, R3		(R1=R2*R3) (assume the result is 32-bit maximum)				0010
// ORR R1, R2, R3		(R1=R2 OR R3)													0011
// AND R1, R2, R3		(R1=R2 AND R3) 													0100
// EOR R1, R2, R3 		(R1=R2 XOR R3) 													0101
// MOV R1, n 			Initialize R1 with an immediate number n, 0 <= n <= (2^16 ? 1) 	0110
// MOV R1, R2 			Copy R2 to R1 													0111
// MOV R1, R2, LSR #n 	(R1=R2 >>n), 1 <= n <= 31 										1000
// MOV R1, R2, LSL #n 	(R1=R2 <<n), 1 <= n <= 31 										1001
// MOV R1, R2, ROR #n 	(R1=Rotate right R2 by n-bit) , 1 <= n <= 31 					1010
// CMP R1, R2 			Compare R1 with R2 and set the status flags 					1011
// ADR R1, n 			Initialize R1 with a 16-bit address n, 0 <= n <= (2^16 ? 1) 	1100
// LDR R2, [R1] 		Load R2 with the contents at memory address R1 					1101
// STR R2, [R1] 		Store R2 at memory address R1 									1110
// NOP 					No Operation - Skip this instruction 							1111

//================
//ALU Main Module
//================
// Code here

//================
//ALU Alternate Main Module
//================
module test_ALU_alt;
	reg [31:0] source_1_t, source_2_t;
	reg [3:0] OP_Code_t, coditional_t;
	reg [15:0] immediate_value_t;
	reg S_t;
	
	wire [31:0] Result_t;
	wire [3:0] flags_t;
	
	ALU_alt test_alu_alt(OP_Code_t, source_1_t,source_2_t,coditional_t,S_t,Result_t, flags_t,immediate_value_t);
	
	initial
	begin
	//Test cases. Not testing cases that use source_2_t or conditionals/flags yet
	//Test do nothing op code. 1st result should be z's
	#10 OP_Code_t = 4'b1111; source_1_t = 32'hABCDABCD; immediate_value_t = 16'hDCAB;
	//Test STR op code. 2nd result should be z's
	#10 OP_Code_t = 4'b1110; source_1_t = 32'hABCDABCD; immediate_value_t = 16'hDCAB;
	//Test LDR op code. 3rd result should be z's
	#10 OP_Code_t = 4'b1101; source_1_t = 32'hABCDABCD; immediate_value_t = 16'hDCAB;
	//Test ADR op code. 4th result should be immediate_value_t at 32 bits, so 32'h0000DCAB
	#10 OP_Code_t = 4'b1100; source_1_t = 32'hABCDABCD; immediate_value_t = 16'hDCAB;
	//Test ADR when immediate_value_t changes. 5th result should be 32'h0000ABCD
	#10 OP_Code_t = 4'b1100; source_1_t = 32'hABCDABCD; immediate_value_t = 16'hABCD;
	//Test MOV2 op code. 6th result should be source_1_t so 32'hABCDABCD
	#10 OP_Code_t = 4'b0111; source_1_t = 32'hABCDABCD; immediate_value_t = 16'hABCD;
	//Test changeign source_1_t. 7th result should be source_1_t so 32'hCDEFCDEF
	#10 OP_Code_t = 4'b0111; source_1_t = 32'hCDEFCDEF; immediate_value_t = 16'hABCD;
	//Test MOV1 op code. 8th result should be immediate_value_t so 32'h0000ABCD
	#10 OP_Code_t = 4'b0110; source_1_t = 32'hCDEFCDEF; immediate_value_t = 16'hABCD;
	//Test changing immediate value, 9th result 32'h0000DCAB
	#10 OP_Code_t = 4'b0110; source_1_t = 32'hCDEFCDEF; immediate_value_t = 16'hDCAB;
	// Test rotate_right OPcode. number of bits is immediate_value_t [7:2]
	// So in this case, immediate_value_t should result in a 3 bit rotation
	// 10th output should be source_1_t rotated by 3 bits so ??????
	#10 OP_Code_t = 4'b1010; source_1_t = 32'h0000FFFF; immediate_value_t = 16'b0000000000011000;
	//11th output is a rotate by 5 bits so ????????
	#10 OP_Code_t = 4'b1010; source_1_t = 32'h0000FFFF; immediate_value_t = 16'b0000000000101000;
	// Test shift right OP code. shift right 3 bits 12th result
	#10 OP_Code_t = 4'b1000; source_1_t = 32'h0000FFFF; immediate_value_t = 16'b0000000000011000;
	// Test shift right OP code. shift right 5 bits 13th result
	#10 OP_Code_t = 4'b1000; source_1_t = 32'h0000FFFF; immediate_value_t = 16'b0000000000101000;
	// Test shift left OP code. shift left 3 bits 14th result
	#10 OP_Code_t = 4'b1001; source_1_t = 32'h0000FFFF; immediate_value_t = 16'b0000000000011000;
	// Test shift left OP code. shift left 5 bits 15th result
	#10 OP_Code_t = 4'b1001; source_1_t = 32'h0000FFFF; immediate_value_t = 16'b0000000000101000;
	end


	initial
	begin
	$monitor($time, "\n OPCode = %b\n\n Hex values:\n Source1 = %h\n Immediate Value = %h\n Result = %h\n\n Bin values:\n Source1 = %b\n Immediate Value = %b\n Result = %b\n-------------------------------------------", OP_Code_t,source_1_t,immediate_value_t,Result_t, source_1_t,immediate_value_t,Result_t);
	end
endmodule


//==================
// 32-bit adder
//=================
//Code here

//==================
// 32-bit subtractor
//=================
//Code here

//==================
// 32-bit multiplier
//=================
//Code here

//==================
// 32-bit bitwise ORing
//=================
//Code here

//==================
// 32-bit bitwise ANDing
//=================
//Code here

//==================
// 32-bit bitwise XORing
//=================
//Code here

//==================
// parameterized 32-bit right shift register that shifts the input by n-bit
// By GN
//=================
module test_shift_left;
	reg [31:0] source_1_t;
	reg [4:0] number_bits_t;
	wire [31:0] out_t;	
	shift_left testshift(source_1_t, number_bits_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'hFFFFFFFF; number_bits_t = 0;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 1;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 2;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 3;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 31;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 32;
	end


	initial
	begin
	$monitor($time, " source_1_t =%b, number_bits_t =%d, out =%b", source_1_t, number_bits_t, out_t);
	end
endmodule

//==================
// parameterized 32-bit left shift register that shifts the input by n-bit
// By GN
//=================
module test_shift_right;
	reg [31:0] source_1_t;
	reg [4:0] number_bits_t;
	wire [31:0] out_t;	
	shift_right testshift(source_1_t, number_bits_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'hFFFFFFFF; number_bits_t = 0;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 1;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 2;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 3;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 31;
	#5 source_1_t = 32'hFFFFFFFF; number_bits_t = 32;
	end


	initial
	begin
	$monitor($time, " source_1_t =%b, number_bits_t =%d, out =%b", source_1_t, number_bits_t, out_t);
	end
endmodule

//==================
// parameterized 32-bit register that right rotates the input by n-bit
// By GN
//=================
module test_rotate_right;
	reg [31:0] source_1_t;
	reg [4:0] number_bits_t;
	wire [31:0] out_t;	
	rotate_right testrotate(source_1_t, number_bits_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'hFFFF0000; number_bits_t = 0;
	#5 source_1_t = 32'hFFFF0000; number_bits_t = 1;
	#5 source_1_t = 32'h0000FFFF; number_bits_t = 1;
	#5 source_1_t = 32'hFFFF0000; number_bits_t = 2;
	#5 source_1_t = 32'h0000FFFF; number_bits_t = 2;
	#5 source_1_t = 32'hFFFF0000; number_bits_t = 3;
	#5 source_1_t = 32'hFFFF0000; number_bits_t = 31;
	#5 source_1_t = 32'hFFFF0000; number_bits_t = 32;
	end


	initial
	begin
	$monitor($time, " source_1_t =%b, number_bits_t =%d, out =%b", source_1_t, number_bits_t, out_t);
	end
endmodule

//==================
// A 32-line 16x1 Multiplexer (each input/output is an 32-bit wide)
// By GN
//=================
module test_mux_16to1;
	reg [31:0] ADD_t,SUB_t,MUL_t,ORR_t,AND_t,EOR_t,MOV1_t,MOV2_t,MOV3_t,MOV4_t,MOV5_t,CMP_t,ADR_t,LDR_t,STR_t,NOP_t;
	reg [3:0] select_t;
	wire [31:0] out_t;	
	mux_16to1 testmux(select_t,ADD_t,SUB_t,MUL_t,ORR_t,AND_t,EOR_t,MOV1_t,MOV2_t,MOV3_t,MOV4_t,MOV5_t,CMP_t,ADR_t,LDR_t,STR_t,NOP_t,out_t);
	
	initial
	begin
	//Test cases
	// Such that out resembles select
	select_t = 4'b0000; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0001; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0010; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0011; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0100; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0101; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0110; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0111; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1000; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1001; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1010; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1011; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1100; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1101; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1110; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b1111; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	// Test when inputs change
	#5 select_t = 4'b0000; ADD_t = 32'hA0000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0000; ADD_t = 32'hB0000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0000; ADD_t = 32'hC0000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0000; ADD_t = 32'h00000000; SUB_t = 32'h0000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0000; ADD_t = 32'h00000000; SUB_t = 32'hA000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	#5 select_t = 4'b0000; ADD_t = 32'h00000000; SUB_t = 32'hB000000F;MUL_t = 32'h000000F0;ORR_t = 32'h000000FF;AND_t = 32'h00000F00;EOR_t= 32'h000000F0F;MOV1_t = 32'h00000FF0;MOV2_t = 32'h00000FFF;MOV3_t = 32'h0000F000;MOV4_t= 32'h0000F00F;MOV5_t = 32'h0000F0F0;CMP_t = 32'h0000F0FF;ADR_t = 32'h0000FF00;LDR_t = 32'h0000FF0F;STR_t= 32'h0000FFF0;NOP_t = 32'h0000FFFF;
	
	end


	initial
	begin
	$monitor($time, "\nselect_t = %b\nADD_t = %h, SUB_t = %h, MUL_t = %h, ORR_t = %h, AND_t = %h, EOR_t = %h, MOV1_t = %h, MOV2_t = %h, MOV3_t = %h, MOV4_t = %h, MOV5_t = %h, CMP_t = %h, ADR_t = %h, LDR_t = %h, STR_t = %h, NOP_t = %h\nout_t = %h\n", select_t,ADD_t,SUB_t,MUL_t,ORR_t,AND_t,EOR_t,MOV1_t,MOV2_t,MOV3_t,MOV4_t,MOV5_t,CMP_t,ADR_t,LDR_t,STR_t,NOP_t,out_t);
	end
endmodule

//==================
// A module that checks the S-bit /CMP instruction and generates the 4-bit flag accordingly
//=================
//Code here

//==================
// 8-bit Counter (Program Counter (PC))
//=================
//Code here


//================
// Other small modules that cover the remaining functions of the 15-instruction set (such as MOV and LDR).
//================

//==================
// LDR
// No outpt is expected from ALU
// By GN
//=================

module test_LDR;
	wire [31:0] out_t;	
	LDR testLDR(out_t);
	
	initial
	begin
	//Test cases
	#5 ;
	end
	
	initial
	begin
	$monitor($time, " out_t =%b",out_t);
	end
endmodule

//==================
// NOP
// No outpt is expected from ALU
// By GN
//=================

module test_NOP;
	wire [31:0] out_t;	
	NOP testNOP(out_t);
	
	initial
	begin
	//Test cases
	#5 ;
	end
	initial
	begin
	$monitor($time, " out_t =%b",out_t);
	end
endmodule

//==================
// MOV1
// Initialize R1 with an immediate number n
// By GN
//=================

module test_MOV1;
	reg [15:0] immediate_value_t;
	wire [31:0] out_t;	
	MOV1 testMOV1(immediate_value_t, out_t);
	
	initial
	begin
	//Test cases
	immediate_value_t = 16'h0000;
	#5 immediate_value_t = 16'hABCD;
	#5 immediate_value_t = 16'hDCAB;
	end
	initial
	begin
	$monitor($time, "immediate_value_t = %h, out_t =%h",immediate_value_t, out_t);
	end
endmodule

//==================
// MOV2
// Send Source1 to memory access block so it can be loaded into the register
// By GN
//=================

module test_MOV2;
	reg [31:0] source_1_t;
	wire [31:0] out_t;	
	MOV2 testMOV2(source_1_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'h00000000;
	#5 source_1_t = 32'hABCDABCD;
	#5 source_1_t = 32'hDCABDCAB;
	end
	initial
	begin
	$monitor($time, "source_1_t = %h, out_t =%h",source_1_t, out_t);
	end
endmodule

//==================
// STR
// No outpt is expected from ALU
// By GN
//=================

module test_STR;
	wire [31:0] out_t;	
	STR testSTR(out_t);
	
	initial
	begin
	//Test cases
	#5 ;
	end
	initial
	begin
	$monitor($time, " out_t =%b",out_t);
	end
endmodule

//==================
// ADR
// Initialize R1 with an immediate address n
// By GN
//=================

module test_ADR;
	reg [15:0] immediate_value_t;
	wire [31:0] out_t;	
	ADR testADR(immediate_value_t, out_t);
	
	initial
	begin
	//Test cases
	immediate_value_t = 16'h0000;
	#5 immediate_value_t = 16'hABCD;
	#5 immediate_value_t = 16'hDCAB;
	end
	initial
	begin
	$monitor($time, "immediate_value_t = %h, out_t =%h",immediate_value_t, out_t);
	end
endmodule