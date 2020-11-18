//----------------------
// State machine module
//----------------------
module state_machine(clk, reset, instruction_in, instruction_out, PC_out, current_state);
input clk, reset;
input [31:0] instruction_in; // Instruction read from RAM
output [31:0] instruction_out; // Instruction used by MAB, RBT and ALU
reg [31:0] instruction_out;
output [15:0] PC_out; // Output from program counter to MAB
reg [15:0] PC_out;
//Define States
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

output [1:0] current_state;
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
			S0:next_state = S1;
			
			S1: next_state = S2;
			
			S2: next_state = S0;
			
			
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