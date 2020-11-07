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
// SILVERFISH SECTION
module ALU (OP_Code, source_1, source_2, shift_bits, conditional, S, Result, flags);
  
    input [31:0] source_1, source_2; //16 bit source registers 1 and 2
    input [15:4] shift_bits; //immediate value or shift bits seems to so from 16 to 5 bits
    input [3:0] OP_Code, conditional; //op code and conditional flags at 4 bits each
    input S; //this might be sign bit when it is one the input is signed, it will set flags when it is equal to one (bit 23 of the instructions)
    
    output [31:0] Result; //32 bit output
    output [3:0] flags; //4 flag bits order: N Z C V
    
    //Use if statements to call modules, case does not work unlike in C languages
    if (OP_Code == 4'b0000)
      begin
        ///ADD module
      end
    else if (OP_Code == 4'b0001)
      begin
        //SUB module
      end
    else if (OP_Code == 4'b0010)
      begin
        //MUL module
      end
    else if (OP_Code == 4'b0011)
      begin
        //ORR module
      end
    else if (OP_Code == 4'b0100)
      begin
        //AND module
      end
    else if (OP_Code == 4'b0101)
      begin
        //EOR/XOR module
      end
    else if (OP_Code == 4'b0110)
      begin
        //MOV R1, n Initializes R1 with an immediate value of n
      end
    else if (OP_Code == 4'b0111)
      begin
        //MOV R1 R2 copy R2 into R1
      end
    else if (OP_Code == 4'b1000)
      begin
        //MOV R1 R2 LSR #n copy R2 into R1 shifted right by n
      end
    else if (OP_Code == 4'b1001)
      begin
        //MOV R1 R2 LSL #n copy R2 into R1 shifted left by n
      end
    else if (OP_Code == 4'b1010)
      begin
        //MOV R1 R2 Rotated Right by n bits
      end
    else if (OP_Code == 4'b1011)
      begin
        //CMP R1 R2 compare R1 and R2 and set the status flags
    
        
      end
    else if (OP_Code == 4'b1100)
      begin
        //ADR R1 with a 16 bit address n
      end
    else if (OP_Code == 4'b1101)
      begin
        //LDR R2 [R1] load R2 with the contents at memory address R1
      end
    else if (OP_Code == 4'b1110)
      begin
        //STR R2, [R1] Store R2's contents at memory address R1
      end
    else if (OP_Code == 4'b1111)
      begin
        //NOP no operation, skip
      end
    else
      begin
        //retry perhaps? or perform a no operation? or print an error? this is here to prevent latching
      end
    
  //Check conditional codes
  
  if (conditional == 4'b0000)
    begin
      //No condition
    end
  else if (conditional == 4'b0001)
    begin
      //Equal
      source_1 = source_2;
    end
  else if (conditional == 4'b0010)
    begin
      //Greater than
      source_1 > source_2
    end
  else if (conditional == 4'b0011)
    begin
      //Less than
      source_1 < source_2;
    end
  else if (conditional == 4'b0100)
    begin
      //Greater than or equal to
      source_1 >= source_2
    end
  else if (conditional == 4'b0101)
    begin
      //Less than or equal to
      source_1 =< source_2
    end
  else if (conditional == 4'b0110)
    begin
      //Unsigned higher
      if (source_1 - source_2 > 0)
        $unsigned(source_1);
      else if (source_2 - source_1 > 0)
        $unsigned(source_2);
    end
  else if (conditional == 4'b0111)
    begin
      //unsigned lower
      if (source_1 - source_2 > 0)
        $unsigned(source_2);
      else if (source_2 - source_1 > 0)
        $unsigned(source_1);
    end
  else if (conditional == 4'b1000)
    begin
      //unsigned higher or same
      if (source_1 - source_2 > 0)
        $unsigned(source_1);
      else if (source_2 - source_1 > 0)
        $unsigned(source_2);
      else if (source_2 - source_1 = 0)
        $unsigned(source_2, source_1);      
    end
  else
    begin
      //dont care/error
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
  
  //MOV
  
  //LDR
  
  //NOP
  
  //STR
  
  //ADR
