`include"Decrypt.sv"
`timescale 1ns/10ps

module DESENC( input clk,  //Inputs for DES Top module // Clock signal
            input [1:64] key,   //Key Input Cipher
            input [1:64] msg,   //Input Message Text
            output [1:64] Encrypt ) ;      //Output from module - Encrypted Cipher text
 
  
  reg [1:64] temp,temp2,key_enc; //Register to store output  - given to encrypt and decrypt

  encrypt E1(clk,msg,key,temp,key_enc);//encrypt module
  
  decrypt D1(clk,temp,key_enc,temp2);// decrpyt module
  
  assign Decrypt=temp2;

endmodule


