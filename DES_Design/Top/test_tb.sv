`timescale 1ns/10ps

module tb;
	reg clk;    
	reg [1:64] key_in,msg_in;
	reg [1:64] Encrypt,Decrypt;// declaring the register  and variables   	
   // reg [1:64] temp,temp2;
	static reg en,wr0,wr1;
	reg[5:0] add0,add1;
    //reg[5:0] add2,add3;
	integer i;


	DES d1(clk,wr0,wr1,en,key_in,msg_in,add0,add1,Encrypt,Decrypt);


	always #0.5 clk=~clk;


	initial begin
        clk=1'b1;
		en = 1;  
        for(i=1; i <= 5; i = i + 1) begin
            wr1 = 0;
            wr0 = 0;
            key_in= $random;
            msg_in = $random;

            add0 = i-1;
            add1 = 6*i-1;
            #0.5 wr0 = 1;
                 wr1 = 1;
            #0.5;
        end
        #0.5 wr1 = 0;
        wr0 = 0;
        en =0;	
    end

  /*  initial begin
        clk=1'b1;
        en = 1;  
        for(i=1; i <= 5; i = i + 1) begin
            wr1 = 0;
            wr0 = 0;
            key_in = ;
            msg_in =;

            add2 = 31*i-1;
            add3 = 155*i-1;
            #0.5 wr0 = 1;
                 wr1 = 1;
            #0.5;
        end
        #0.5 wr1 = 0;
        wr0 = 0;
        en =0;  
    end*/

    initial
    begin
    	$dumpfile("trace.vcd");
    	$dumpvars;
        #350 $finish;
    end

endmodule
