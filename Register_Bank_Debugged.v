// Register Bank Here
// by KS

//++ Top level reg_bank so submodules can be wired together
module reg_bank_toplevel(destination, LDR_mux, source_1_sel, source_2_sel, source_1, source_2);
	//++ Top level inputs
	input [3:0] destination;
	input [31:0] LDR_mux;
	input [3:0] source_1_sel, source_2_sel;
	
	//++ Top level outputs
	output [31:0] source_1, source_2;
	
	//++ Sub module wires
	wire en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15;
	wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15;
	
	//++ Sub module calls
	decoder4_16 reg_decoder(en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15,
							destination);
	reg_bank reg_bank_called(q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15,
							en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15,
							LDR_mux);
	//++ mux gets duplicated here
	mux_16to1R mux1(source_1, source_1_sel,
					q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15);
	mux_16to1R mux2(source_2, source_2_sel,
					q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15);
endmodule

// 4x16 bit decoder



// Multiplexer 1 taking select from Source 1
//++ only need one 16to1 mux definition
module mux_16to1R(source_1, source_1_sel, q0, q1, q2, q3, q4, q5, q6, q7,
              q8, q9, q10, q11, q12, q13, q14, q15);		
input [31:0] q0, q1, q2, q3, q4, q5, q6, q7;
input [31:0] q8, q9, q10, q11, q12, q13, q14, q15;							            // q0-q15 is the output of the register bank, 16 registers of 32-bits each
input [3:0] source_1_sel;						                                        // this is the select coming from the 4-bits of Source 2 from the original 32-bit input
output [31:0] source_1;	
reg [31:0] source_1;					                                         // source_2 is the output of the mux, which is also the 2nd input to the ALU
/*wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7;
            q8, q9, q10, q11, q12, q13, q14, q15, source_1;
  wire [3:0] source_1_sel;*/

  always @ (source_1_sel,
			q0, q1, q2, q3, q4, q5, q6, q7,
            q8, q9, q10, q11, q12, q13, q14, q15)
  begin
    case (source_1_sel)                                                    // case for every select and corresponding source_2 output 
 
		4'b0000 : source_1 = q0;
		4'b0001 : source_1 = q1;
		4'b0010 : source_1 = q2;
		4'b0011 : source_1 = q3;
		4'b0100 : source_1 = q4;
		4'b0101 : source_1 = q5;
		4'b0110 : source_1 = q6;
		4'b0111 : source_1 = q7;
		4'b1000 : source_1 = q8;
		4'b1001 : source_1 = q9;
		4'b1010 : source_1 = q10;
		4'b1011 : source_1 = q11;
		4'b1100 : source_1 = q12;
		4'b1101 : source_1 = q13;
		4'b1110 : source_1 = q14;
		4'b1111 : source_1 = q15;
		default : source_1 = 'z; 
    endcase
  end
endmodule //mux_16to1


// Multiplexer 2 taking select from Source 2
/// fjdsghgokdsjfhg
/*module mux_2 (source_2, source_2_sel, q0, q1, q2, q3, q4, q5, q6, q7
              q8, q9, q10, q11, q12, q13, q14, q15);		
input [31:0] q0, q1, q2, q3, q4, q5, q6, q7
             q8, q9, q10, q11, q12, q13, q14, q15;							            // q0-q15 is the output of the register bank, 16 registers of 32-bits each
input [3:0] source_2_sel;						                                        // this is the select coming from the 4-bits of Source 2 from the original 32-bit input
output [31:0] source_2;						                                         // source_2 is the output of the mux, which is also the 2nd input to the ALU
wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7
            q8, q9, q10, q11, q12, q13, q14, q15, source_2;
wire [3:0] source_2_sel;

  always @ (source_2_sel);
  begin
    case (source_2_sel)                                                    // case for every select and corresponding source_2 output 
  
4’b0000 : source_2 = q0;
4’b0001 : source_2 = q1;
4’b0010 : source_2 = q2;
4’b0011 : source_2 = q3;
4’b0100 : source_2 = q4;
4’b0101 : source_2 = q5;
4’b0110 : source_2 = q6;
4’b0111 : source_2 = q7;
4’b1000 : source_2 = q8;
4’b1001 : source_2 = q9;
4’b1010 : source_2 = q10;
4’b1011 : source_2 = q11;
4’b1100 : source_2 = q12;
4’b1101 : source_2 = q13;
4’b1110 : source_2 = q14;
4’b1111 : source_2 = q15;
default : source_2 = 'z;        
    endcase
  end
endmodule*/

//++ Added single register module for granularity
module reg32(en,q,data_in);
	input en;
	input [31:0] data_in;
	output [31:0] q;
	reg [31:0] q;
	
	always @ (en, data_in)
	begin
			if(en && !(data_in === 'z))
				q = data_in;
	end
endmodule //reg32

// register bank

module reg_bank (q0, q1, q2, q3, q4, q5, q6, q7,
                 q8, q9, q10, q11, q12, q13, q14, q15, 
                 en0, en1, en2, en3, en4, en5, en6, en7,
				 en8, en9, en10, en11, en12, en13, en14, en15,
				 ldr_in);

input en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15;								      // this is the enable for the register
input [31:0] ldr_in;									        // this is the load command from the LDR Mux
output [31:0] q0, q1, q2, q3, q4, q5, q6, q7;
output [31:0] q8, q9, q10, q11, q12, q13, q14, q15;

//++ Single register calls
reg32 r0(en0,q0,ldr_in);
reg32 r1(en1,q1,ldr_in);
reg32 r2(en2,q2,ldr_in);
reg32 r3(en3,q3,ldr_in);
reg32 r4(en4,q4,ldr_in);
reg32 r5(en5,q5,ldr_in);
reg32 r6(en6,q6,ldr_in);
reg32 r7(en7,q7,ldr_in);
reg32 r8(en8,q8,ldr_in);
reg32 r9(en9,q9,ldr_in);
reg32 r10(en10,q10,ldr_in);
reg32 r11(en11,q11,ldr_in);
reg32 r12(en12,q12,ldr_in);
reg32 r13(en13,q13,ldr_in);
reg32 r14(en14,q14,ldr_in);
reg32 r15(en15,q15,ldr_in);
endmodule //reg_bank
/*
reg [31:0] q0, q1, q2, q3, q4, q5, q6, q7
q8, q9, q10, q11, q12, q13, q14, q15;

reg [31:0] mem [0:15];

  always @ (decode_out, ldr_in)
begin
  case (decode_out)									            // read individual registers from each enable (decode_out) value
16’h0 : q0 = mem[ldr_in];
16’h1 : q1 = mem[ldr_in];
16’h2 : q2 = mem[ldr_in];
16’h3 : q3 = mem[ldr_in];
16’h4 : q4 = mem[ldr_in];
16’h5 : q5 = mem[ldr_in];
16’h6 : q6 = mem[ldr_in];
16’h7 : q7 = mem[ldr_in];
16’h8 : q8 = mem[ldr_in];
16’h9 : q9 = mem[ldr_in];
16’hA : q10 = mem[ldr_in];
16’hB : q11 = mem[ldr_in];
16’hC : q12 = mem[ldr_in];
16’hD : q13 = mem[ldr_in];
16’hE : q14 = mem[ldr_in];
16’hF : q15 = mem[ldr_in];
  
endcase
end
endmodule*/

module decoder4_16(en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15,
					dest_in); 	// 4bit destination name can be changed, I am using dest_in for now
input [3:0] dest_in;									
//output [15:0] (decode_out);				        // this is the enable for the registers
output en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15;
reg en0, en1, en2, en3, en4, en5, en6, en7, en8, en9, en10, en11, en12, en13, en14, en15;
always @ (dest_in)
begin
case (dest_in)
//++ Enables need to be "One hot"							              // creating all 16 combinations in Hexadecimal
4'b0000 : begin
			en0 <= 1;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0001 : begin
			en0 <= 0;
			en1 <= 1;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0010 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 1;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0011 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 1;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0100 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 1;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0101 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 1;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0110 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 1;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b0111 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 1;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b1000 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 1;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b1001 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 1;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b1010 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 1;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b1011 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 1;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b1100 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 1;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end
4'b1101 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 1;
			en14 <= 0;
			en15 <= 0;
		end
4'b1110 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 1;
			en15 <= 0;
		end
4'b1111 : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 1;
		end
default : begin
			en0 <= 0;
			en1 <= 0;
			en2 <= 0;
			en3 <= 0;
			en4 <= 0;
			en5 <= 0;
			en6 <= 0;
			en7 <= 0;
			en8 <= 0;
			en9 <= 0;
			en10 <= 0;
			en11 <= 0;
			en12 <= 0;
			en13 <= 0;
			en14 <= 0;
			en15 <= 0;
		end				  // creating default input so latches are not created
endcase
end
endmodule