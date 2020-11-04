
//Todo make testbench 32 bits

module test_memory;
    reg  enable,R_W;
    reg [15:0] D_In;
    reg [2:0] Address;
    wire [15:0] D_Out;

memory ram(enable,R_W,Address,D_In,D_Out); 

initial  
begin
   enable =0;   R_W=0;	Address=3'd0;	D_In =16'hAAAA;
#5 enable =1;   R_W=0;	Address=3'd0;	D_In =16'hAAAA;
#5 enable =1;   R_W=0;	Address=3'd1;	D_In =16'h00AA;
#5 enable =1;   R_W=0;	Address=3'd2;	D_In =16'h00BB;
#5 enable =1;   R_W=0;	Address=3'd3;	D_In =16'h00CC;
#5 enable =1;   R_W=0;	Address=3'd4;	D_In =16'h00DD;
#5 enable =1;   R_W=0;	Address=3'd5;	D_In =16'h00EE;
#5 enable =1;   R_W=0;	Address=3'd6;	D_In =16'h00FF;
#5 enable =1;   R_W=0;	Address=3'd7;	D_In =16'hFFFF;
#10

  $writememh("data_h.txt", ram.Mem);
end
endmodule