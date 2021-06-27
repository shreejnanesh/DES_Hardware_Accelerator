class GRDESENC;
   
   reg [1:48] K [1:16];

    function logic [1:64] encryption (input logic [1:64] key, msg);
        keygen(key,K); 
        encryption = encrypt(msg,K);    
    endfunction 
    


function void keygen;
input [1:64] key_in;
output [1:48] K [1:16];
reg [1:56] PC_1;
reg [1:56] PC_2;
int unsigned i; 
reg [1:28] C0;
reg[1:28] D0;
reg [1:28] C1;
reg [1:28] D1;
static reg [1:2] lf [1:16] = {2'b01,2'b01,2'b10,2'b10,2'b10,2'b10,2'b10,2'b10,2'b01,
						2'b10,2'b10,2'b10,2'b10,2'b10,2'b10,2'b01 };
begin

    PC_1={key_in[57],key_in[49],key_in[41],key_in[33],key_in[25],key_in[17],key_in[9]
         ,key_in[1],key_in[58],key_in[50],key_in[42],key_in[34],key_in[26],key_in[18]
          ,key_in[10],key_in[2],key_in[59],key_in[51],key_in[43],key_in[35],key_in[27]
           ,key_in[19],key_in[11],key_in[3],key_in[60],key_in[52],key_in[44],key_in[36]
           ,key_in[63],key_in[55],key_in[47],key_in[39],key_in[31],key_in[23],key_in[15]
           ,key_in[7],key_in[62],key_in[54],key_in[46],key_in[38],key_in[30],key_in[22]
           ,key_in[14],key_in[6],key_in[61],key_in[53],key_in[45],key_in[37],key_in[29]
            ,key_in[21],key_in[13],key_in[5],key_in[28],key_in[20],key_in[12],key_in[4]};

    C0=PC_1[1:28];
    D0=PC_1[29:56];

for(i=1;i<=16;i++)
begin
	C1=rotate_left(C0,lf[i]);
	D1=rotate_left(D0,lf[i]);
	PC_2[1:28]=C1;
	PC_2[29:56]=D1;
	K[i]={ PC_2[14],PC_2[17],PC_2[11],PC_2[24],PC_2[1],PC_2[5],
             PC_2[3],PC_2[28],PC_2[15],PC_2[6],PC_2[21],PC_2[10],
             PC_2[23],PC_2[19],PC_2[12],PC_2[4],PC_2[26],PC_2[8],
              PC_2[16],PC_2[7],PC_2[27],PC_2[20],PC_2[13],PC_2[2],
              PC_2[41],PC_2[52],PC_2[31],PC_2[37],PC_2[47],PC_2[55],
              PC_2[30],PC_2[40],PC_2[51],PC_2[45],PC_2[33],PC_2[48],
              PC_2[44],PC_2[49],PC_2[39],PC_2[56],PC_2[34],PC_2[53],
              PC_2[46],PC_2[42],PC_2[50],PC_2[36],PC_2[29],PC_2[32] };
	C0=C1;
	D0=D1;
end

end
endfunction


function [1:28] rotate_left([1:28] temp,[1:2] lf);
reg [1:28] out;
begin
    out = ((temp << lf)|(temp >> ($bits(temp)-lf)));
    return out;
end
endfunction


function [1:64] init_permute;
input [1:64] in;
begin
    return {in[58],in[50],in[42],in[34],in[26],in[18],in[10],in[2],
			in[60],in[52],in[44],in[36],in[28],in[20],in[12],in[4],
			in[62],in[54],in[46],in[38],in[30],in[22],in[14],in[6],
			in[64],in[56],in[48],in[40],in[32],in[24],in[16],in[8],
			in[57],in[49],in[41],in[33],in[25],in[17],in[9],in[1],
			in[59],in[51],in[43],in[35],in[27],in[19],in[11],in[3],
			in[61],in[53],in[45],in[37],in[29],in[21],in[13],in[5],
			in[63],in[55],in[47],in[39],in[31],in[23],in[15],in[7]};
end
endfunction

function [1:64] final_permute;
input [1:64] in;
begin
    return {in[40],in[8],in[48],in[16],in[56],in[24],in[64],in[32],
        in[39],in[7],in[47],in[15],in[55],in[23],in[63],in[31],
        in[38],in[6],in[46],in[14],in[54],in[22],in[62],in[30],
        in[37],in[5],in[45],in[13],in[53],in[21],in[61],in[29],
        in[36],in[4 ],in[44],in[12],in[52],in[20 ],in[60 ],in[28],
        in[35],in[3],in[43],in[11],in[51],in[19 ],in[59 ],in[27],
        in[34],in[2],in[42],in[10 ],in[50],in[18],in[58],in[26],
        in[33],in[1],in[41],in[9],in[49],in[17],in[57 ],in[25]};
end
endfunction

function [1:64] fiestal_round([1:64] in, [1:48] key);
reg [1:64]out;
reg [1:32] l0;
reg [1:32] r0;
reg [1:48] Ebit;
reg [1:48] f1;
reg [1:32] S;
reg [1:32] P;
reg [1:32] l1;
reg [1:32] r1;
begin
    r0 = in[33:64] ;
    l0 = in[1:32];
    Ebit={r0[32],   r0[1]  ,  r0[2]  ,   r0[3] ,    r0[4]  ,  r0[5],
    	r0[4]  ,   r0[5]  ,  r0[6]   ,  r0[7]   ,  r0[8]  ,  r0[9],
    	r0[8] ,   r0[9] , r0[10]   , r0[11]  ,  r0[12]  , r0[13],
    	r0[12]   , r0[13] ,  r0[14]  ,  r0[15] ,   r0[16] ,  r0[17],
    	r0[16] ,  r0[17]  , r0[18]  ,  r0[19]  ,  r0[20] ,  r0[21],
    	r0[20]  ,  r0[21]  , r0[22]  ,  r0[23] ,  r0[24] ,  r0[25],
    	r0[24]  ,  r0[25] , r0[26]  ,  r0[27]  ,  r0[28]  , r0[29],
    	r0[28]   , r0[29]  , r0[30] ,   r0[31]  ,  r0[32]  ,  r0[1]};

    f1=key^Ebit;

    S={sbox1(f1[1:6]),sbox2(f1[7:12]),sbox3(f1[13:18]),sbox4(f1[19:24]),sbox5(f1[25:30]),
    	sbox6(f1[31:36]),sbox7(f1[37:42]),sbox8(f1[43:48])};

    P = {S[16], S[7], S[20], S[21], S[29], S[12], S[28],
    			S[17], S[1], S[15], S[23], S[26], S[5], S[18],
    			S[31], S[10], S[2], S[8], S[24], S[14], S[32],
    			S[27], S[3], S[9], S[19], S[13], S[30], S[6],
    			S[22], S[11], S[4], S[25]};
    r1=l0^P;
    l1=r0;
    out={l1[1:32],r1[1:32]};
    return out;
end
endfunction


function [1:64] encrypt([1:64] in, [1:48] key_in [1:16]);
reg [1:64] IP,FP;
reg [1:64] Round [1:16];
reg [1:64] temp1,temp2;
begin
	IP=init_permute(in);
	for(int i=1;i<=16;i++)
 	begin
		if(i==1) begin
 			Round[i]=fiestal_round(IP,key_in[i]); 
		end
		else
		begin
			Round[i]=fiestal_round(Round[i-1],key_in[i]); 
		end
	end
	temp2=Round[16];
	temp1[1:32]=temp2[33:64];
	temp1[33:64]=temp2[1:32];
	FP=final_permute(temp1);
	return FP;
end
endfunction


function  [1:4] sbox1;
input	[1:6] din;
reg	[1:4] dout;
begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout =  14;
         1:  dout =   4;
         2:  dout =  13;
         3:  dout =   1;
         4:  dout =   2;
         5:  dout =  15;
         6:  dout =  11;
         7:  dout =   8;
         8:  dout =   3;
         9:  dout =  10;
        10:  dout =   6;
        11:  dout =  12;
        12:  dout =   5;
        13:  dout =   9;
        14:  dout =   0;
        15:  dout =   7;

        16:  dout =   0;
        17:  dout =  15;
        18:  dout =   7;
        19:  dout =   4;
        20:  dout =  14;
        21:  dout =   2;
        22:  dout =  13;
        23:  dout =   1;
        24:  dout =  10;
        25:  dout =   6;
        26:  dout =  12;
        27:  dout =  11;
        28:  dout =   9;
        29:  dout =   5;
        30:  dout =   3;
        31:  dout =   8;

        32:  dout =   4;
        33:  dout =   1;
        34:  dout =  14;
        35:  dout =   8;
        36:  dout =  13;
        37:  dout =   6;
        38:  dout =   2;
        39:  dout =  11;
        40:  dout =  15;
        41:  dout =  12;
        42:  dout =   9;
        43:  dout =   7;
        44:  dout =   3;
        45:  dout =  10;
        46:  dout =   5;
        47:  dout =   0;

        48:  dout =  15;
        49:  dout =  12;
        50:  dout =   8;
        51:  dout =   2;
        52:  dout =   4;
        53:  dout =   9;
        54:  dout =   1;
        55:  dout =   7;
        56:  dout =   5;
        57:  dout =  11;
        58:  dout =   3;
        59:  dout =  14;
        60:  dout =  10;
        61:  dout =   0;
        62:  dout =   6;
        63:  dout =  13;

    endcase
    return dout;
    end
endfunction


function [1:4] sbox2;
input	[1:6] din;
reg	[1:4] dout;
begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout = 15;
         1:  dout =  1;
         2:  dout =  8;
         3:  dout = 14;
         4:  dout =  6;
         5:  dout = 11;
         6:  dout =  3;
         7:  dout =  4;
         8:  dout =  9;
         9:  dout =  7;
        10:  dout =  2;
        11:  dout = 13;
        12:  dout = 12;
        13:  dout =  0;
        14:  dout =  5;
        15:  dout = 10;

        16:  dout =  3;
        17:  dout = 13;
        18:  dout =  4;
        19:  dout =  7;
        20:  dout = 15;
        21:  dout =  2;
        22:  dout =  8;
        23:  dout = 14;
        24:  dout = 12;
        25:  dout =  0;
        26:  dout =  1;
        27:  dout = 10;
        28:  dout =  6;
        29:  dout =  9;
        30:  dout = 11;
        31:  dout =  5;

        32:  dout =  0;
        33:  dout = 14;
        34:  dout =  7;
        35:  dout = 11;
        36:  dout = 10;
        37:  dout =  4;
        38:  dout = 13;
        39:  dout =  1;
        40:  dout =  5;
        41:  dout =  8;
        42:  dout = 12;
        43:  dout =  6;
        44:  dout =  9;
        45:  dout =  3;
        46:  dout =  2;
        47:  dout = 15;

        48:  dout = 13;
        49:  dout =  8;
        50:  dout = 10;
        51:  dout =  1;
        52:  dout =  3;
        53:  dout = 15;
        54:  dout =  4;
        55:  dout =  2;
        56:  dout = 11;
        57:  dout =  6;
        58:  dout =  7;
        59:  dout = 12;
        60:  dout =  0;
        61:  dout =  5;
        62:  dout = 14;
        63:  dout =  9;

    endcase
    return dout;
    end
endfunction


function [1:4] sbox3;
input	[1:6] din;
reg	[1:4] dout;

begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout = 10;
         1:  dout =  0;
         2:  dout =  9;
         3:  dout = 14;
         4:  dout =  6;
         5:  dout =  3;
         6:  dout = 15;
         7:  dout =  5;
         8:  dout =  1;
         9:  dout = 13;
        10:  dout = 12;
        11:  dout =  7;
        12:  dout = 11;
        13:  dout =  4;
        14:  dout =  2;
        15:  dout =  8;

        16:  dout = 13;
        17:  dout =  7;
        18:  dout =  0;
        19:  dout =  9;
        20:  dout =  3;
        21:  dout =  4;
        22:  dout =  6;
        23:  dout = 10;
        24:  dout =  2;
        25:  dout =  8;
        26:  dout =  5;
        27:  dout = 14;
        28:  dout = 12;
        29:  dout = 11;
        30:  dout = 15;
        31:  dout =  1;

        32:  dout = 13;
        33:  dout =  6;
        34:  dout =  4;
        35:  dout =  9;
        36:  dout =  8;
        37:  dout = 15;
        38:  dout =  3;
        39:  dout =  0;
        40:  dout = 11;
        41:  dout =  1;
        42:  dout =  2;
        43:  dout = 12;
        44:  dout =  5;
        45:  dout = 10;
        46:  dout = 14;
        47:  dout =  7;

        48:  dout =  1;
        49:  dout = 10;
        50:  dout = 13;
        51:  dout =  0;
        52:  dout =  6;
        53:  dout =  9;
        54:  dout =  8;
        55:  dout =  7;
        56:  dout =  4;
        57:  dout = 15;
        58:  dout = 14;
        59:  dout =  3;
        60:  dout = 11;
        61:  dout =  5;
        62:  dout =  2;
        63:  dout = 12;

    endcase
    return dout;
    end
endfunction


function [1:4] sbox4;
input	[1:6] din;
reg	[1:4] dout;

begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout =  7;
         1:  dout = 13;
         2:  dout = 14;
         3:  dout =  3;
         4:  dout =  0;
         5:  dout =  6;
         6:  dout =  9;
         7:  dout = 10;
         8:  dout =  1;
         9:  dout =  2;
        10:  dout =  8;
        11:  dout =  5;
        12:  dout = 11;
        13:  dout = 12;
        14:  dout =  4;
        15:  dout = 15;

        16:  dout = 13;
        17:  dout =  8;
        18:  dout = 11;
        19:  dout =  5;
        20:  dout =  6;
        21:  dout = 15;
        22:  dout =  0;
        23:  dout =  3;
        24:  dout =  4;
        25:  dout =  7;
        26:  dout =  2;
        27:  dout = 12;
        28:  dout =  1;
        29:  dout = 10;
        30:  dout = 14;
        31:  dout =  9;

        32:  dout = 10;
        33:  dout =  6;
        34:  dout =  9;
        35:  dout =  0;
        36:  dout = 12;
        37:  dout = 11;
        38:  dout =  7;
        39:  dout = 13;
        40:  dout = 15;
        41:  dout =  1;
        42:  dout =  3;
        43:  dout = 14;
        44:  dout =  5;
        45:  dout =  2;
        46:  dout =  8;
        47:  dout =  4;

        48:  dout =  3;
        49:  dout = 15;
        50:  dout =  0;
        51:  dout =  6;
        52:  dout = 10;
        53:  dout =  1;
        54:  dout = 13;
        55:  dout =  8;
        56:  dout =  9;
        57:  dout =  4;
        58:  dout =  5;
        59:  dout = 11;
        60:  dout = 12;
        61:  dout =  7;
        62:  dout =  2;
        63:  dout = 14;

    endcase
    return dout;
    end
endfunction


function [1:4] sbox5;
input	[1:6] din;
reg	[1:4] dout;
begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout =  2;
         1:  dout = 12;
         2:  dout =  4;
         3:  dout =  1;
         4:  dout =  7;
         5:  dout = 10;
         6:  dout = 11;
         7:  dout =  6;
         8:  dout =  8;
         9:  dout =  5;
        10:  dout =  3;
        11:  dout = 15;
        12:  dout = 13;
        13:  dout =  0;
        14:  dout = 14;
        15:  dout =  9;

        16:  dout = 14;
        17:  dout = 11;
        18:  dout =  2;
        19:  dout = 12;
        20:  dout =  4;
        21:  dout =  7;
        22:  dout = 13;
        23:  dout =  1;
        24:  dout =  5;
        25:  dout =  0;
        26:  dout = 15;
        27:  dout = 10;
        28:  dout =  3;
        29:  dout =  9;
        30:  dout =  8;
        31:  dout =  6;

        32:  dout =  4;
        33:  dout =  2;
        34:  dout =  1;
        35:  dout = 11;
        36:  dout = 10;
        37:  dout = 13;
        38:  dout =  7;
        39:  dout =  8;
        40:  dout = 15;
        41:  dout =  9;
        42:  dout = 12;
        43:  dout =  5;
        44:  dout =  6;
        45:  dout =  3;
        46:  dout =  0;
        47:  dout = 14;

        48:  dout = 11;
        49:  dout =  8;
        50:  dout = 12;
        51:  dout =  7;
        52:  dout =  1;
        53:  dout = 14;
        54:  dout =  2;
        55:  dout = 13;
        56:  dout =  6;
        57:  dout = 15;
        58:  dout =  0;
        59:  dout =  9;
        60:  dout = 10;
        61:  dout =  4;
        62:  dout =  5;
        63:  dout =  3;

    endcase
    return dout;
    end
endfunction


function [1:4] sbox6;
input	[1:6] din;
reg	[1:4] dout;
begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout = 12;
         1:  dout =  1;
         2:  dout = 10;
         3:  dout = 15;
         4:  dout =  9;
         5:  dout =  2;
         6:  dout =  6;
         7:  dout =  8;
         8:  dout =  0;
         9:  dout = 13;
        10:  dout =  3;
        11:  dout =  4;
        12:  dout = 14;
        13:  dout =  7;
        14:  dout =  5;
        15:  dout = 11;

        16:  dout = 10;
        17:  dout = 15;
        18:  dout =  4;
        19:  dout =  2;
        20:  dout =  7;
        21:  dout = 12;
        22:  dout =  9;
        23:  dout =  5;
        24:  dout =  6;
        25:  dout =  1;
        26:  dout = 13;
        27:  dout = 14;
        28:  dout =  0;
        29:  dout = 11;
        30:  dout =  3;
        31:  dout =  8;

        32:  dout =  9;
        33:  dout = 14;
        34:  dout = 15;
        35:  dout =  5;
        36:  dout =  2;
        37:  dout =  8;
        38:  dout = 12;
        39:  dout =  3;
        40:  dout =  7;
        41:  dout =  0;
        42:  dout =  4;
        43:  dout = 10;
        44:  dout =  1;
        45:  dout = 13;
        46:  dout = 11;
        47:  dout =  6;

        48:  dout =  4;
        49:  dout =  3;
        50:  dout =  2;
        51:  dout = 12;
        52:  dout =  9;
        53:  dout =  5;
        54:  dout = 15;
        55:  dout = 10;
        56:  dout = 11;
        57:  dout = 14;
        58:  dout =  1;
        59:  dout =  7;
        60:  dout =  6;
        61:  dout =  0;
        62:  dout =  8;
        63:  dout = 13;

    endcase
    return dout;
    end

endfunction


function [1:4] sbox7;
input	[1:6] din;
reg [1:4] dout;
begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout =  4;
         1:  dout = 11;
         2:  dout =  2;
         3:  dout = 14;
         4:  dout = 15;
         5:  dout =  0;
         6:  dout =  8;
         7:  dout = 13;
         8:  dout =  3;
         9:  dout = 12;
        10:  dout =  9;
        11:  dout =  7;
        12:  dout =  5;
        13:  dout = 10;
        14:  dout =  6;
        15:  dout =  1;

        16:  dout = 13;
        17:  dout =  0;
        18:  dout = 11;
        19:  dout =  7;
        20:  dout =  4;
        21:  dout =  9;
        22:  dout =  1;
        23:  dout = 10;
        24:  dout = 14;
        25:  dout =  3;
        26:  dout =  5;
        27:  dout = 12;
        28:  dout =  2;
        29:  dout = 15;
        30:  dout =  8;
        31:  dout =  6;

        32:  dout =  1;
        33:  dout =  4;
        34:  dout = 11;
        35:  dout = 13;
        36:  dout = 12;
        37:  dout =  3;
        38:  dout =  7;
        39:  dout = 14;
        40:  dout = 10;
        41:  dout = 15;
        42:  dout =  6;
        43:  dout =  8;
        44:  dout =  0;
        45:  dout =  5;
        46:  dout =  9;
        47:  dout =  2;

        48:  dout =  6;
        49:  dout = 11;
        50:  dout = 13;
        51:  dout =  8;
        52:  dout =  1;
        53:  dout =  4;
        54:  dout = 10;
        55:  dout =  7;
        56:  dout =  9;
        57:  dout =  5;
        58:  dout =  0;
        59:  dout = 15;
        60:  dout = 14;
        61:  dout =  2;
        62:  dout =  3;
        63:  dout = 12;

    endcase
    return dout;
    end
endfunction


function [1:4] sbox8;
input	[1:6] din;
reg	[1:4] dout;
begin
    case ({din[1], din[6], din[2:5]})	
         0:  dout = 13;
         1:  dout =  2;
         2:  dout =  8;
         3:  dout =  4;
         4:  dout =  6;
         5:  dout = 15;
         6:  dout = 11;
         7:  dout =  1;
         8:  dout = 10;
         9:  dout =  9;
        10:  dout =  3;
        11:  dout = 14;
        12:  dout =  5;
        13:  dout =  0;
        14:  dout = 12;
        15:  dout =  7;

        16:  dout =  1;
        17:  dout = 15;
        18:  dout = 13;
        19:  dout =  8;
        20:  dout = 10;
        21:  dout =  3;
        22:  dout =  7;
        23:  dout =  4;
        24:  dout = 12;
        25:  dout =  5;
        26:  dout =  6;
        27:  dout = 11;
        28:  dout =  0;
        29:  dout = 14;
        30:  dout =  9;
        31:  dout =  2;

        32:  dout =  7;
        33:  dout = 11;
        34:  dout =  4;
        35:  dout =  1;
        36:  dout =  9;
        37:  dout = 12;
        38:  dout = 14;
        39:  dout =  2;
        40:  dout =  0;
        41:  dout =  6;
        42:  dout = 10;
        43:  dout = 13;
        44:  dout = 15;
        45:  dout =  3;
        46:  dout =  5;
        47:  dout =  8;

        48:  dout =  2;
        49:  dout =  1;
        50:  dout = 14;
        51:  dout =  7;
        52:  dout =  4;
        53:  dout = 10;
        54:  dout =  8;
        55:  dout = 13;
        56:  dout = 15;
        57:  dout = 12;
        58:  dout =  9;
        59:  dout =  0;
        60:  dout =  3;
        61:  dout =  5;
        62:  dout =  6;
        63:  dout = 11;

    endcase
    return dout;
    end
endfunction
endclass : GRDESENC

