// ALU Here

//ALU Info

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


//-----------------
// Condition Codes
//-----------------
// 0000 No Condition
// 0001 EQ - Equal
// 0010 GT - Greater Than
// 0011 LT ? Less Than
// 0100 GE ? Greater Than or Equal To
// 0101 LE ? Less Than or Equal To
// 0110 HI ? Unsigned Higher
// 0111 LO ? Unsigned Lower
// 1000 HS ? Unsigned Higher or Same

//-------
// Flags
//-------
// 4 one-bit flags {N, Z, C, V}
// If N == 1, result is negative
// If Z == 1, result is zero
// If C == 1, result generates a carry
// If V == 1, resut generates an overflow

//-------------
// Sub Modules
//--------------
// The ALU design should be a modular one. You should write a separate module for each of the following ALU operations (sub-designs);
//	a) A 32-bit adder
//	b) A 32-bit subtractor
//	c) A 32-bit multiplier
//	d) A 32-bit bitwise ORing
//	e) A 32-bit bitwise ANDing
//	f) A 32-bit bitwise XORing
//	g) A parameterized 32-bit right shift register that shifts the input by n-bit
//	h) A parameterized 32-bit left shift register that shifts the input by n-bit
//	i) A parameterized 32-bit register that right rotates the input by n-bit
//	j) A 32-line 16x1 Multiplexer (each input/output is an 32-bit wide)
//	k) A module that checks the S-bit /CMP instruction and generates the 4-bit flag accordingly. You may need to Google to learn how the four
//		flags will be calculated.
//	l) 8-bit Counter (Program Counter (PC))
//	m) Other small modules that cover the remaining functions of the 15-instruction set (such as MOV and LDR).
// Make sure you compile and simulate each of these sub-modules before instantiating and integrating all of them to form the ALU. The ALU design
// should be then compiled and simulated


//================
//ALU Main Module
//================
// Code here
module ALU ()
  {
    //code goes here 
  }

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
//=================
//Code here

//==================
// parameterized 32-bit left shift register that shifts the input by n-bit
//=================
//Code here

//==================
// parameterized 32-bit register that right rotates the input by n-bit
//=================
//Code here

//==================
// A 32-line 16x1 Multiplexer (each input/output is an 32-bit wide)
//=================
//Code here

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
