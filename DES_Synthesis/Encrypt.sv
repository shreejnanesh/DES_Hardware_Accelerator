`timescale 1ns/10ps
`include"Fiestal.sv"

module encrypt(clk,in,key_in,En,key_out);
//module encrypt(clk,in,key_in,En);
input clk;
input [1:64] in;
input [1:64] key_in;
output [1:64] En;
output [1:64] key_out;


parameter [1:5] level [1:16]={1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28};

reg [1:64] IP,FP;
reg [1:64] temp [1:16];
reg [1:64] temp1,temp2;
reg [1:64] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;
reg [1:64] K1_0,K2_0,K3_0,K4_0,K5_0,K6_0,K7_0,K8_0,K9_0,K10_0,K11_0,K12_0,K13_0,K14_0,K15_0,K16_0;
reg [1:64] K1_1,K2_1,K3_1,K4_1,K5_1,K6_1,K7_1,K8_1,K9_1,K10_1,K11_1,K12_1,K13_1,K14_1,K15_1,K16_1;
reg [1:64] K1_2,K2_2,K3_2,K4_2,K5_2,K6_2,K7_2,K8_2,K9_2,K10_2,K11_2,K12_2,K13_2,K14_2,K15_2,K16_2;
reg [1:64] K1_3,K2_3,K3_3,K4_3,K5_3,K6_3,K7_3,K8_3,K9_3,K10_3,K11_3,K12_3,K13_3,K14_3,K15_3,K16_3;
reg [1:64] K1_4,K2_4,K3_4,K4_4,K5_4,K6_4,K7_4,K8_4,K9_4,K10_4,K11_4,K12_4,K13_4,K14_4,K15_4,K16_4;
reg [1:64] K1_5,K2_5,K3_5,K4_5,K5_5,K6_5,K7_5,K8_5,K9_5,K10_5,K11_5,K12_5,K13_5,K14_5,K15_5,K16_5;
reg [1:64] K1_6,K2_6,K3_6,K4_6,K5_6,K6_6,K7_6,K8_6,K9_6,K10_6,K11_6,K12_6,K13_6,K14_6,K15_6,K16_6,K16_7,K16_8,K16_9,K16_10;


always@(posedge clk) begin //Introduce Delays in keys (around 7 to 8 for each to get pipeline in Key)
  K1<=key_in;
  K1_1<=K1;
  K1_2<=K1_1;
  K1_3<=K1_2;
  K1_4<=K1_3;
  K1_5<=K1_4;
  K1_6<=K1_5;

  K2<=K1_6;
  K2_1<=K2;
  K2_2<=K2_1;
  K2_3<=K2_2;
  K2_4<=K2_3;
  K2_5<=K2_4;
  K2_6<=K2_5;

  K3<=K2_6;
  K3_1<=K3;
  K3_2<=K3_1;
  K3_3<=K3_2;
  K3_4<=K3_3;
  K3_5<=K3_4;
  K3_6<=K3_5;


  K4<=K3_6;
  K4_1<=K4;
  K4_2<=K4_1;
  K4_3<=K4_2;
  K4_4<=K4_3;
  K4_5<=K4_4;
  K4_6<=K4_5;



  K5<=K4_6;
  K5_1<=K5;
  K5_2<=K5_1;
  K5_3<=K5_2;
  K5_4<=K5_3;
  K5_5<=K5_4;
  K5_6<=K5_5;

  K6<=K5_6;
  K6_1<=K6;
  K6_2<=K6_1;
  K6_3<=K6_2;
  K6_4<=K6_3;
  K6_5<=K6_4;
  K6_6<=K6_5;

  K7<=K6_6;
  K7_1<=K7;
  K7_2<=K7_1;
  K7_3<=K7_2;
  K7_4<=K7_3;
  K7_5<=K7_4;
  K7_6<=K7_5;

  K8<=K7_6;
  K8_1<=K8;
  K8_2<=K8_1;
  K8_3<=K8_2;
  K8_4<=K8_3;
  K8_5<=K8_4;
  K8_6<=K8_5;


  K9<=K8_6;
  K9_1<=K9;
  K9_2<=K9_1;
  K9_3<=K9_2;
  K9_4<=K9_3;
  K9_5<=K9_4;
  K9_6<=K9_5;

  K10<=K9_6;
  K10_1<=K10;
  K10_2<=K10_1;
  K10_3<=K10_2;
  K10_4<=K10_3;
  K10_5<=K10_4;
  K10_6<=K10_5;

  K11<=K10_6;
  K11_1<=K11;
  K11_2<=K11_1;
  K11_3<=K11_2;
  K11_4<=K11_3;
  K11_5<=K11_4;
  K11_6<=K11_5;

  K12<=K11_6;
  K12_1<=K12;
  K12_2<=K12_1;
  K12_3<=K12_2;
  K12_4<=K12_3;
  K12_5<=K12_4;
  K12_6<=K12_5;

  K13<=K12_6;
  K13_1<=K13;
  K13_2<=K13_1;
  K13_3<=K13_2;
  K13_4<=K13_3;
  K13_5<=K13_4;
  K13_6<=K13_5;
  
  K14<=K13_6;
  K14_1<=K14;
  K14_2<=K14_1;
  K14_3<=K14_2;
  K14_4<=K14_3;
  K14_5<=K14_4;
  K14_6<=K14_5;

  K15<=K14_6;
  K15_1<=K15;
  K15_2<=K15_1;
  K15_3<=K15_2;
  K15_4<=K15_3;
  K15_5<=K15_4;
  K15_6<=K15_5;
    
  K16<=K15_6;
  K16_1<=K16;
  K16_2<=K16_1;
  K16_3<=K16_2;
  K16_4<=K16_3;
  K16_5<=K16_4;
  K16_6<=K16_5;
  K16_7<=K16_6;
  K16_8<=K16_7;
  K16_9<=K16_8;
  K16_10<=K16_9;
 
end

always@(posedge clk)
begin
	IP<={in[58],in[50],in[42],in[34],in[26],in[18],in[10],in[2],
      in[60],in[52],in[44],in[36],in[28],in[20],in[12],in[4],
      in[62],in[54],in[46],in[38],in[30],in[22],in[14],in[6],
      in[64],in[56],in[48],in[40],in[32],in[24],in[16],in[8],
      in[57],in[49],in[41],in[33],in[25],in[17],in[9],in[1],
      in[59],in[51],in[43],in[35],in[27],in[19],in[11],in[3],
      in[61],in[53],in[45],in[37],in[29],in[21],in[13],in[5],
      in[63],in[55],in[47],in[39],in[31],in[23],in[15],in[7]};
end

   fiestal_round F1(clk,IP,K1,level[1],temp[1]);
   fiestal_round F2(clk,temp[1],K2,level[2],temp[2]);
   fiestal_round F3(clk,temp[2],K3,level[3],temp[3]);
   fiestal_round F4(clk,temp[3],K4,level[4],temp[4]);
   fiestal_round F5(clk,temp[4],K5,level[5],temp[5]);
   fiestal_round F6(clk,temp[5],K6,level[6],temp[6]);
   fiestal_round F7(clk,temp[6],K7,level[7],temp[7]);
   fiestal_round F8(clk,temp[7],K8,level[8],temp[8]);
   fiestal_round F9(clk,temp[8],K9,level[9],temp[9]);
   fiestal_round F10(clk,temp[9],K10,level[10],temp[10]);
   fiestal_round F11(clk,temp[10],K11,level[11],temp[11]);
   fiestal_round F12(clk,temp[11],K12,level[12],temp[12]);
   fiestal_round F13(clk,temp[12],K13,level[13],temp[13]);
   fiestal_round F14(clk,temp[13],K14,level[14],temp[14]);
   fiestal_round F15(clk,temp[14],K15,level[15],temp[15]);
   fiestal_round F16(clk,temp[15],K16,level[16],temp[16]);

always@(posedge clk) begin
	temp2<=temp[16];
  temp1[1:32]<=temp2[33:64];
  temp1[33:64]<=temp2[1:32];
	FP<={temp1[40],temp1[8],temp1[48],temp1[16],temp1[56],temp1[24],temp1[64],temp1[32],
        temp1[39],temp1[7],temp1[47],temp1[15],temp1[55],temp1[23],temp1[63],temp1[31],
        temp1[38],temp1[6],temp1[46],temp1[14],temp1[54],temp1[22],temp1[62],temp1[30],
        temp1[37],temp1[5],temp1[45],temp1[13],temp1[53],temp1[21],temp1[61],temp1[29],
        temp1[36],temp1[4 ],temp1[44],temp1[12],temp1[52],temp1[20 ],temp1[60 ],temp1[28],
        temp1[35],temp1[3],temp1[43],temp1[11],temp1[51],temp1[19 ],temp1[59 ],temp1[27],
        temp1[34],temp1[2],temp1[42],temp1[10 ],temp1[50],temp1[18],temp1[58],temp1[26],
        temp1[33],temp1[1],temp1[41],temp1[9],temp1[49],temp1[17],temp1[57 ],temp1[25]};
end

assign En=FP;
assign key_out=K16_10;

endmodule