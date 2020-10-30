// ALU Here

//ALU Info

//----------
// OP Codes
//----------
// Instruction		Description							Op Code
// ADD R1, R2, R3	(R1=R2+R3)							0000
// SUB R1, R2, R3	(R1=R2-R3)							0001
// MUL R1, R2, R3	(R1=R2*R3) (assume the result is 32-bit maximum)		0010
// ORR R1, R2, R3	(R1=R2 OR R3)							0011
// AND R1, R2, R3	(R1=R2 AND R3) 							0100
// EOR R1, R2, R3 	(R1=R2 XOR R3) 							0101
// MOV R1, n 		Initialize R1 with an immediate number n, 0 <= n <= (2^16 ? 1) 	0110
// MOV R1, R2 		Copy R2 to R1 							0111
// MOV R1, R2, LSR #n 	(R1=R2 >>n), 1 <= n <= 31 					1000
// MOV R1, R2, LSL #n 	(R1=R2 <<n), 1 <= n <= 31 					1001
// MOV R1, R2, ROR #n 	(R1=Rotate right R2 by n-bit) , 1 <= n <= 31 			1010
// CMP R1, R2 		Compare R1 with R2 and set the status flags 			1011
// ADR R1, n 		Initialize R1 with a 16-bit address n, 0 <= n <= (2^16 ? 1) 	1100
// LDR R2, [R1] 	Load R2 with the contents at memory address R1 			1101
// STR R2, [R1] 	Store R2 at memory address R1 					1110
// NOP 			No Operation - Skip this instruction 				1111

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

//ALU Main Module