`include "interface.sv"
`include "top.sv"
`include "test.sv"

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

	DESENC  dut1(iIntf.DUTenc.clk,
				iIntf.DUTenc.key,
				iIntf.DUTenc.msg,
				iIntf.DUTenc.cipher);

	initial begin
		$dumpfile("traces.vcd");
		$dumpvars;
	end
	
	initial #1000 $finish();

endmodule