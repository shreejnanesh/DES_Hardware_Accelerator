//`include"keygen_old.sv"
`include"Encrypt.sv"
`include"Decrypt.sv"
`timescale 1ns/10ps

module DES( input clk,  //Inputs for DES Top module // Clock signal
            input [1:64] key,   //Key Input Cipher
            input [1:64] msg,   //Input Message Text
            output [1:64] Encrypt,      //Output from module - Encrypted Cipher text
            output [1:64] Decrypt) ;    //Output from module - Decrypted cipher text

   // reg [1:48] k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16;     //Register to store output from Keygen block - given to encrypt and decrypt
    /*reg [1:48] K_dec [1:16];*/
    reg [1:64] temp,temp2,key_enc;

    //keygen cipher(clk,key,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14,k15,k16);     //Instantiation of Keygen module

    encrypt E1(clk,msg,key,temp,key_enc);
    //encrypt E1(clk,msg,key,temp);

   // encrypt D1(.clk(clk),.in(temp),.key_in(key_dec),.En(temp2));

   decrypt D1(clk,temp,key_enc,temp2);
   // decrypt D1(clk,temp,key,temp2);


    assign Encrypt=temp;
    assign Decrypt=temp2;

    
  //  decrypt D1(clk,Encrypt,K,Decrypt);

endmodule


