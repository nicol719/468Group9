//Memory Access Block Here
//
// Instruction			Description													Op Code		Memory Access Block's Job
// ADD R1, R2, R3		(R1=R2+R3)													0000		Send ALU Result to LDR
// SUB R1, R2, R3		(R1=R2-R3)													0001		Send ALU Result to LDR
// MUL R1, R2, R3  		(R1=R2*R3) (assume the result is 32-bit maximum)			0010		Send ALU Result to LDR
// ORR R1, R2, R3		(R1=R2 OR R3)												0011		Send ALU Result to LDR
// AND R1, R2, R3		(R1=R2 AND R3)												0100		Send ALU Result to LDR
// EOR R1, R2, R3		(R1=R2 XOR R3)												0101		Send ALU Result to LDR
// MOV R1, n			Initialize R1 with an immediate number n, 0 <= n<= (2^16−1)	0110		Send ALU Result to LDR
// MOV R1, R2			Copy R2 to R1												0111		Send ALU Result to LDR Send Source1 to LDR (need to verify if source 1 or source 2), (might be easier to just send source 1 through ALU and take it as result)
// MOV R1, R2, LSR #n	(R1=R2 >>n),  1 <= n<= 31									1000		Send ALU Result to LDR
// MOV R1, R2, LSL #n	(R1=R2 <<n), 1 <= n<= 31									1001		Send ALU Result to LDR
// MOV R1, R2, ROR #n	(R1=Rotate right R2 by n-bit) , 1 <= n<= 31					1010		Send ALU Result to LDR
// CMP R1, R2			Compare R1 with R2 and set the status flags 				1011		Do Nothing
// ADR R1, n			Initialize R1 with a 16-bit address n, 0 <= n<= (2^16−1)	1100		Send ALU Result to LDR 
// LDR R2, [R1]			Load R2 with the contents at memory address R1				1101		Load data from ram at address(Source1), send loaded data to LDR
// STR R2, [R1]			Store R2 at memory address R1								1110		Store data Source2 at ram address(Source1)
// NOP					No Operation -Skip this instruction							1111		Do Nothing
//

// by GN
module memory_access_block(DataIn, DataOut, ReadWrite, Address, LDR, Source1, Source2, Result, OpCode, PCInstruction);
	input [3:0] OpCode;
	input [15:0] PCInstruction;
	input [31:0] Source1, Source2, Result, DataIn;
	output ReadWrite
	output [15:0] Address;
	output [31:0] DataOut, LDR;
	//todo: declare wires
	wire [31:0] alu_to_ldr
	
	always @ (OpCode)
	begin
		case (OpCode)
			4'b0000: begin
						// Case statement here
					end
			4'b0001:begin
						// Case statement here
					end
			4'b0010:begin
						// Case statement here
					end
			4'b0011:begin
						// Case statement here
					end
			4'b0100:begin
						// Case statement here
					end
			4'b0101:begin
						// Case statement here
					end
			4'b0110:begin
						// Case statement here
					end
			4'b0111:begin
						// Case statement here
					end
			4'b1000:begin
						// Case statement here
					end
			4'b1001:begin
						// Case statement here
					end
			4'b1010:begin
						// Case statement here
					end
			4'b1011:begin
						// Case statement here
					end
			4'b1100:begin
						// Case statement here
					end
			4'b1101:begin
						// Case statement here
					end
			4'b1110:begin
						// Case statement here
					end
			4'b1111:begin
						// Case statement here
					end
			
		endcase
	end
	// memory access block code here
	// mostly case statements based on op code
	// Will need a 16 bit 2x1 mux and a 32 bit 2x1 mux

endmodule


// 2 by 1 mux by GN
module mux_2by1(Select, In1, In2, Out);
	parameter width = 32;
	input Select;
	input [width-1:0] In1, In2;
	output [width-1:0] Out; 

	assign out = Select ? In1: In0;
endmodule