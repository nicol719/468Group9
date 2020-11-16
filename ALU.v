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

module ALU (OP_Code, source_1, source_2, immediate_value, conditional, S, Result, flags);
  
    input [31:0] source_1, source_2; //16 bit source registers 1 and 2
    input [3:0] OP_Code, conditional; //op code and conditional flags at 4 bits each
	input [15:0] immediate_value; //16 bits, used for 'n' operations 
    //cond_result is the output of a conditional statement for ease of passing to the flags module as result_input
	input S; //bit 23 of instruction, used as wanting a flag output from a non CMP operation
    wire cond_result; //temporary variable for condition result
    wire count; //for the program counter might need to be initialized		
    output [31:0] Result; //32 bit output
    output [3:0] flags; //4 flag bits order: N Z C V
	
	//Submodule to mux wires
	wire [31:0] out_shift_right, out_shift_left, out_rotate_right;
	wire [31:0] out_LDR, out_NOP, out_STR;
	wire [31:0] out_MOV1, out_MOV2, out_ADR;
	wire [31:0] out_ADD, out_SUB, out_MUL;
	wire [31:0] out_ORR, out_AND, out_XOR;
	//Todo: add output wires for other modules
    
    //Submodule calls
	shift_right alu_shift_right(source_1,immediate_value[7:3],out_shift_right); //Rotate/shift only needs these 5 bits from immediate value
	shift_left alu_shift_left(source_1,immediate_value[7:3],out_shift_left);
	rotate_right alu_rotate_right(source_1, immediate_value[7:3], out_rotate_right);
	LDR alu_LDR(out_LDR);
	NOP alu_NOP(out_NOP);
	STR alu_STR(out_STR);
	MOV1 alu_MOV1(immediate_value, out_MOV1); // need entire immediate_value here
	MOV2 alu_MOV2(source_1, out_MOV2);
	ADR alu_ADR(immediate_value, out_ADR);
	ADD alu_ADD(out_ADD, source_1, source_2);
	SUB alu_SUB(source_1, source_2, out_SUB);
	MUL alu_MUL(source_1, source_2, out_MUL);
	bit_OR alu_bit_OR(source_1, source_2, out_ORR);
	bit_AND alu_bit_AND(source_1, source_2, out_AND);
	bit_XOR alu_bit_XOR(source_1, source_2, out_XOR);
	//flag alu_flag(S, Result, ) // Need to figure this one out
	
	//conditional checks
	
//4 flag bits order: N Z C V
//here i am using the exact bits isntead of an overall value for the flags since the rest of the bits are not tested for the conditions
	if (conditional == 4'b0001) //silverfish wrote this
    begin
      //Equal
	    if (flags[2] == 1)
		assign cond_result = 1;
	    else assign cond_result = 0;

    end
else if (conditional == 4'b0010)
    begin
      //Greater than
	    if ((flags[2] = 0) && (flags[3] == flags[0])) //if Z==0 and N = V
		assign cond_result = 1;
	    else assign cond_result = 0;
      
    end
else if (conditional == 4'b0011)
    begin
      //Less than
	    if (flags[3] != flags[0]) //N!=V
		assign cond_result = 1;
	    else assign cond_result = 0;
      
    end
else if (conditional == 4'b0100)
    begin
      //Greater than or equal to
	    if (flags[3] == flags[0]) //N==V
		assign cond_result = 1;
	    else assign cond_result = 0;
     
    end
else if (conditional == 4'b0101)
    begin
      //Less than or equal to
	    if ((flags[2] == 1) || (flags[3] != flags[0])) //Z=1 or N!=V
		assign cond_result = 1;
	    else assign cond_result = 0;
     
    end
else if (conditional == 4'b0110)
    begin
      //Unsigned higher
	    if ((flags[1] == 1) && (flags[2] == 0)) //C=1 and Z=0
		assign cond_result = 1;
	    else assign cond_result = 0;
	    
   
    end
else if (conditional == 4'b0111)
    begin
      //unsigned lower
	    if (flags[1] == 0) //C=0
		assign cond_result = 1;
	    else assign cond_result = 0;
     
    end
else if (conditional == 4'b1000)
    begin
      //unsigned higher or same
	    if (flags[1] == 1) //C=1
		assign cond_result = 1;
	    else assign cond_result = 0;
    end    
else
    begin
      assign cond_result = 1;
    end
	
	
	//TODO: we need to check conditional before executing this always since any instruction could have a condition put onto it although the first instruction will be clear 
	//Mux Call
if (count == 0);		      
	mux_16to1 alu_mux_16to1( 
				  OP_Code,  //Select is OPCODE
				  out_ADD,  //Output of add module 
				  out_SUB,  //Output of sub module 
				  out_MUL,  //Output of mul module 
				  out_ORR,  //Output of or module 
				  out_AND,  //Output of and module 
				  out_XOR,  //Output of eor module 
				  out_MOV1, //Output of 1st move module
				  out_MOV2, //Output of 2nd move module
				  out_shift_right, //Output of right shift module
				  out_shift_left, //Output of left shift module
				  out_rotate_right, //Output of rotate right module
				  32'bz,  //Output of cmp module no output required
				  out_ADR,  //Output of adr module
				  out_LDR,  //Output of ldr module
				  out_STR,  //Output of str module
				  out_NOP,  //Output of nop module
				  Result);  //ALU Result
	
	
			
			
	//Check for S flag and call CMP module afterwards to set flags
	if (S == 1)
		
		CMP cmp1(source_1, source_2, flags);
	else
		assign S = 0; //just putting something here to fill in empty ELSE
		
	
	
	
	/*  if (OP_Code == 4'b0000) //silverfish deprecated code
      begin
        ///ADD module
	ADD Result, source_1, source_2;
	      
      end
    else if (OP_Code == 4'b0001)
      begin
        //SUB module
	SUB Result, source_1, source_2;
      end
    else if (OP_Code == 4'b0010)
      begin
        //MUL module
	MUL Result, source_1, source_2;
      end
    else if (OP_Code == 4'b0011)
      begin
        //ORR module
	module OR_data ( output Result, input source_1, source_2 );
	       assign Result = source_1 | source_2;
	endmodule
		
      end
    else if (OP_Code == 4'b0100)
      begin
        //AND module
	module AND_data ( output Result, input source_1, source_2 );
	       assign Result = source_1 & source_2;
	endmodule
      end
    else if (OP_Code == 4'b0101)
      begin
        //EOR/XOR module
	module XOR_data ( output Result, input source_1, source_2 );
	       assign Result = source_1 ^ source_2;
	endmodule
      end
    else if (OP_Code == 4'b0110)
      begin
        //MOV R1, n Initializes R1 with an immediate value of n
	module MOVE_data (input source_1);
	assign source_1 = n;
	endmodule
      end
    else if (OP_Code == 4'b0111)
      begin
        //MOV R1 R2 copy R2 into R1
	module COPY_data (input source_2, output source_1)
      end
    else if (OP_Code == 4'b1000)
      begin
        //MOV R1 R2 LSR #n copy R2 into R1 shifted right by n
	MOV source_1, source_2, LSR #n;
      end
    else if (OP_Code == 4'b1001)
      begin
        //MOV R1 R2 LSL #n copy R2 into R1 shifted left by n
	MOV source_1, source_2, LSL #n;
      end
    else if (OP_Code == 4'b1010)
      begin
        //MOV R1 R2 Rotated Right by n bits
	MOV source_1, source_2, ROR #n;
      end
    else if (OP_Code == 4'b1011)
      begin
        //CMP R1 R2 compare R1 and R2 and set the status flags
	loop CMP source_1, source_2
	      
    
        
      end
    else if (OP_Code == 4'b1100)
      begin
        //ADR R1 with a 16 bit address n
	ADR source_1, #n;
      end
    else if (OP_Code == 4'b1101)
      begin
        //LDR R2 [R1] load R2 with the contents at memory address R1
	LDR source_2, [source_1];
      end
    else if (OP_Code == 4'b1110)
      begin
        //STR R2, [R1] Store R2's contents at memory address R1
	STR source_2, [source_1];
      end
    else if (OP_Code == 4'b1111)
      begin
        //NOP no operation, skip
      end
    else
      begin
        //retry perhaps? or perform a no operation? or print an error? this is here to prevent latching
      end*/
    
  //Check conditional codes
	//and set flags module flag(S, result_input, carry, source_1, source_2, add, sub, flags);
  //silverfish and Ji
 /* if (conditional == 4'b0000)
    begin
      //No condition
    end
	else if (conditional == 4'b0001)
    begin
      //Equal
	   assign cond_result = (source_1 == source_2);
	    
	    flag(1, cond_result, 0, source_1, source_2, 0, 0, flags);
    end
  else if (conditional == 4'b0010)
    begin
      //Greater than
      assign cond_result = source_1 > source_2;
	    flag(1, cond_result, 0, source_1, source_2, 0, 0, flags);
    end
  else if (conditional == 4'b0011)
    begin
      //Less than
      assign cond_result = source_1 < source_2;
	    flag(1, cond_result, 0, source_1, source_2, 0, 0, flags);
    end
  else if (conditional == 4'b0100)
    begin
      //Greater than or equal to
     assign cond_result = source_1 >= source_2;
	    flag(1, cond_result, 0, source_1, source_2, 0, 0, flags);
    end
  else if (conditional == 4'b0101)
    begin
      //Less than or equal to
     assign cond_result = source_1 <= source_2;
	    flag(1, cond_result, 0, source_1, source_2, 0, 0, flags);
    end
  else if (conditional == 4'b0110)
    begin
      //Unsigned higher
      if (source_1 - source_2 > 0)
        $unsigned(source_1);
	    flag(1, source_1, 0, 0, source_2, 0, 0, flags); //source_1 is set as the result_input to check the flags on it
      else if (source_2 - source_1 > 0)
        $unsigned(source_2);
	    flag(1, source_2, 0, source_1, 0, 0, 0, flags); //source_2 is set as the result_input
	    
    end
  else if (conditional == 4'b0111)
    begin
      //unsigned lower
      if (source_1 - source_2 > 0)
        $unsigned(source_2);
	    flag(1, source_2, 0, source_1, 0, 0, 0, flags); //source_2 is set as result_input
      else if (source_2 - source_1 > 0)
        $unsigned(source_1);
	    flag(1, source_1, 0, 0, source_2, 0, 0, flags); //source_1 is set as result_input
    end
  else if (conditional == 4'b1000)
    begin
      //unsigned higher or same
      if (source_1 - source_2 > 0)
        $unsigned(source_1);
	    flag(1, source_1, 0, 0, source_2, 0, 0, flags); //similar comment to above
      else if (source_2 - source_1 > 0)
        $unsigned(source_2);
	    flag(1, source_2, 0, source_1, 0, 0, 0, flags); //similar comment to above
      else if (source_2 - source_1 = 0)
        $unsigned(source_2, source_1);
	    flag(1, source_2, 0, source_1, 0, 0, 0, flags); //since the two are unsigned higher/same, call two flag one for each
	    flag(1, source_1, 0, 0, source_2, 0, 0, flags);
    end
  else
    begin
      //dont care/error
    end*/
	
	
	
	program_counter pc1(1, 0, count); //count up counter
  
  
  
  
  
  
  
  
    
    
    endmodule
//==================
//CMP module
//=================
//by silverfish
//this is attempting to replicate setting the flags using different 
module CMP(source_1, source_2, NZCV); //also use if the S bit is true it is essentially a CMP in ARM assembly
	//this will set our flags based on properties of the sources equal not equal etc. this can then be used to quickly check when given the conditional bits
	
	input [31:0] source_1, source_2;
	wire N,Z,C,V; //these are temporary "variables"
	wire temp; //temporary variable stored
	output [3:0] NZCV; //the flags this is the order in which this 4 bit number will store them
	//input [3:0] cond_code;
	//this compares in the style of the CMP operator in ARM assembly
	/*if (source_1 == source_2)
		assign Z = 1;
	else if (source_1 != source_2)
		assign Z = 0;
	else if (source_1 > source_2)
		begin
		//Assuming that our values is signed
		assign Z = 0;
		assign N = source_1 - source_2;
		assign V = N;
		end
	else if (source_1 < source_2)
		begin
			assign N = source_1 - source_2; //compare seems to subtract the two values so it checks if resulting sign is 1(-) or 0(+)
			assign V != N;
		end*/
	//based off actual ARM assembly it subtracts the two values temporarily then sets the flags, we can then use these flags to check the conditional codes are true or not above.
	assign temp = source_1 - source_2;
	
	if (|temp == 0) //reduction operator to check if all zeroes
		assign Z = 1;
	else assign Z = 1;
	if (//something for carry)
		assign C = 1;
	else assign C = 0;
		
	if (temp[31] = 1) //set negative bit
		assign N = 1;
	else assign N = 0;
	//overflow code for the compare	
	if(((source_1[31] == 1) && (source_2[31] == 0)) && temp[31] == 0)
		assign V = 1; //subtracting positive source 2 from negative source 1
	else if (((source_1[31] == 0) && (source_2[31] == 1)) && temp[31] == 1)
		assign V = 1; //subtracting negative source2 from positive source 1 and getting a negative result
	else
		assign V = 0;
		
		
		
	//output the flags as a 4 bit output	
	assign NZCV = {N,Z,C,V};	
		
	
	
		
	
	
	
	
	
			
			
		
	
	
		
	
				
	
		
	       
    
    
  

//==================
// 32-bit adder
//=================
//Code here
module ADD(Result, source_1, source_2);//Ji wrote this
	input [31:0] source_1, source_2;
	output [31:0] Result;

       assign Result = source_1 + source_2;
endmodule
//==================
 // 32-bit subtractor
 //=================
 //Code here
 module SUB(source_1, source_2, result); //Silverfish wrote this
 	input [31:0] source_1, source_2;
 	output [31:0] result;

 	assign result = source_1 - source_2;

 endmodule


//==================
// 32-bit multiplier
//=================
//Code here
module MUL(source_1, source_2, result); //Silverfish
	
	input [31:0] source_1, source_2;
	output [31:0] result;
	
	assign result = source_1 * source_2;
	
endmodule

//==================
// 32-bit bitwise ORing
//=================
//Code here

module bit_OR(source_1, source_2, result); //Silverfish
	
	input [31:0] source_1, source_2;
	output [31:0] result;
	
	assign result = source_1 | source_2;
endmodule

//==================
// 32-bit bitwise ANDing
//=================
//Code here
module bit_AND(source_1, source_2, result); //silverfish
	
	input [31:0] source_1, source_2;
	output [31:0] result;
	
	assign result = source_1 & source_2;
	
endmodule
	

//==================
// 32-bit bitwise XORing
//=================
//Code here
module bit_XOR(source_1, source_2, result); //Silverfish
	
	input [31:0] source_1, source_2;
	output [31:0] result;
	
	assign result = source_1 ^ source_2;
endmodule

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
		
//DEPRECATED		
/*module flag(S, result_input, carry, source_1, source_2, add, sub, flags); //Silverfish wrote this
	input S, C, add, sub;
	input [31:0] result_input, source_1, source_2; //the output from the module of choice
	output [3:0] flags; //the flags in the order of N Z C V
	reg[3:0] flags;
	
	if (S)
	begin
		assign flags[1] = C;
		
		if (result_input[31] == 1)
			assign flags[3] = 1;
		if (|result_input == 0)
			assign flags[2] = 1;
		if(add) //overflow checks
			begin
				if(((source_1[31] == 0) && (source_2[31] == 0)) && result_input[31] == 1)
					assign flags[0] = 1; //add two positives and get negative result
				else if (((source_1[31] == 1) && (source_2[31] == 1)) && result_input[31] == 0)
					assign flags[0] = 1; //add two negatives and get positive result
				else
					assign flags[0] = 0;
			end
		else if (sub)
			begin
				if(((source_1[31] == 1) && (source_2[31] == 0)) && result_input[31] == 0)
					assign flags[0] = 1; //subtracting positive source 2 from negative source 1
				else if (((source_1[31] == 0) && (source_2[31] == 1)) && result_input[31] == 1)
					assign flags[0] = 1; //subtracting negative source2 from positive source 1 and getting a negative result
				else
					assign flags[0] = 0;
			end
		else
			assign flags[0] = 0;
	end
	else
		assign flags = 4'b0;
endmodule*/
				
		
		
		
	
	

//==================
// 8-bit Counter (Program Counter (PC))
//=================
//this should update at the edge of the fetch cycle
module program_counter(clock, reset, count); //Silverfish wrote this
	input clock, reset;
	output reg [7:0] count;
	always @(posedge clock) //the trigger will be at the end of the instruction fetch which will increment this counter by 1
		begin
			if (!reset)
				count <= 8'b0;
			else
				count <= count+1;
		end
endmodule
		

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
