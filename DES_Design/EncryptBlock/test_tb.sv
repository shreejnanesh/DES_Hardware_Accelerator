`timescale 1ns/10ps

module tb;
	reg clk;    
	reg [1:64] key,msg;
	reg [1:64] Encrypt,Decrypt;// declaring the register  and variables   

	DES d1(clk,key,msg,Encrypt,Decrypt);//Calling Instance		

	always
	#0.5 clk=~clk;

	initial begin

		clk=1'b1;
		key=64'b0001001100110100010101110111100110011011101111001101111111110001;    // key for encryption and decryption 
		msg=64'h0123456789ABCDEF;

		
		repeat (3) begin
			@(posedge clk)
			key=$random;
			msg=$random;
		end

		#350 $finish;
end

initial
begin
	$dumpfile("trace.vcd");
	$dumpvars;

end

endmodule
