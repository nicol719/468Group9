// Register Bank Here
// Register Bank consists of a 4 to 16 decoder, 16 32-bit registers, and 2 32-bit 16 x 1 mux's

module register_bank(Destination, Source1_ADDR, Source2_ADDR, LDR_MUX, Source1, Source2);
	input [3:0] Destination, Source1_ADDR, Source2_ADDR;
	input [31:0] LDR_MUX;
	output [31:0] Source1, Source2;
	//rest of register bank code here. need 16 instances of registers, 2 muxes, and 1 decoder
endmodule

module decoder_4to16(Input, Output); //(Destination, [en0...en15])
	input [3:0] Input;
	output [15:0] Output;
	//decoder code goes here (probably just cases)
endmodule

module register_32bit(Enable, Input, Output); //(en0 or en1 ... or en15, LDR_MUX, Q0 or Q1 or ... Q15)
	input Enable;
	input [31:0] Input;
	output [31:0] Output;
	//register code goes here (if enable, Q = LDR_MUX)
endmodule

module mux_16x1(Select, Input, Output); //(Source1_ADDR or Source2_ADDR, [Q0...Q15], Source1 or Source2)
	input [3:0] Select;
	input [15:0] [31:0] Input; //Should be reviewed. I'm not sure if this is how to do this.
	output [31:0] Output;
	//mux code goes here
endmodule