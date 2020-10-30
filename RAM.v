//RAM section here
//Read and write operations of memory. 
// Memory size is 8 words of 16 bits each. 
module memory (Enable,ReadWrite,Address,DataIn,DataOut);
input  Enable,ReadWrite;
input [15:0] DataIn;
input [2:0] Address;
output reg[15:0] DataOut;
reg [15:0] Mem [0:7];         //8 x 16 memory
always @*
	if (Enable)
		if (ReadWrite) 
			DataOut = Mem[Address];  //Read
		else
			Mem[Address] = DataIn;   //Write
	else DataOut = 16'bz;   //High imped 
endmodule