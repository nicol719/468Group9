//Register Bank Testbench

//---------------------------
// Test entire Register bank
//---------------------------
module test_register_bank;
	reg [3:0] Destination_t, Source1_ADDR_t, Source2_ADDR_t;
	reg [31:0] LDR_MUX_t;
	wire [31:0] Source1_t, Source2_t;
	
	register_bank test_bank(Destination_t, Source1_ADDR_t, Source2_ADDR_t, LDR_MUX_t, Source1_t, Source2_t);
	
	initial
	begin
	//rest of test cases here
	//#5 ...
	//#5 ...
	end	
endmodule

//----------------------
// Test 4 to 16 decoder
//----------------------
module test_decoder_4to16;
	reg [3:0] Input_t;
	wire [15:0] Output_t;
	
	decoder_4to16 test_decoder(Input_t, Output_t);
	
	initial
	begin
	//rest of test cases here
	//#5 ...
	//#5 ...
	end	
endmodule

//---------------------
// Test 32bit register
//---------------------
module test_register_32bit;
	reg Enable_t;
	reg [31:0] Input_t;
	wire [31:0] Output_t;
	
	register_32bit test_register(Enable_t, Input_t, Output_t);
	
	initial
	begin
	//rest of test cases here
	//#5 ...
	//#5 ...
	end	
endmodule

//---------------
// Test 16x1 mux
//---------------
module test_mux_16x1;
	reg [3:0] Select_t;
	reg [15:0] [31:0] Input_t; //Should be reviewed. I'm not sure if this is how to do this.
	wire [31:0] Output_t;
	
	mux_16x1 test_mux(Select_t, Input_t, Output_t);
	
	initial
	begin
	//rest of test cases here
	//#5 ...
	//#5 ...
	end	
endmodule