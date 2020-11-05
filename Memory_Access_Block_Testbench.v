// Memory Access Block Testbench

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
	//rest of test cases here
	//#5 ...
	//#5 ...
	end	
endmodule

module test_mux_2by1;
	reg Select_t;
	reg [31:0] In1_t, In2_t;
	wire [31:0] Out_t;
	
	mux_2by1(Select_t, In1_t, In2_t, Out_t);
	
	initial
	begin
	//rest of test cases here
	//#5 ...
	//#5 ...
	end
endmodule	