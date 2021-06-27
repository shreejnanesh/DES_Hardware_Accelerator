`include"Encrypt.sv"
`include"Decrypt.sv"
`include "memory.sv"
`timescale 1ns/10ps

/*module DES( input clk,  //Inputs for DES Top module // Clock signal
            input [1:64] key,   //Key Input Cipher
            input [1:64] msg,   //Input Message Text
            output [1:64] Encrypt,      //Output from module - Encrypted Cipher text
            output [1:64] Decrypt) ;    //Output from module - Decrypted cipher text*/
  
module DES( input clk,  //Inputs for DES Top module // Clock signal
			input wr0,
			input wr1,
			input en,
			input [1:64] key_in,
			input [1:64] msg_in,
			input [5:0] add0,
			input [5:0] add1,	
			//input [5:0] add2,
			//input [5:0] add3,	
      output [1:64] Encrypt,      //Output from module - Encrypted Cipher text
      output [1:64] Decrypt) ;    //Output from module - Decrypted cipher text
  
  reg [1:64] key,msg;
  //reg [5:0] add2,add3;
  reg [1:64] temp,temp2,temp3,temp4,key_enc; //Register to store output  - given to encrypt and decrypt


  encrypt E1(clk,msg,key,temp,key_enc);//encrypt module
  
  decrypt D1(clk,temp,key_enc,temp2);// decrpyt module

  memory K1(clk,wr0,wr1,en,key_in,msg_in,add0,add1,key,msg);//ram module

  //memory R1(clk,wr0,wr1,en,temp,temp2,add2,add3,temp3,temp4);

  assign Encrypt=temp;
  assign Decrypt=temp2;

endmodule


