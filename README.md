# 468Group9
468 Group Project - Verilog Processor
Creating a processor simulatiom in Verilog HDL.

Steps to run the CPU:

1) Write the instructions:
Instructions are written in the CPU_Instructions.v file.
Instructions are written in one of two forms:
{condition, op_code, s_bit, destination, source_2_sel, source_1_sel, 11b'0}
or
{condition, op_code, s_bit, destination, immediate_value, 3b'0}
both are 32 bits long.
Remember to increment the ram_address with each instruction written.
Once the instructions have been written, save the file.

2) Compile the verilog files:
The following files need to be added to the ModelSim project and compiled in this order:
RAM.v
Memory_Access_Block.v
Register_Bank_Debugged.v
ALU_alt.v*
State_Machine.v
CPU_Testbench.v
CPU_Instructions.v

\* I was too afraid of flags, so I built the proof of concept without flags.
Hopefully the flag wizards can work their magic to integrate flags.

3) Simulate the "_load_instructions"
Go to simulate-> start simulatiom
and select work->"_load_instructions"
once the simulation window has opened, use the 'run -all' command.
The instructions should be written to load_ram.txt in hexadecimal form.

3) Simulate the "_CPU"
Go to simulate-> start simulatiom
and select work->"_CPU"
once the simulation window has opened, use the 'run -all' command.
The final contents of the ram should be written to ram_results.txt in hexadecimal form.