//Register Bank testbench by GN

// Toplevel reg testbench
module test_reg_bank_toplevel;
	reg [3:0] destination;
	reg [31:0] LDR_mux;
	reg [3:0] source_1_sel, source_2_sel;
	wire [31:0] source_1, source_2;
		
	
	reg_bank_toplevel top_reg_test(destination, LDR_mux, source_1_sel, source_2_sel, source_1, source_2);
	
	initial
	begin
	//Test cases
	destination = 4'h0; LDR_mux = 32'h00000000; source_1_sel = 4'h0; source_2_sel = 4'h0; 
	// Load some values into register bank.
	#5 destination = 4'h1;
	#5 LDR_mux = 32'h11111111; 
	#5 destination = 4'h2;
	#5 LDR_mux = 32'h22222222;
	#5 destination = 4'h3; 
	#5 LDR_mux = 32'h33333333;
	#5 destination = 4'h4;
	#5 LDR_mux = 32'h44444444;
	#5 destination = 4'h5;
	#5 LDR_mux = 32'h55555555;
	#5 destination = 4'h6;
	#5 LDR_mux = 32'h66666666;
	#5 destination = 4'h7;
	#5 LDR_mux = 32'h77777777;
	#5 destination = 4'h8;
	#5 LDR_mux = 32'h88888888;
	#5 destination = 4'h9;
	#5 LDR_mux = 32'h99999999;
	#5 destination = 4'hA;
	#5 LDR_mux = 32'hAAAAAAAA;
	#5 destination = 4'hB;
	#5 LDR_mux = 32'hBBBBBBBB;
	#5 destination = 4'hC;
	#5 LDR_mux = 32'hCCCCCCCC;
	#5 destination = 4'hD;
	#5 LDR_mux = 32'hDDDDDDDD;
	#5 destination = 4'hE;
	#5 LDR_mux = 32'hEEEEEEEE;
	#5 destination = 4'hF;
	#5 LDR_mux = 32'hFFFFFFFF;
	//Read the register values
	#5 source_1_sel = 4'h0; source_2_sel =4'hF;
	#5 source_1_sel = 4'h1; source_2_sel =4'hE;
	#5 source_1_sel = 4'h2; source_2_sel =4'hD;
	#5 source_1_sel = 4'h3; source_2_sel =4'hC;
	#5 source_1_sel = 4'h4; source_2_sel =4'hB;
	#5 source_1_sel = 4'h5; source_2_sel =4'hA;
	#5 source_1_sel = 4'h6; source_2_sel =4'h9;
	#5 source_1_sel = 4'h7; source_2_sel =4'h8;
	#5 source_1_sel = 4'h8; source_2_sel =4'h7;
	#5 source_1_sel = 4'h9; source_2_sel =4'h6;
	#5 source_1_sel = 4'hA; source_2_sel =4'h5;
	#5 source_1_sel = 4'hB; source_2_sel =4'h4;
	#5 source_1_sel = 4'hC; source_2_sel =4'h3;
	#5 source_1_sel = 4'hD; source_2_sel =4'h2;
	#5 source_1_sel = 4'hE; source_2_sel =4'h1;
	#5 source_1_sel = 4'hF; source_2_sel =4'h0;
	end


	initial
	begin
	$monitor($time, "\n\nldr_mux = %h\ndestination = %h\nsource_1_sel = %h\nsource_2_sel = %h\nsource_1 = %h\n source_2 = %h\n------------------", LDR_mux, destination, source_1_sel, source_2_sel, source_1, source_2);
	end
endmodule

// Mux testbench
module test_mux_16to1;
	reg [31:0] q0, q1, q2, q3, q4, q5, q6, q7;
    reg [31:0] q8, q9, q10, q11, q12, q13, q14, q15;
	reg [3:0] source_sel;
	wire [31:0] source;
		
	
	mux_16to1 mux_test(source, source_sel,
				q0, q1, q2, q3, q4, q5, q6, q7,
                 q8, q9, q10, q11, q12, q13, q14, q15);
	
	initial
	begin
	//Test cases
	source_sel = 4'h0; q0 = 32'h00000000; q1 = 32'h11111111; q2 = 32'h22222222; q3 = 32'h33333333; q4 = 32'h44444444; q5 = 32'h55555555; q6 = 32'h66666666; q7 = 32'h77777777; q8 = 32'h88888888; q9 = 32'h99999999; q10 = 32'hAAAAAAAA; q11 = 32'hBBBBBBBB; q12 = 32'hCCCCCCCC; q13 = 32'hDDDDDDDD; q14 = 32'hEEEEEEEE; q15 = 32'hFFFFFFFF;
	#5 source_sel = 4'h1;
	#5 source_sel = 4'h2;
	#5 source_sel = 4'h3;
	#5 source_sel = 4'h4;
	#5 source_sel = 4'h5;
	#5 source_sel = 4'h6;
	#5 source_sel = 4'h7;
	#5 source_sel = 4'h8;
	#5 source_sel = 4'h9;
	#5 source_sel = 4'hA;
	#5 source_sel = 4'hB;
	#5 source_sel = 4'hC;
	#5 source_sel = 4'hD;
	#5 source_sel = 4'hE;
	#5 source_sel = 4'hF;
	//test changing q
	#5 q15 = 32'h00000000;
	end


	initial
	begin
	$monitor($time, "\n\nsource_sel = %b\nsource_sel = %h \nq0 = %h\n q1 = %h\n q2 = %h\n q3 = %h\n q4 = %h\n q5 = %h\n q6 = %h\n q7 = %h\n q8 = %h\n q9 = %h\n q10 = %h\n q11 = %h\n q12 = %h\n q13 = %h\n q14 = %h\n q15 = %h\n\n source = %h\n------------------", source_sel, source_sel,q0, q1, q2, q3, q4, q5, q6, q7,q8, q9, q10, q11, q12, q13, q14, q15, source);
	end
endmodule

// Single 32 bit register testbench by GN
module test_reg32;
	reg en_t;
	reg [31:0] data_in_t;
	wire [31:0] q_t;	
	reg32 testreg32(en_t, q_t, data_in_t);
	
	initial
	begin
	//Test cases
	data_in_t = 32'hFFFFFFFF; en_t = 0;
	#5 data_in_t = 32'hEEEEEEEE; en_t = 0;
	#5 data_in_t = 32'hFFFFFFFF; en_t = 1;
	#5 data_in_t = 32'hFFFFFFFF; en_t = 0;
	#5 data_in_t = 32'hAAAAAAAA; en_t = 0;
	#5 data_in_t = 32'hAAAAAAAA; en_t = 1;
	end


	initial
	begin
	$monitor($time, " data_in_t =%h, en_t =%b, q =%h", data_in_t, en_t, q_t);
	end
endmodule

// Register bank testbench
module test_reg_bank;
	reg en0, en1, en2, en3, en4, en5, en6, en7;
	reg en8, en9, en10, en11, en12, en13, en14, en15;
	reg [31:0] ldr_in;
	wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7;
    wire [31:0] q8, q9, q10, q11, q12, q13, q14, q15;	
	
	reg_bank reg_bank_test(q0, q1, q2, q3, q4, q5, q6, q7,
                 q8, q9, q10, q11, q12, q13, q14, q15, 
                 en0, en1, en2, en3, en4, en5, en6, en7,
				 en8, en9, en10, en11, en12, en13, en14, en15,
				 ldr_in);
	
	initial
	begin
	//Test cases
	ldr_in = 32'hFFFFFFFF; en0 = 0; en1 = 0; en2 = 0; en3 = 0; en4 = 0; en5 = 0; en6 = 0; en7 = 0; en8 = 0; en9 = 0; en10 = 0; en11 = 0; en12 = 0; en13 = 0; en14 = 0; en15 = 0;
	#5 ldr_in = 32'hFFFFFFFF; en0 = 1; 
	#5 ldr_in = 32'hEEEEEEEE; en0 = 0; en1 = 1;
	#5 ldr_in = 32'hDDDDDDDD; en1 = 0; en2 = 1;
	#5 ldr_in = 32'hCCCCCCCC; en2 = 0; en3 = 1;
	#5 ldr_in = 32'hBBBBBBBB; en3 = 0; en4 = 1;
	end


	initial
	begin
	$monitor($time, "\nldr_in = %h\n\n en0 = %b\n en1 = %b\n en2 = %b\n en3 = %b\n en4 = %b\n en5 = %b\n en6 = %b\n en7 = %b\n en8 = %b\n en9 = %b\n en10 = %b\n en11 = %b\n en12 = %b\n en13 = %b\n en14 = %b\n en15 = %b\n \n\n q0 = %h\n q1 = %h\n q2 = %h\n q3 = %h\n q4 = %h\n q5 = %h\n q6 = %h\n q7 = %h\n q8 = %h\n q9 = %h\n q10 = %h\n q11 = %h\n q12 = %h\n q13 = %h\n q14 = %h\n q15 = %h\n\n------------------", ldr_in, en0, en1, en2, en3, en4, en5, en6, en7,en8, en9, en10, en11, en12, en13, en14, en15,q0, q1, q2, q3, q4, q5, q6, q7,q8, q9, q10, q11, q12, q13, q14, q15);
	end
endmodule

// Decoder Testbench
module test_decoder4_16;
	reg [3:0] dest_in;
	wire en0, en1, en2, en3, en4, en5, en6, en7;
	wire en8, en9, en10, en11, en12, en13, en14, en15;
	
	decoder4_16 decoder_test(en0, en1, en2, en3, en4, en5, en6, en7,
				 en8, en9, en10, en11, en12, en13, en14, en15,
				 dest_in);
	
	initial
	begin
	//Test cases
	dest_in = 4'h0;
	#5 dest_in = 4'h1;
	#5 dest_in = 4'h2;
	#5 dest_in = 4'h3;
	#5 dest_in = 4'h4;
	#5 dest_in = 4'h5;
	#5 dest_in = 4'h6;
	#5 dest_in = 4'h7;
	#5 dest_in = 4'h8;
	#5 dest_in = 4'h9;
	#5 dest_in = 4'hA;
	#5 dest_in = 4'hB;
	#5 dest_in = 4'hC;
	#5 dest_in = 4'hD;
	#5 dest_in = 4'hE;
	#5 dest_in = 4'hF;
	end


	initial
	begin
	$monitor($time, "\ndest_in = %b\ndest_in = %d\n\n en0 = %b\n en1 = %b\n en2 = %b\n en3 = %b\n en4 = %b\n en5 = %b\n en6 = %b\n en7 = %b\n en8 = %b\n en9 = %b\n en10 = %b\n en11 = %b\n en12 = %b\n en13 = %b\n en14 = %b\n en15 = %b\n\n\n------------------", dest_in,dest_in, en0, en1, en2, en3, en4, en5, en6, en7,en8, en9, en10, en11, en12, en13, en14, en15);
	end
endmodule