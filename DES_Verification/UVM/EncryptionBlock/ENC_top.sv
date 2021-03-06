`include "uvm_macros.svh"
`include "interface.sv"
`include "dut.sv"
`include "package.sv"

module enc_top;
  import uvm_pkg::*;
  import enc_pkg::*;

  bit clk;
  enc_interface enc_if(.clock(clk));
  DESENC dut(clk, enc_if.key, enc_if.msg, enc_if.cipher); 

  // Clock generation
  initial begin
    clk = 0;
    forever #5ns clk = ~clk;
  end

  initial begin
    uvm_config_db#(virtual enc_interface)::set(null, "*", "enc_interface", enc_if);
    $dumpfile ("myfile.vcd"); // Some VCD file name
    $dumpvars (0, enc_top); // hierarchical reference to the signals that are to be dumped
  end

  initial begin
    run_test("enc_test");
  end
endmodule