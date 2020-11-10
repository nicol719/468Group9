// ALU Testbench

//================
//ALU Main Module
//================
// Code here


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