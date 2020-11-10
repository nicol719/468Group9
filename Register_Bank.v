// Register Bank Here
// 4x16 bit decoder

module decoder4_16(decode_out, dest_in); 	// 4bit destination name can be changed, I am using dest_in for now
input [3:0] (dest_in);									
output [15:0] (decode_out);				// this is the enable for the registers
reg [15:0] (decode_out);

always @ (dest_in)
begin
case (dest_in)							// creating all 16 combinations in Hexadecimal
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
default : decode_out = 16'h0; 				// creating default input so latches are not created
endcase
end
endmodule

// Multiplexer 1 taking select from Source 1

module mux_1 (source_1, source_1_sel, q);		
input [31:0] q;								// q is the output of the register bank, 16 registers of 32-bits each
input [3:0] source_1_sel;						// this is the select coming from the 4-bits of Source 1 from the original 32-bit input
output [31:0] source_1;						// source_1 is the output of the mux, which is also the 1st input to the ALU
wire [31:0] q, source_1;
wire [3:0] source_1_sel;

assign source_1 = q[source_1_sel];				// if source_1_sel = 0000, output will be q[1] (in hex) and so forth

endmodule


// Multiplexer 2 taking select from Source 2

module mux_2 (source_2, source_2_sel, q);		
input [31:0] q;								// q is the output of the register bank, 16 registers of 32-bits each
input [3:0] source_2_sel;						// this is the select coming from the 4-bits of Source 2 from the original 32-bit input
output [31:0] source_2;						// source_2 is the output of the mux, which is also the 2nd input to the ALU
wire [31:0] q, source_2;
wire [3:0] source_2_sel;

assign source_2 = q[source_2_sel];				// if source_2_sel = 0000, output will be q[1] (in hex) and so forth

endmodule
