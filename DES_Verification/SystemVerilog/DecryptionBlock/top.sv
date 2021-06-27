`include "interface.sv"
`include "dutdec.sv"
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

	// DESENC  dut1(iIntf.clk,
	// 			iIntf.key,
	// 			iIntf.msg,
	// 			iIntf.cipher);

	// DESDEC  dut2(iIntf.clk,
	// 			iIntf.key,
	// 			iIntf.cipher,
	// 			iIntf.decrypt);

//	DESENC  dut1(iIntf.DUTenc.clk,
//				iIntf.DUTenc.key,
//				iIntf.DUTenc.msg,
//				iIntf.DUTenc.cipher);

	DESDEC  dut2(iIntf.DUTdec.clk,
	 			iIntf.DUTdec.key,
	 			iIntf.DUTdec.cipher,
	 			iIntf.DUTdec.decrypt);


	initial begin
		$dumpfile("traces.vcd");
		$dumpvars;
	end

endmodule