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

state_machine SM_CPU(data_out, instruction, PC_out);
endmodule


// State machine module
module state_machine(instruction_in, insruction_out, PC_out);
input [31:0] instruction_in; // Instruction read from RAM
output [31:0] insruction_out; // Instruction used by MAB, RBT and ALU
output [15:0] PC_out; // Output from program counter to MAB

// State machine code here
// Fetch instruction_in
// Decode instruction (Maybe send out result addresses first here?)
// Execute instruction


endmodule