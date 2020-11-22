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
// Test
//ALU Main Module
// by GN
//================
module test_ALU;
	reg [31:0] source_1_t, source_2_t;
	reg [3:0] OP_Code_t, coditional_t;
	reg [15:0] immediate_value_t;
	reg S_t;
	
	wire [31:0] Result_t;
	wire [3:0] flags_t;
	
	ALU test_alu(OP_Code_t, source_1_t,source_2_t,immediate_value_t,coditional_t,S_t,Result_t, flags_t);
	
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
	// Test ADD for 16th result
	#10 OP_Code_t = 4'b0000; source_1_t = 32'd5; source_2_t = 32'd6;
	// Test SUB for 17th result
	#10 OP_Code_t = 4'b0001; source_1_t = 32'd10; source_2_t = 32'd7;
	// Test MUL for 18th result
	#10 OP_Code_t = 4'b0010; source_1_t = 32'd7; source_2_t = 32'd8;
	// Test OR for 19th result
	#10 OP_Code_t = 4'b0011; source_1_t = 32'hFFFFFFFF; source_2_t = 32'h11111111;
	//  Test AND for 20th resut
	#10 OP_Code_t = 4'b0100; source_1_t = 32'h33333333; source_2_t = 32'h11111111;
	// Test XOR for 21st result
	#10 OP_Code_t = 4'b0101; source_1_t = 32'h33333333; source_2_t = 32'h11111111;
	// Test CMP for 22nd result
	#10 OP_Code_t = 4'b1011; source_1_t = 32'h33333333; source_2_t = 32'h11111111;
	end


	initial
	begin
	$monitor($time, "\n OPCode = %b\n\n Hex values:\n Source1 = %h\n Source 2 = %h\n Immediate Value = %h\n Result = %h\n\n Bin values:\n Source1 = %b\n Source2 = %b\n Immediate Value = %b\n Result = %b\n-------------------------------------------", OP_Code_t,source_1_t,source_2_t,immediate_value_t,Result_t, source_1_t,source_2_t,immediate_value_t,Result_t);
	end
endmodule


//==================
// Test
// 32-bit adder
// By GN
//=================
module test_ADD;
	reg [31:0] source_1_t, source_2_t;
	wire [31:0] out_t;	
	ADD testADD(out_t, source_1_t, source_2_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'd5; source_2_t = 32'd5;
	#5 source_1_t = 32'd75; source_2_t = 32'd2;
	#5 source_1_t = 32'd12; source_2_t = 32'd12;
	#5 source_1_t = 32'd7; source_2_t = 32'd8;
	end


	initial
	begin
	$monitor($time, " \nsource_1_t =%d, \nsource_2_t =%d, \nout =%d\n-----------\n", source_1_t, source_2_t, out_t);
	end
endmodule

//==================
// Test
// 32-bit subtractor
// By GN
//=================
module test_SUB;
	reg [31:0] source_1_t, source_2_t;
	wire [31:0] out_t;	
	SUB testSUB(source_1_t, source_2_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'd5; source_2_t = 32'd5;
	#5 source_1_t = 32'd75; source_2_t = 32'd2;
	#5 source_1_t = 32'd12; source_2_t = 32'd12;
	#5 source_1_t = 32'd7; source_2_t = 32'd8;
	end


	initial
	begin
	$monitor($time, " \nsource_1_t =%d, \nsource_2_t =%d, \nout =%d\n-----------\n", source_1_t, source_2_t, out_t);
	end
endmodule

//==================
// Test
// 32-bit multiplier
// By GN
//=================
module test_MUL;
	reg [31:0] source_1_t, source_2_t;
	wire [31:0] out_t;	
	MUL testMUL(source_1_t, source_2_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'd5; source_2_t = 32'd5;
	#5 source_1_t = 32'd75; source_2_t = 32'd2;
	#5 source_1_t = 32'd12; source_2_t = 32'd12;
	#5 source_1_t = 32'd7; source_2_t = 32'd8;
	end


	initial
	begin
	$monitor($time, " \nsource_1_t =%d, \nsource_2_t =%d, \nout =%d\n-----------\n", source_1_t, source_2_t, out_t);
	end
endmodule
//==================
// Test
// 32-bit bitwise ORing
// By GN
//=================
module test_bit_OR;
	reg [31:0] source_1_t, source_2_t;
	wire [31:0] out_t;	
	bit_OR testOR(source_1_t, source_2_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'hFFFFFFFF; source_2_t = 32'hAAAAAAAA;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hAAAAAAAA;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hBBBBBBBB;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hCCCCCCCC;
	end


	initial
	begin
	$monitor($time, " \nsource_1_t =%b, \nsource_2_t =%b, \nout =%b\n-----------\n", source_1_t, source_2_t, out_t);
	end
endmodule

//==================
// Test
// 32-bit bitwise ANDing
// By GN
//=================
module test_bit_AND;
	reg [31:0] source_1_t, source_2_t;
	wire [31:0] out_t;	
	bit_AND testAND(source_1_t, source_2_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'hFFFFFFFF; source_2_t = 32'hAAAAAAAA;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hAAAAAAAA;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hBBBBBBBB;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hCCCCCCCC;
	end


	initial
	begin
	$monitor($time, " \nsource_1_t =%b, \nsource_2_t =%b, \nout =%b\n-----------\n", source_1_t, source_2_t, out_t);
	end
endmodule

//==================
// Test
// 32-bit bitwise XORing
// By GN
//=================
module test_bit_XOR;
	reg [31:0] source_1_t, source_2_t;
	wire [31:0] out_t;	
	bit_XOR testXOR(source_1_t, source_2_t, out_t);
	
	initial
	begin
	//Test cases
	source_1_t = 32'hFFFFFFFF; source_2_t = 32'hAAAAAAAA;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hAAAAAAAA;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hBBBBBBBB;
	#5 source_1_t = 32'hEEEEEEEE; source_2_t = 32'hCCCCCCCC;
	end


	initial
	begin
	$monitor($time, " \nsource_1_t =%b, \nsource_2_t =%b, \nout =%b\n-----------\n", source_1_t, source_2_t, out_t);
	end
endmodule

//==================
// Test
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
// Test
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
// Test
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
// Test
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
// Test
// CMP
// No outpt is expected from ALU
// By GN
//=================

module test_CMP;
	reg [31:0] source_1, source_2;
	reg S;
	reg [3:0] op_code;
	wire [3:0] NZCV;
	wire [31:0] out;	
	CMP test_cmp(source_1, source_2, S, op_code, NZCV, out); 
	
	initial
	begin
	//Test cases
	source_1 =32'd24; source_2 =32'd24; S = 1'b0; op_code = 4'b0000;
	#5 source_1 =32'd24; source_2 =32'd24; S = 1'b1; op_code = 4'b0001;
	#5 source_1 =32'd24; source_2 =32'd10; S = 1'b0; op_code = 4'b1011; 
	#5 source_1 =32'd24; source_2 =32'd24; S = 1'b0; op_code = 4'b0110;
	end
	
	initial
	begin
	$monitor($time, " op_code =%b, S = %b, flags = %b",op_code, S, NZCV);
	end
endmodule


//==================
// Test
// Set Z flag
// By GN
//=================

module test_set_Z_flag;
	reg [31:0] source_1, source_2;
	wire Z;
	set_Z_flag test_set_Z_flag(source_1, source_2, Z); 
	
	initial
	begin
	//Test cases
	source_1 =32'd24; source_2 =32'd24;
	#5 source_1 =32'd24; source_2 =32'd23;
	#5 source_1 =32'd22; source_2 =32'd24;
	#5 source_1 =32'd21; source_2 =32'd21;
	end
	
	initial
	begin
	$monitor($time, " source_1 =%b, source_2 = %b, Z = %b",source_1, source_2, Z);
	end
endmodule
//==================
// 8-bit Counter (Program Counter (PC))
//=================
//Code here


//================
// Other small modules that cover the remaining functions of the 15-instruction set (such as MOV and LDR).
//================

//==================
// Test
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
// Test
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
// Test
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
// Test
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
// Test
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
// Test
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

//==================
// Test
// 8-bit Counter
// By GN
//=================
module test_program_counter;
	reg trigger_t, reset_t;
	wire [7:0] count_t;	
	program_counter testCounter(trigger_t, reset_t, count_t);
	
	initial
	begin
	//Test cases
	trigger_t = 1'b0; reset_t =1'b0;
	#5 trigger_t = 1'b1; reset_t =1'b0;
	#5 trigger_t = 1'b0; reset_t =1'b0;
	#5 trigger_t = 1'b1; reset_t =1'b0;
	#5 trigger_t = 1'b1; reset_t =1'b0;
	#5 trigger_t = 1'b0; reset_t =1'b1;
	#5 trigger_t = 1'b0; reset_t =1'b0;
	#5 trigger_t = 1'b1; reset_t =1'b0;
	#5 trigger_t = 1'b0; reset_t =1'b0;
	#5 trigger_t = 1'b1; reset_t =1'b0;
	end


	initial
	begin
	$monitor($time, " count =%d\n-----------\n", count_t);
	end
endmodule