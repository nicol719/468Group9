
//Todo make testbench 32 bits
// Read Testbench by GN
module test_read_memory;
    reg  enable,R_W;
    reg [31:0] D_In;
    reg [15:0] Address;
    wire [31:0] D_Out;

memory ram(enable,R_W,Address,D_In,D_Out); 

initial  
begin
   enable =0;   R_W=0;	Address=16'd0;	D_In =32'hAAAA0000;
#5 enable =1;   R_W=0;	Address=16'd0;	D_In =32'hAAAA0000;
#5 enable =1;   R_W=0;	Address=16'd1;	D_In =32'h00AA0000;
#5 enable =1;   R_W=0;	Address=16'd2;	D_In =32'h00BB0000;
#5 enable =1;   R_W=0;	Address=16'd3;	D_In =32'h00CC0000;
#5 enable =1;   R_W=0;	Address=16'd4;	D_In =32'h00DD0000;
#5 enable =1;   R_W=0;	Address=16'd5;	D_In =32'h00EE0000;
#5 enable =1;   R_W=0;	Address=16'd6;	D_In =32'h00FF0000;
#5 enable =1;   R_W=0;	Address=16'd7;	D_In =32'hFFFF0000;
#10

  $writememh("data_h.txt", ram.Mem);
end
endmodule