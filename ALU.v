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
	
	// Op code case statements live in the mux.
	// I think we can run run all modules in parallel
	// and then just mux the correct result based on opcode. -GN
	
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
module N_bit_adder(input1,input2,answer);
parameter N=32;
input [N-1:0] input1,input2;
   output [N-1:0] answer;
   wire  carry_out;
  wire [N-1:0] carry;
   genvar i;
   generate 
   for(i=0;i<N;i=i+1)
     begin: generate_N_bit_Adder
   if(i==0) 
  half_adder f(input1[0],input2[0],answer[0],carry[0]);
   else
  full_adder f(input1[i],input2[i],carry[i-1],answer[i],carry[i]);
     end
  assign carry_out = carry[N-1];
   endgenerate
endmodule 

// Verilog code for half adder 
module half_adder(x,y,s,c);
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule // half adder

// Verilog code for full adder 
module full_adder(x,y,c_in,s,c_out);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder

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
// It says it should be a register, but I don't see why it would need to be or how a register would be any different
module shift_right(source_1, number_bits, out); 
	input [31:0] source_1;
	input [4:0] number_bits; // 5-bit shift section from immediate value (see project discription)
	output [31:0] out;
	
    assign out = source_1 >> number_bits;   
	
endmodule

//==================
// parameterized 32-bit left shift register that shifts the input by n-bit
// By GN
//=================
module shift_left(source_1, number_bits, out);
	input [31:0] source_1;
	input [4:0] number_bits; // 5-bit shift section from immediate value (see project discription)
	output [31:0] out;
	
    assign out = source_1 << number_bits;   
	
endmodule

//==================
// parameterized 32-bit register that right rotates the input by n-bit
// By GN
//=================
module rotate_right(source_1, number_bits, out);
	input [31:0] source_1;
	input [4:0] number_bits; // 5-bit shift section from immediate value (see project discription)
	output [31:0] out;
	reg [63:0] tmp;
	
	assign tmp = {source_1, source_1} >> number_bits;
    assign out = tmp[31:0];   
	
endmodule

//==================
// A 32-line 16x1 Multiplexer (each input/output is an 32-bit wide)
// By GN
//=================
module mux_16to1( 
				  select,  //Select is OPCODE
				  ADD,  //Output of add module
				  SUB,  //Output of sub module
				  MUL,  //Output of mul module
				  ORR,  //Output of or module
				  AND,  //Output of and module
				  EOR,  //Output of eor module
				  MOV1, //Output of 1st move module
				  MOV2, //Output of 2nd move module
				  LSR, //Output of right shift module
				  LSL, //Output of left shift module
				  ROR, //Output of rotate right module
				  CMP,  //Output of cmp module
				  ADR,  //Output of adr module
				  LDR,  //Output of ldr module
				  STR,  //Output of str module
				  NOP,  //Output of nop module
				  out); //Is the result of the ALU
	
	input [31:0] ADD,SUB, MUL, ORR, AND, EOR, MOV1, MOV2, LSR, LSL, ROR, CMP, ADR, LDR, STR, NOP;
	input [3:0] select;
	output reg [31:0] out;
	
	always @ (select or ADD or SUB or MUL or ORR or AND or EOR or MOV1 or MOV2 or LSR or LSL or ROR or CMP or ADR or LDR or STR or NOP)
	begin
		case (select)
			4'b0000:begin //ADD
						out <= ADD;
					end
			4'b0001:begin // SUB R1, R2, R3
						out <= SUB;
					end
			4'b0010:begin // MUL R1, R2, R3
						out <= MUL;
					end
			4'b0011:begin // ORR R1, R2, R3
						out <= ORR;
					end
			4'b0100:begin // AND R1, R2, R3
						out <= AND;
					end
			4'b0101:begin // EOR R1, R2, R3
						out <= EOR;
					end
			4'b0110:begin // MOV R1, n
						out <= MOV1;
					end
			4'b0111:begin // MOV R1, R2
						out <= MOV2;
					end
			4'b1000:begin // MOV R1, R2, LSR #n
						out <= LSR;
					end
			4'b1001:begin // MOV R1, R2, LSL #n
						out <= LSL;
					end
			4'b1010:begin // MOV R1, R2, ROR #n
						out <= ROR;
					end
			4'b1011:begin // CMP R1, R2
						out <= CMP;
					end
			4'b1100:begin // ADR R1, n
						out <= ADR;
					end
			4'b1101:begin // LDR R2, [R1]
						out <= LDR;
					end
			4'b1110:begin // STR R2, [R1]
						out <= STR;
					end
			4'b1111:begin // NOP
						out <= NOP;					
					end
			default:begin
						out <= NOP; //Should be fine to default to NOP
					end
			
		endcase
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
module LDR(out);
	output [31:0] out;
	assign out = 'z;
endmodule

//==================
// NOP
// No outpt is expected from ALU
// By GN
//=================
module NOP(out);
	output [31:0] out;
	assign out = 'z;
endmodule

//==================
// MOV1
// Initialize R1 with an immediate number n
// By GN
//=================
module MOV1(immediate_value, out);
	input [15:0] immediate_value;
	output [31:0] out;
	assign out = immediate_value;
endmodule

//==================
// MOV2
// Send Source1 to memory access block so it can be loaded into the register
// By GN
//=================
module MOV2(source_1, out);
	input [31:0] source_1;
	output [31:0] out;
	assign out = source_1;
endmodule

//==================
// STR
// No outpt is expected from ALU
// By GN
//=================
module STR(out);
	output [31:0] out;
	assign out = 'z;
endmodule
  
//==================
// ADR
// Initialize R1 with an immediate address n
// By GN
//=================
module ADR(immediate_value, out);
	input [15:0] immediate_value;
	output [31:0] out;
	assign out = immediate_value;
endmodule
