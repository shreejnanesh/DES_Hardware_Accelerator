`include"key_fun.sv"
`timescale 1ns/10ps

module keygen(clk,key_in,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16);
  input [1:64] key_in;      //Input 64 bit key
  input clk;              //Input clock
  output [1:48] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;   //Output 48 bit keys & 16 lines

  reg  [1:56]  key;

  reg [1:48] key_tempo [1:16];
  reg [1:56] PC_2 [1:16];
  static reg [1:5] level [1:16]={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}; 

  always@(posedge clk) begin

     key <= {key_in[57],key_in[49],key_in[41],key_in[33],key_in[25],key_in[17],key_in[9]
         ,key_in[1],key_in[58],key_in[50],key_in[42],key_in[34],key_in[26],key_in[18]
          ,key_in[10],key_in[2],key_in[59],key_in[51],key_in[43],key_in[35],key_in[27]
           ,key_in[19],key_in[11],key_in[3],key_in[60],key_in[52],key_in[44],key_in[36]
           ,key_in[63],key_in[55],key_in[47],key_in[39],key_in[31],key_in[23],key_in[15]
           ,key_in[7],key_in[62],key_in[54],key_in[46],key_in[38],key_in[30],key_in[22]
           ,key_in[14],key_in[6],key_in[61],key_in[53],key_in[45],key_in[37],key_in[29]
            ,key_in[21],key_in[13],key_in[5],key_in[28],key_in[20],key_in[12],key_in[4]};

   end

  key_fun KEY1(clk,key,level[1],key_tempo[1],PC_2[1]);
  key_fun KEY2(clk,PC_2[1],level[2],key_tempo[2],PC_2[2]);
  key_fun KEY3(clk,PC_2[2],level[3],key_tempo[3],PC_2[3]);
  key_fun KEY4(clk,PC_2[3],level[4],key_tempo[4],PC_2[4]);
  key_fun KEY5(clk,PC_2[4],level[5],key_tempo[5],PC_2[5]);
  key_fun KEY6(clk,PC_2[5],level[6],key_tempo[6],PC_2[6]);
  key_fun KEY7(clk,PC_2[6],level[7],key_tempo[7],PC_2[7]);
  key_fun KEY8(clk,PC_2[7],level[8],key_tempo[8],PC_2[8]);
  key_fun KEY9(clk,PC_2[8],level[9],key_tempo[9],PC_2[9]);
  key_fun KEY10(clk,PC_2[9],level[10],key_tempo[10],PC_2[10]);
  key_fun KEY11(clk,PC_2[10],level[11],key_tempo[11],PC_2[11]);
  key_fun KEY12(clk,PC_2[11],level[12],key_tempo[12],PC_2[12]);
  key_fun KEY13(clk,PC_2[12],level[13],key_tempo[13],PC_2[13]);
  key_fun KEY14(clk,PC_2[13],level[14],key_tempo[14],PC_2[14]);
  key_fun KEY15(clk,PC_2[14],level[15],key_tempo[15],PC_2[15]);
  key_fun KEY16(clk,PC_2[15],level[16],key_tempo[16],PC_2[16]);


  assign K1=key_tempo[1];
  assign K2=key_tempo[2];
  assign K3=key_tempo[3];
  assign K4=key_tempo[4];
  assign K5=key_tempo[5];
  assign K6=key_tempo[6];
  assign K7=key_tempo[7];
  assign K8=key_tempo[8];
  assign K9=key_tempo[9];
  assign K10=key_tempo[10];
  assign K11=key_tempo[11];
  assign K12=key_tempo[12];
  assign K13=key_tempo[13];
  assign K14=key_tempo[14];
  assign K15=key_tempo[15];
  assign K16=key_tempo[16];
 

endmodule


/* ----------------------------------------------------------------------------   
module keygen(clk,key_in,K);
  input [1:64] key_in;      //Input 64 bit key
  input clk;              //Input clock
  output [1:48] K [1:16];   //Output 48 bit keys & 16 lines

   int unsigned i; //Variable
  reg [1:48] key_out [1:16]; //For storing output before assigning
   reg [1:28] C [1:16]; //For storing output before assigning
    reg [1:28] D [1:16]; //For storing output before assigning
  reg [1:56] PC_1;
  reg [1:56] PC_2;
  reg [1:28] C0;
  reg [1:28] D0;
  reg [1:28] C1,temp1,temp2;
  reg [1:28] D1;
  static reg [1:2] lf [1:16] = {2'b01,2'b01,2'b10,2'b10,2'b10,2'b10,2'b10,2'b10,2'b01,
  						2'b10,2'b10,2'b10,2'b10,2'b10,2'b10,2'b01 };
  always@(posedge clk)
  begin

      PC_1<={key_in[57],key_in[49],key_in[41],key_in[33],key_in[25],key_in[17],key_in[9]
           ,key_in[1],key_in[58],key_in[50],key_in[42],key_in[34],key_in[26],key_in[18]
            ,key_in[10],key_in[2],key_in[59],key_in[51],key_in[43],key_in[35],key_in[27]
             ,key_in[19],key_in[11],key_in[3],key_in[60],key_in[52],key_in[44],key_in[36]
             ,key_in[63],key_in[55],key_in[47],key_in[39],key_in[31],key_in[23],key_in[15]
             ,key_in[7],key_in[62],key_in[54],key_in[46],key_in[38],key_in[30],key_in[22]
             ,key_in[14],key_in[6],key_in[61],key_in[53],key_in[45],key_in[37],key_in[29]
              ,key_in[21],key_in[13],key_in[5],key_in[28],key_in[20],key_in[12],key_in[4]};

      C[1]<=PC_1[1:28];
      D[1]<=PC_1[29:56];

  for(i=1;i<16;i++)
  begin
  	C[i+1]<=rotate_left(C[i],lf[i]);
  	D[i+1]<=rotate_left(D[i],lf[i]);
  	PC_2<={C[i+1],D[i+1]};
  	key_out[i]<={ PC_2[14],PC_2[17],PC_2[11],PC_2[24],PC_2[1],PC_2[5],
               PC_2[3],PC_2[28],PC_2[15],PC_2[6],PC_2[21],PC_2[10],
               PC_2[23],PC_2[19],PC_2[12],PC_2[4],PC_2[26],PC_2[8],
                PC_2[16],PC_2[7],PC_2[27],PC_2[20],PC_2[13],PC_2[2],
                PC_2[41],PC_2[52],PC_2[31],PC_2[37],PC_2[47],PC_2[55],
                PC_2[30],PC_2[40],PC_2[51],PC_2[45],PC_2[33],PC_2[48],
                PC_2[44],PC_2[49],PC_2[39],PC_2[56],PC_2[34],PC_2[53],
                PC_2[46],PC_2[42],PC_2[50],PC_2[36],PC_2[29],PC_2[32] };
  end

  end
  function [1:28] rotate_left([1:28] temp,[1:2] lf);
    begin
      return ((temp << lf)|(temp >> ($bits(temp)-lf)));
  end
  endfunction

  assign K=key_out;

endmodule*/