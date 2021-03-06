`include "uvm_macros.svh"
`include "interface.sv"
`include "dec_pkg.sv"
`include "dutdec.sv"

module dec_top;
	import uvm_pkg::*;
	import dec_pkg::*;

	bit clk;
	dec_interface dec_if(.clk(clk));
	DESDEC  dut(clk, dec_if.key, dec_if.cipher, dec_if.decrypt);
	
	//Clock generation
	initial begin
		clk=0;
		forever #5ns clk=~clk;
	end

	initial begin
		uvm_config_db#(virtual dec_interface)::set(null, "*", "dec_interface", dec_if);
    	$dumpfile ("myfile.vcd"); // Some VCD file name
    	$dumpvars (0, dec_top); // hierarchical reference to the signals that are to be dumped*/
  	end

	initial begin
		run_test("dec_test");
		//#10000 $finish;
	end
endmodule