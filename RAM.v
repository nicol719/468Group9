//RAM section here
//Read and write operations of memory. 
// Memory size is 8 words of 16 bits each. 

module memory (Enable,ReadWrite,Address,DataIn,DataOut);
input  Enable,ReadWrite;
	input [31:0] DataIn;  //Should be [31:0]
	input [15:0] Address;  
	output reg[31:0] DataOut; // [31:0]
reg [31:0] Mem [0:65535];     //8 x 16 memory -> reg [31:0] Mem [0:65535]; // 2^16 by 32 memory
always @*
	if (Enable)
		if (ReadWrite) 
			DataOut = Mem[Address];  //Read
		else
			Mem[Address] = DataIn;   //Write
	else DataOut = 32'bz;   //High imped  -> else DataOut = 32'bz; //High imped
endmodule
