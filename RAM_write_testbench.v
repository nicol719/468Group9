//Todo: Convert testbench to 32 bit
module test_write_memory;
    reg  enable,ReadWrite;
    reg [15:0] DataIn;
    reg [2:0] Address;
    wire [15:0] DataOut;

memory ram(enable,ReadWrite,Address,DataIn,DataOut); 

initial
begin  

  $readmemh("data_h.txt", ram.Mem);

   enable =0;   ReadWrite=0;	Address=3'd0;	
#5 enable =1;   ReadWrite=1;	Address=3'd0;	
#5 enable =1;   ReadWrite=1;	Address=3'd1;	
#5 enable =1;   ReadWrite=1;	Address=3'd2;	
#5 enable =1;   ReadWrite=1;	Address=3'd3;	
#5 enable =1;   ReadWrite=1;	Address=3'd4;	
#5 enable =1;   ReadWrite=1;	Address=3'd5;	
#5 enable =1;   ReadWrite=1;	Address=3'd6;	
#5 enable =1;   ReadWrite=1;	Address=3'd7;	

end


initial
begin
$monitor($time, "data at address %d is %h", Address, DataOut);
end
endmodule