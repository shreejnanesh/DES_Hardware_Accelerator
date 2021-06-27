`include "uvm_macros.svh"
`include "dut.sv"

interface enc_interface(input bit clock);
     logic [63:0] msg;
     logic [63:0] key;
     logic [63:0] cipher;

   clocking dcb @(negedge clock);
     output  msg;
     output  key;
   endclocking

   clocking mcb @(negedge clock);
     input msg;
     input key;
     input cipher;
   endclocking
endinterface


package enc_pkg;

	import uvm_pkg::*;
	`include "grDesEnc.sv"

	class enc_seq_item extends uvm_sequence_item;
	   rand logic [63:0] msg; 
	   rand logic [63:0] key; 
	        logic [63:0] cipher;

	   `uvm_object_utils_begin(enc_seq_item)
	      `uvm_field_int(msg, UVM_ALL_ON)
	      `uvm_field_int(key, UVM_ALL_ON)
	   `uvm_object_utils_end

	   function new(string name="");
	      super.new(name);
	   endfunction

	   // constraint enc_seq_item_c {
	   //      msg inside {[0:(2**64)]};
	   //      key inside {[0:(2**64)]};
	   // }

	endclass: enc_seq_item

	class enc_driver extends uvm_driver #(enc_seq_item);

	    virtual enc_interface enc_vif;
	    `uvm_component_utils(enc_driver)

	    function new(string name="", uvm_component parent);
	       super.new(name, parent);
	    endfunction

	   virtual function void build_phase(uvm_phase phase);
	      if (!(uvm_config_db#(virtual enc_interface)::get(this,"","enc_interface",enc_vif)) ) begin
	         `uvm_fatal("FATAL", "Can't get interface enc_interface\n");
	      end
	   endfunction

	   virtual function void connect_phase(uvm_phase phase);
	   endfunction

	   virtual function void end_of_elaboration_phase(uvm_phase phase);
	     uvm_top.print_topology();
	   endfunction

	   virtual function void start_of_simulation_phase(uvm_phase phase);
	   endfunction

	   virtual task run_phase(uvm_phase phase);
	        enc_seq_item itm;
	        while(1) begin
	           itm = enc_seq_item::type_id::create("itm");
	           seq_item_port.get_next_item(itm);
	           @(enc_vif.dcb);
	           enc_vif.msg = itm.msg;
	           enc_vif.key = itm.key;
	           `uvm_info("DRV", $sformatf("1: DEBUG: @time %0t, msg=%0d, key=%0d", $time, enc_vif.msg, enc_vif.key), UVM_HIGH);
	           seq_item_port.item_done();
	        end
	   endtask

	endclass

	class enc_seq extends uvm_sequence #(enc_seq_item);
	   `uvm_object_utils(enc_seq)

	   function new(string name="");
	      super.new(name);
	   endfunction

	   task body();
	       enc_seq_item itm;
	       for (int i = 0; i<1000; i++) begin
	          itm = enc_seq_item::type_id::create("itm");
	          start_item(itm);
	          assert(itm.randomize());
	          `uvm_info("SEQ", $sformatf("2: DEBUG: @time %0t, Seqitem %0d generated => msg=%0d, key=%0d", $time, i, itm.msg, itm.key), UVM_HIGH);
	          finish_item(itm);
	       end
	   endtask

	endclass


	class enc_monitor extends uvm_monitor;
	  uvm_analysis_port#(enc_seq_item) ap;
	  virtual enc_interface  enc_vif;

	  `uvm_component_utils(enc_monitor)

	  function new(string name="", uvm_component parent);
	     super.new(name, parent);
	  endfunction

	  virtual function void build_phase(uvm_phase phase);
	      if (!(uvm_config_db#(virtual enc_interface)::get(this,"","enc_interface", enc_vif))) begin
	         `uvm_fatal("FATAL", "Can't get interface enc_interface\n");
	      end
	      ap = new("enc_monitor_analysis_port", this);
	  endfunction

	  task run_phase(uvm_phase phase);
	     enc_seq_item itm;
	     while (1) begin
	        itm = enc_seq_item::type_id::create("itm");
	        @(enc_vif.mcb);
	        @(negedge enc_vif.clock);
	        itm.msg = enc_vif.msg;
	        itm.key = enc_vif.key;
	        itm.cipher = enc_vif.cipher;
	        `uvm_info("MON", $sformatf("3: DEBUG: @time %0t, msg=%0d, key=%0d, cipher=%0d", $time, enc_vif.msg, enc_vif.key, enc_vif.cipher), UVM_HIGH);
	        ap.write(itm);
	     end
	  endtask

	endclass

	class enc_scoreboard extends uvm_scoreboard;
	  uvm_analysis_imp #(enc_seq_item, enc_scoreboard) enc_item_collected_export;

	  GRDESENC gr_encr;
	  logic [63:0] gr_cipher;

	  `uvm_component_utils(enc_scoreboard)

	  function new(string name="", uvm_component parent);
	    super.new(name, parent);
	  endfunction

	  virtual function void build_phase(uvm_phase phase);
	    enc_item_collected_export = new("enc_item_collected_export", this);
	  endfunction

	  virtual function void write(enc_seq_item itm);
	       `uvm_info("SCBD", $sformatf("@time %0t, printing msg=%0d, key=%0d, cipher=%0d", $time, itm.msg, itm.key, itm.cipher), UVM_LOW);
	       gr_encr = new();
	       gr_cipher = gr_encr.encryption(itm.key, itm.msg);
	       assert (gr_cipher == itm.cipher)
	       else
	          `uvm_error("MISMATCH", $sformatf("@time %0t, msg=%0d, key=%0d, cipher=%0d", $time, itm.msg, itm.key, itm.cipher));
	  endfunction

	endclass

	

	class enc_coverage_subscriber extends uvm_subscriber #(enc_seq_item);

	  uvm_analysis_imp #(enc_seq_item, enc_coverage_subscriber) enc_item_collected_export;
	  `uvm_component_utils(enc_coverage_subscriber)
	  enc_seq_item myitem;
	  typedef bit [63:0] uint64_t;

		uint64_t min = 0;
		uint64_t max = 2**64-1;
	  

	  covergroup mycov;
	  msg: coverpoint myitem.msg {
	   	bins msgmin = {min};
	  	bins msginter[10] = {[min+1:max-1]};
	  	bins msgmax = {max};
	   }
	  key: coverpoint myitem.key {
	    bins keymin = {min};
	  	bins keyinter[10] = {[min+1:max-1]};
	  	bins keymax = {max};
	  }
	  cipher: coverpoint myitem.cipher {
	    bins ciphermin = {min};
	  	bins cipherinter[10] = {[min+1:max-1]};
	  	bins ciphermax = {max};
	  }
	  endgroup : mycov

	  function new(string name="", uvm_component parent);
	    super.new(name, parent);
	    mycov = new();
	  endfunction

	  virtual function void build_phase(uvm_phase phase);
	    enc_item_collected_export = new("enc_item_collected_export", this);
	  endfunction
	  
	  function void write(enc_seq_item t);
	    myitem = t;
	    `uvm_info("COVSB", $sformatf("@time %0t, printing msg=%0d, key=%0d, cipher=%0d", $time, myitem.msg, myitem.key, myitem.cipher), UVM_HIGH);
	    mycov.sample();
	    `uvm_info("COVSB", $sformatf("@time %0t, Coverage = %3.2f percent\n", $time, mycov.get_coverage()), UVM_MEDIUM);
	  endfunction

	endclass

	class enc_agent extends uvm_agent;
	   uvm_sequencer #(enc_seq_item) enc_seqr;
	   enc_driver                enc_drvr;
	   enc_monitor               enc_mon;
	   enc_scoreboard            enc_scbd;
	   enc_coverage_subscriber   enc_cov;
	   uvm_active_passive_enum   is_active;

	   `uvm_component_utils(enc_agent)

	   function new(string name="", uvm_component parent);
	      super.new(name, parent);
	   endfunction

	   virtual function void build_phase(uvm_phase phase);
	     if (!(uvm_config_db#(uvm_active_passive_enum)::get(this,"","active_passive", is_active)) ) begin
	        `uvm_fatal("FATAL", "Can't get active_passive for agent\n");
	     end
	     if (is_active == UVM_ACTIVE) begin
	        enc_seqr = uvm_sequencer#(enc_seq_item)::type_id::create("enc_seqr", this);
	        enc_drvr = enc_driver::type_id::create("enc_drvr", this);
	     end
	     enc_mon = enc_monitor::type_id::create("enc_mon", this);
	     enc_scbd = enc_scoreboard::type_id::create("enc_scbd", this);
	     enc_cov = enc_coverage_subscriber::type_id::create("enc_cov", this);
	   endfunction

	   virtual function void connect_phase(uvm_phase phase);
	      if (is_active == UVM_ACTIVE) begin
	         enc_drvr.seq_item_port.connect(enc_seqr.seq_item_export);
	      end
	         enc_mon.ap.connect(enc_scbd.enc_item_collected_export);
	         enc_mon.ap.connect(enc_cov.enc_item_collected_export);
	   endfunction

	endclass

	class enc_env extends uvm_env;
	   enc_agent enc_agent_h;

	   `uvm_component_utils(enc_env)

	   function new(string name="", uvm_component parent);
	      super.new(name, parent);
	      enc_agent_h = enc_agent::type_id::create("enc_agent_h", this);
	      uvm_config_db#(uvm_active_passive_enum)::set(null, "*", "active_passive", UVM_ACTIVE);
	   endfunction

	endclass

	class enc_test extends uvm_test;
	    enc_seq seq_h;
	    enc_env env_h;
	   `uvm_component_utils(enc_test)

	   function new(string name="", uvm_component parent);
	      super.new(name, parent);
	      seq_h = enc_seq::type_id::create("seq_h", this);
	      env_h = enc_env::type_id::create("env_h", this);
	   endfunction
	   task run_phase(uvm_phase phase);
	      phase.raise_objection(this, "Raised objection in test");
	      seq_h.start(env_h.enc_agent_h.enc_seqr);
	      phase.drop_objection(this, "Dropped objection in test");
	   endtask
	endclass

endpackage

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