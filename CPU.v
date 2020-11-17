module CPU; // No inputs. Closed System

//Wires
wire [15:0] address; //From MAB to RAM_CPU
wire read_write; // From MAB to RAM
wire [31:0] data_in; // From MAB to RAM
wire [31:0] data_out; // From RAM to MAB and State Machine

wire [31:0] source_1; // From RBT to ALU
wire [31:0] source_2; // From RBT to ALU

wire [31:0] result; // From ALU to MAB

wire [31:0] LDR; // From MAB to RBT

wire [15:0] PC_out; // From state machine to MAB

//Break up instruction into components
wire [31:0] instruction; // From state machine
wire [3:0] condition;
wire [3:0] op_code;
wire s_bit;
wire [3:0] destination;
wire [3:0] source_2_sel;
wire [3:0] source_1_sel;
wire [15:0] immediate_value;

assign condition = instruction[31:28];
assign op_code = instruction[27:24];
assign s_bit = instruction[23];
assign destination = instruction[22:19];
assign source_2_sel = instruction[18:15];
assign source_1_sel = instruction[14:11];
assign immediate_value = instruction[18:3];


//Submodules

// TODO: Flags IO needs handling
ALU ALU_CPU(op_code, source_1, source_2, immediate_value, condition, s_bit, result, flags);

memory_access_block MAB_CPU(data_in, data_out, read_write, address, LDR, source_1, source_2, result, op_code, PC_out);

reg_bank_toplevel RBT_CPU(destination, LDR, source_1_sel, source_2_sel, source_1, source_2);

// TODO: figure out how to handle enable
memory RAM_CPU(Enable,read_write,address,data_in, data_out);

state_machine SM_CPU(data_out, instruction, PC_out); // TODO: Match IO to state machine module below
endmodule


// State machine module
module state_machine(clk, reset, instruction_in, instruction_out, PC_out, next_state, current_state);
input clk, reset;
input [31:0] instruction_in; // Instruction read from RAM
output [31:0] instruction_out; // Instruction used by MAB, RBT and ALU
reg [31:0] instruction_out;
output [15:0] PC_out; // Output from program counter to MAB
reg [15:0] PC_out;
//Define States
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

output [1:0] next_state, current_state;
reg [1:0] next_state, current_state;

always @(posedge clk or negedge reset)
	begin
		if (!reset) 
		begin
		current_state <= S0;
		PC_out <= 0;
		end
		else current_state<= next_state;
		
	end

always @(posedge clk)
	begin
		case(current_state)
			S0:begin next_state = S1;
			
			S1: next_state = S2;
			
			S2:next_state = S0;
			
			
			default:begin // Starting conditions
			next_state = S0;
			PC_out = 0;
			end
		endcase
	end
	
always @(current_state)
begin
if(current_state == S2)
begin
PC_out = PC_out + 1;
instruction_out = instruction_in;
end
end



endmodule