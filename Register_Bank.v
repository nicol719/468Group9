// Register Bank Here
// by KS

// 4x16 bit decoder

module decoder4_16(decode_out, dest_in); 	// 4bit destination name can be changed, I am using dest_in for now
input [3:0] (dest_in);									
output [15:0] (decode_out);				        // this is the enable for the registers
reg [15:0] (decode_out);

always @ (dest_in)
begin
case (dest_in)							              // creating all 16 combinations in Hexadecimal
4’b0000 : decode_out = 16’h0;
4’b0001 : decode_out = 16’h1;
4’b0010 : decode_out = 16’h2;
4’b0011 : decode_out = 16’h3;
4’b0100 : decode_out = 16’h4;
4’b0101 : decode_out = 16’h5;
4’b0110 : decode_out = 16’h6;
4’b0111 : decode_out = 16’h7;
4’b1000 : decode_out = 16’h8;
4’b1001 : decode_out = 16’h9;
4’b1010 : decode_out = 16’hA;
4’b1011 : decode_out = 16’hB;
4’b1100 : decode_out = 16’hC;
4’b1101 : decode_out = 16’hD;
4’b1110 : decode_out = 16’hE;
4’b1111 : decode_out = 16’hF;
default : decode_out = 16'h0; 				  // creating default input so latches are not created
endcase
end
endmodule

// Multiplexer 1 taking select from Source 1

module mux_1 (source_1, source_1_sel, q0, q1, q2, q3, q4, q5, q6, q7
              q8, q9, q10, q11, q12, q13, q14, q15);		
input [31:0] q0, q1, q2, q3, q4, q5, q6, q7
             q8, q9, q10, q11, q12, q13, q14, q15;							            // q0-q15 is the output of the register bank, 16 registers of 32-bits each
input [3:0] source_1_sel;						                                        // this is the select coming from the 4-bits of Source 2 from the original 32-bit input
output [31:0] source_1;						                                         // source_2 is the output of the mux, which is also the 2nd input to the ALU
wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7
            q8, q9, q10, q11, q12, q13, q14, q15, source_1;
  wire [3:0] source_1_sel;

  always @ (source_1_sel);
  begin
    case (source_1_sel)                                                    // case for every select and corresponding source_2 output 
  
4’b0000 : source_1 = q0;
4’b0001 : source_1 = q1;
4’b0010 : source_1 = q2;
4’b0011 : source_1 = q3;
4’b0100 : source_1 = q4;
4’b0101 : source_1 = q5;
4’b0110 : source_1 = q6;
4’b0111 : source_1 = q7;
4’b1000 : source_1 = q8;
4’b1001 : source_1 = q9;
4’b1010 : source_1 = q10;
4’b1011 : source_1 = q11;
4’b1100 : source_1 = q12;
4’b1101 : source_1 = q13;
4’b1110 : source_1 = q14;
4’b1111 : source_1 = q15;
default : source_1 = q0; 
    endcase
  end
endmodule


// Multiplexer 2 taking select from Source 2

module mux_2 (source_2, source_2_sel, q0, q1, q2, q3, q4, q5, q6, q7
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
default : source_2 = q0; 
    endcase
  end
endmodule


// register bank

module reg_bank (q0, q1, q2, q3, q4, q5, q6, q7
                 q8, q9, q10, q11, q12, q13, q14, q15, 
                 decode_out, ldr_in);

input [15:0] decode_out;								      // this is the enable for the register
input [31:0] ldr_in;									        // this is the load command from the LDR Mux
output [31:0] q0, q1, q2, q3, q4, q5, q6, q7
q8, q9, q10, q11, q12, q13, q14, q15;

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
  default : q0 = mem[ldr_in]; 
endcase
end
endmodule
