//Memory Access Block Here
//
// Instruction			Description													Op Code		Memory Access Block's Job
// ADD R1, R2, R3		(R1=R2+R3)													0000		Send ALU alu_result to LDR
// SUB R1, R2, R3		(R1=R2-R3)													0001		Send ALU alu_result to LDR
// MUL R1, R2, R3  		(R1=R2*R3) (assume the alu_result is 32-bit maximum)			0010		Send ALU alu_result to LDR
// ORR R1, R2, R3		(R1=R2 OR R3)												0011		Send ALU alu_result to LDR
// AND R1, R2, R3		(R1=R2 AND R3)												0100		Send ALU alu_result to LDR
// EOR R1, R2, R3		(R1=R2 XOR R3)												0101		Send ALU alu_result to LDR
// MOV R1, n			Initialize R1 with an immediate number n, 0 <= n<= (2^16−1)	0110		Send ALU alu_result to LDR
// MOV R1, R2			Copy R2 to R1												0111		Send ALU alu_result to LDR Send source_1 to LDR (need to verify if source 1 or source 2), (might be easier to just send source 1 through ALU and take it as alu_result)
// MOV R1, R2, LSR #n	(R1=R2 >>n),  1 <= n<= 31									1000		Send ALU alu_result to LDR
// MOV R1, R2, LSL #n	(R1=R2 <<n), 1 <= n<= 31									1001		Send ALU alu_result to LDR
// MOV R1, R2, ROR #n	(R1=Rotate right R2 by n-bit) , 1 <= n<= 31					1010		Send ALU alu_result to LDR
// CMP R1, R2			Compare R1 with R2 and set the status flags 				1011		Do Nothing
// ADR R1, n			Initialize R1 with a 16-bit address n, 0 <= n<= (2^16−1)	1100		Send ALU alu_result to LDR 
// LDR R2, [R1]			Load R2 with the contents at memory address R1				1101		Load data from ram at address(source_1), send loaded data to LDR
// STR R2, [R1]			Store R2 at memory address R1								1110		Store data source_2 at ram address(source_1)
// NOP					No Operation -Skip this instruction							1111		Do Nothing
//

// by GN
//Todo:
// retest
module memory_access_block(data_in, data_out, read_write, address, LDR, source_1, source_2, alu_result, op_code, PC_instruction);
	// Inputs
	input [3:0] op_code;
	input [15:0] PC_instruction;
	input [31:0] source_1, source_2, alu_result, data_in;
	
	// Outputs
	output reg read_write;
	output [15:0] address;
	output [31:0] data_out, LDR;
	
	//Internal registers
	reg LDR_select;
	reg address_select;
	
	// data_out is only read by ram when read_write = 1b'0 (op cod 4b'1110)
	// so a constant assignment is ok.
	assign data_out = source_2;
	
	//muxs
	mux_2by1 LDR_mux(LDR_select, alu_result, data_in, LDR);
	mux_2by1 #(16) address_mux(address_select, source_1[15:0], PC_instruction, address);
	
	always @ (op_code)
	begin
		case (op_code)
			4'b0000: begin // ADD R1, R2, R3
						LDR_select = 1'b1; // Send alu_result to registers
						read_write = 1'b1; // Keep ram in read mode until we want to write to it.
						address_select = 1'b0; //get address from pc access
					end
			4'b0001:begin // SUB R1, R2, R3
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b0010:begin // MUL R1, R2, R3
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b0011:begin // ORR R1, R2, R3
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b0100:begin // AND R1, R2, R3
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b0101:begin // EOR R1, R2, R3
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b0110:begin // MOV R1, n
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b0111:begin // MOV R1, R2
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b1000:begin // MOV R1, R2, LSR #n
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b1001:begin // MOV R1, R2, LSL #n
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b1010:begin // MOV R1, R2, ROR #n
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b1011:begin // CMP R1, R2
						LDR_select = 1'b1; // Nothing is loaded into registers (expect alu_result z's from alu)
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b1100:begin // ADR R1, n
						LDR_select = 1'b1;
						read_write = 1'b1;
						address_select = 1'b0;
					end
			4'b1101:begin // LDR R2, [R1]
						LDR_select = 1'b0; //Only case where ram data is loaded
						read_write = 1'b1; //Read from ram
						address_select = 1'b1;  // Get ram address from source 1
					end
			4'b1110:begin // STR R2, [R1]
						LDR_select = 1'b1; // Nothing is loaded into registers (expect alu_result z's from alu)
						read_write = 1'b0; // write to ram
						address_select = 1'b1; // Get ram address from source 1
					end
			4'b1111:begin // NOP
						LDR_select = 1'b1; // Nothing is loaded into registers (expect alu_result z's from alu)
						read_write = 1'b1;
						address_select = 1'b0;						
					end
			default:begin
						LDR_select = 1'b1; // Nothing is loaded into registers (expect alu_result z's from alu)
						read_write = 1'b1;
						address_select = 1'b0;
					end
			
		endcase
	end

endmodule


// 2 by 1 mux by GN
module mux_2by1(select, in_1, in_2, out);
	parameter width = 32;
	input select;
	input [width-1:0] in_1, in_2;
	output [width-1:0] out; 

	assign out = select ? in_1: in_2;
endmodule