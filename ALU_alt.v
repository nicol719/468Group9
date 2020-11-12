//================
//ALU Main Module
//================
module ALU_alt (OP_Code, source_1, source_2, conditional, S, Result, flags, immediate_value);
  
    input [31:0] source_1, source_2; //16 bit source registers 1 and 2
    input [3:0] OP_Code, conditional; //op code and conditional flags at 4 bits each
	input [15:0] immediate_value; //16 bits, used for 'n' operations 
    input S; //this might be sign bit when it is one the input is signed, it will set flags when it is equal to one (bit 23 of the instructions)
    
    output [31:0] Result; //32 bit output
    output [3:0] flags; //4 flag bits order: N Z C V
	
	//Submodule to mux wires
	wire [31:0] out_shift_right, out_shift_left, out_rotate_right;
	wire [31:0] out_LDR, out_NOP, out_STR;
	wire [31:0] out_MOV1, out_MOV2, out_ADR;
    
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
	
	//Mux Call
	mux_16to1 alu_mux_16to1( 
				  OP_Code,  //Select is OPCODE
				  32'b0,  //Output of add module (set to 0s untill built)
				  32'b0,  //Output of sub module (set to 0s untill built)
				  32'b0,  //Output of mul module (set to 0s untill built)
				  32'b0,  //Output of or module (set to 0s untill built)
				  32'b0,  //Output of and module (set to 0s untill built)
				  32'b0,  //Output of eor module (set to 0s untill built)
				  out_MOV1, //Output of 1st move module
				  out_MOV2, //Output of 2nd move module
				  out_shift_right, //Output of right shift module
				  out_shift_left, //Output of left shift module
				  out_rotate_right, //Output of rotate right module
				  32'b0,  //Output of cmp module (set to 0s untill built)
				  out_ADR,  //Output of adr module
				  out_LDR,  //Output of ldr module
				  out_STR,  //Output of str module
				  out_NOP,  //Output of nop module
				  Result);  //ALU Result
	
	
 
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