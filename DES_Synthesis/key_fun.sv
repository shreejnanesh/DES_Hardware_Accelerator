`timescale 1ns/10ps

module key_fun(clk,PC1,level,K_out,next_level_out);
	input clk;
	input [1:56] PC1;
	input [1:5] level;
	output [1:48] K_out;
	output [1:56] next_level_out;


	static   reg [1:2] lf [1:16] = {2'b01,2'b01,2'b10,2'b10,2'b10,2'b10,2'b10,2'b10,2'b01,
  						                    2'b10,2'b10,2'b10,2'b10,2'b10,2'b10,2'b01 };
           	reg [1:56] PC_2;
        	reg [1:48] key_temp;

	always@(posedge clk) begin

      	PC_2[1:28]<=rotate_left(PC1[1:28],lf[level]);
  		  PC_2[29:56]<=rotate_left(PC1[29:56],lf[level]);
    		key_temp<={ PC_2[14],PC_2[17],PC_2[11],PC_2[24],PC_2[1],PC_2[5],
                    PC_2[3],PC_2[28],PC_2[15],PC_2[6],PC_2[21],PC_2[10],
                    PC_2[23],PC_2[19],PC_2[12],PC_2[4],PC_2[26],PC_2[8],
                    PC_2[16],PC_2[7],PC_2[27],PC_2[20],PC_2[13],PC_2[2],
                    PC_2[41],PC_2[52],PC_2[31],PC_2[37],PC_2[47],PC_2[55],
                    PC_2[30],PC_2[40],PC_2[51],PC_2[45],PC_2[33],PC_2[48],
                    PC_2[44],PC_2[49],PC_2[39],PC_2[56],PC_2[34],PC_2[53],
                    PC_2[46],PC_2[42],PC_2[50],PC_2[36],PC_2[29],PC_2[32] };
      end

    assign K_out=key_temp;
    assign next_level_out=PC_2;

    function [1:28] rotate_left([1:28] temp,[1:2] lf);
    begin
      	return ((temp << lf)|(temp >> ($bits(temp)-lf)));
  	end
  	endfunction

endmodule

