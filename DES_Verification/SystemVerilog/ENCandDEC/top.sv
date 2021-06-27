/*`include "interface.sv"
`include "dut.sv"
*/
module tbTop;
	bit clk;
	bit reset;

	always 
	#5 clk =~clk;

	initial begin
		reset = 1;
		#10 reset =0;
	end

	intf iIntf( .clk(clk),
				.reset(reset));

	test T1(iIntf);

	DESENC  dut1(iIntf.clk,
				iIntf.key,
				iIntf.msg,
				iIntf.cipher);

	DESDEC  dut2(iIntf.clk,
				iIntf.key,
				iIntf.cipher,
				iIntf.decrypt);


	initial begin
		$dumpfile("traces.vcd");
		$dumpvars;
	end

endmodule