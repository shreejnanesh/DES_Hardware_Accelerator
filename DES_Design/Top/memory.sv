module memory(input clk,wr0,wr1,en,
				input[63:0] key_in,msg_in,
				input[5:0] add0,add1,
				output [63:0] key_out,msg_out);


reg [63:0] temp1,temp2;
reg[63:0] mem[0:63];

always@(posedge clk or negedge clk)
begin
	if(en == 0) begin
		 temp1 <= 64'dx;
		 temp2 <= 64'dx;
	end
	else if(wr0==0) begin
		mem[add0] <= key_in;
		mem[add1] <= msg_in;
	end
	else if(wr1==0) begin
		mem[add1] <= msg_in;
		mem[add0] <= key_in;
	end
	else begin
		temp1 <= mem[ add0];
		temp2 <= mem[ add1];
	end
end

assign key_out = temp1;
assign msg_out = temp2;

endmodule
