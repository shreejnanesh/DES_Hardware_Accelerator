`timescale 1ns/10ps
module keygen(clk,key_in,K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16);
	input clk;
	input [0:63] key_in;
	output [0:47] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;

	reg [0:55] K;

	wire [0:47] K1,K2,K3,K4,K5,K6,K7,K8,K9,K10,K11,K12,K13,K14,K15,K16;

always@(posedge clk)
 begin 
 	K={key_in[57],key_in[49],key_in[41],key_in[33],key_in[25],key_in[17],key_in[9]
         ,key_in[1],key_in[58],key_in[50],key_in[42],key_in[34],key_in[26],key_in[18]
          ,key_in[10],key_in[2],key_in[59],key_in[51],key_in[43],key_in[35],key_in[27]
           ,key_in[19],key_in[11],key_in[3],key_in[60],key_in[52],key_in[44],key_in[36]
           ,key_in[63],key_in[55],key_in[47],key_in[39],key_in[31],key_in[23],key_in[15]
           ,key_in[7],key_in[62],key_in[54],key_in[46],key_in[38],key_in[30],key_in[22]
           ,key_in[14],key_in[6],key_in[61],key_in[53],key_in[45],key_in[37],key_in[29]
            ,key_in[21],key_in[13],key_in[5],key_in[28],key_in[20],key_in[12],key_in[4]};
 end

assign K16={K[47],	K[11],	K[26],	K[3], K[13],	K[41],
	K[27],	K[6],	K[54],	K[48],	K[39],	K[19],
	K[53],	K[25],	K[33],	K[34],	K[17],	K[5],
	K[4],	K[55],	K[24],	K[32],	K[40],	K[20],
	K[36],	K[31],	K[21],	K[8],	K[23],	K[52],
	K[14],	K[29],	K[51],	K[9],	K[35],	K[30],
	K[2],	K[37],	K[22],	K[0],	K[42],	K[38],
	K[16],	K[43],	K[44],	K[1],	K[7],	K[28] };


assign K15={K[54],K[18],K[33],K[10],K[20],K[48],
	K[34],K[13],K[4],K[55],K[46],K[26],
	K[3],K[32],K[40],K[41],K[24],K[12],
	K[11],K[5],K[6],K[39],K[47],K[27],
	K[43],K[38],K[28],K[15],K[30],K[0],
	K[21],K[36],K[31],K[16],K[42],K[37],
	K[9],K[44],K[29],K[7],K[49],K[45],
	K[23],K[50],K[51],K[8],K[14],K[35]};

assign K14={K[11],K[32],K[47],K[24],K[34],K[5],
	K[48],K[27],K[18],K[12],K[3],K[40],
	K[17],K[46],K[54],K[55],K[13],K[26],
	K[25],K[19],K[20],K[53],K[4],K[41],
	K[2],K[52],K[42],K[29],K[44],K[14],
	K[35],K[50],K[45],K[30],K[1],K[51],
	K[23],K[31],K[43],K[21],K[8],K[0],K[37],
	K[9],K[38],K[22],K[28],K[49]};

assign K13={K[25],K[46],K[4],K[13],K[48],
	K[19],K[5],K[41],K[32],K[26],
	K[17],K[54],K[6],K[3],K[11],
	K[12],K[27],K[40],K[39],K[33],
	K[34],K[10],K[18],K[55],K[16],
	K[7],K[1],K[43],K[31],K[28],
	K[49],K[9],K[0],K[44],K[15],
	K[38],K[37],K[45],K[2],K[35],
	K[22],K[14],K[51],K[23],K[52],
	K[36],K[42],K[8]};

assign K12={K[39],K[3],K[18],K[27],K[5],
	K[33],K[19],K[55],K[46],K[40],
	K[6],K[11],K[20],K[17],K[25],
	K[26],K[41],K[54],K[53],K[47],
	K[48],K[24],K[32],K[12],K[30],
	K[21],K[15],K[2],K[45],K[42],
	K[8],K[23],K[14],K[31],K[29],
	K[52],K[51],K[0],K[16],K[49],
	K[36],K[28],K[38],K[37],K[7],
	K[50],K[1],K[22]};

assign K11={K[53],K[17],K[32],K[41],K[19],K[47],
	K[33],K[12],K[3],K[54],K[20],K[25],
	K[34],K[6],K[39],K[40],K[55],K[11],
	K[10],K[4],K[5],K[13],K[46],K[26],
	K[44],K[35],K[29],K[16],K[0],K[1],
	K[22],K[37],K[28],K[45],K[43],K[7],
	K[38],K[14],K[30],K[8],K[50],K[42],
	K[52],K[51],K[21],K[9],K[15],K[36]};

assign K10={K[10],K[6],K[46],K[55],K[33],K[4],
	K[47],K[26],K[17],K[11],K[34],K[39],
	K[48],K[20],K[53],K[54],K[12],K[25],
	K[24],K[18],K[19],K[27],K[3],K[40],
	K[31],K[49],K[43],K[30],K[14],K[15],
	K[36],K[51],K[42],K[0],K[2],K[21],
	K[52],K[28],K[44],K[22],K[9],K[1],
	K[7],K[38],K[35],K[23],K[29],K[50]};

assign K9={K[24],K[20],K[3],K[12],K[47],K[18],
	K[4],K[40],K[6],K[25],K[48],K[53],
	K[5],K[34],K[10],K[11],K[26],K[39],
	K[13],K[32],K[33],K[41],K[17],K[54],
	K[45],K[8],K[2],K[44],K[28],K[29],
	K[50],K[38],K[1],K[14],K[16],K[35],
	K[7],K[42],K[31],K[36],K[23],K[15],
	K[21],K[52],K[49],K[37],K[43],K[9]};

assign K8={K[6],K[27],K[10],K[19],K[54],K[25],
	K[11],K[47],K[13],K[32],K[55],K[3],
	K[12],K[41],K[17],K[18],K[33],K[46],
	K[20],K[39],K[40],K[48],K[24],K[4],
	K[52],K[15],K[9],K[51],K[35],K[36],
	K[2],K[45],K[8],K[21],K[23],K[42],
	K[14],K[49],K[38],K[43],K[30],K[22],
	K[28],K[0],K[1],K[44],K[50],K[16]};

assign K7={K[20],K[41],K[24],K[33],K[11],K[39],
	K[25],K[4],K[27],K[46],K[12],K[17],
	K[26],K[55],K[6],K[32],K[47],K[3],
	K[34],K[53],K[54],K[5],K[13],K[18],
	K[7],K[29],K[23],K[38],K[49],K[50],
	K[16],K[0],K[22],K[35],K[37],K[1],
	K[28],K[8],K[52],K[2],K[44],K[36],
	K[42],K[14],K[15],K[31],K[9],K[30]};

assign K6={K[34],K[55],K[13],K[47],K[25],K[53],
	K[39],K[18],K[41],K[3],K[26],K[6],
	K[40],K[12],K[20],K[46],K[4],K[17],
	K[48],K[10],K[11],K[19],K[27],K[32],
	K[21],K[43],K[37],K[52],K[8],K[9],
	K[30],K[14],K[36],K[49],K[51],K[15],
	K[42],K[22],K[7],K[16],K[31],K[50],
	K[1],K[28],K[29],K[45],K[23],K[44]};

assign K5={K[48],K[12],K[27],K[4],K[39],K[10],
	K[53],K[32],K[55],K[17],K[40],K[20],
	K[54],K[26],K[34],K[3],K[18],K[6],
	K[5],K[24],K[25],K[33],K[41],K[46],
	K[35],K[2],K[51],K[7],K[22],K[23],
	K[44],K[28],K[50],K[8],K[38],K[29],
	K[1],K[36],K[21],K[30],K[45],K[9],
	K[15],K[42],K[43],K[0],K[37],K[31]};

assign K4={K[5],K[26],K[41],K[18],K[53],
	K[24],K[10],K[46],K[12],K[6],
	K[54],K[34],K[11],K[40],K[48],
	K[17],K[32],K[20],K[19],K[13],
	K[39],K[47],K[55],K[3],K[49],
	K[16],K[38],K[21],K[36],K[37],
	K[31],K[42],K[9],K[22],K[52],
	K[43],K[15],K[50],K[35],K[44],
	K[0],K[23],K[29],K[1],K[2],
	K[14],K[51],K[45]};

assign K3={K[19],K[40],K[55],K[32],K[10],K[13],
	K[24],K[3],K[26],K[20],K[11],K[48],
	K[25],K[54],K[5],K[6],K[46],K[34],
	K[33],K[27],K[53],K[4],K[12],K[17],
	K[8],K[30],K[52],K[35],K[50],K[51],
	K[45],K[1],K[23],K[36],K[7],K[2],
	K[29],K[9],K[49],K[31],K[14],K[37],
	K[43],K[15],K[16],K[28],K[38],K[0]};

assign K2={K[33],K[54],K[12],K[46],K[24],K[27],
	K[13],K[17],K[40],K[34],K[25],K[5],
	K[39],K[11],K[19],K[20],K[3],K[48],
	K[47],K[41],K[10],K[18],K[26],K[6],
	K[22],K[44],K[7],K[49],K[9],K[38],
	K[0],K[15],K[37],K[50],K[21],K[16],
	K[43],K[23],K[8],K[45],K[28],K[51],
	K[2],K[29],K[30],K[42],K[52],K[14]};

assign K1={K[40],K[4],K[19],K[53],K[6],K[34],K[20],K[24],K[47],
	K[41],K[32],K[12],K[46],K[18],K[26],K[27],K[10],K[55],
	K[54],K[48],K[17],K[25],K[33],K[13],K[29],K[51],K[14],
	K[1],K[16],K[45],K[7],K[22],K[44],K[2],K[28],K[23],
	K[50],K[30],K[15],K[52],K[35],K[31],K[9],K[36],K[37],
	K[49],K[0],K[21]};

endmodule