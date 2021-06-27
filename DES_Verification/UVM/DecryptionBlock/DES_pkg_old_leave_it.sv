package dec_pkg;

	import uvm_pkg::*;
	`include "grDesDec.sv"
	
	class dec_seq_item extends uvm_sequence_item		
		rand logic [63:0] key;		
		rand logic [63:0] cipher;	
			 logic [63:0] decrypt;
			 
		`uvm_object_utils_begin(dec_seq_item)
      		`uvm_field_int(cipher, UVM_ALL_ON)
      		`uvm_field_int(key, UVM_ALL_ON)
   		`uvm_object_utils_end

   		function new(string name="");
   			super.new(name);
   		endfunction

   		//constraint transaction_a {
   		//	cipher > 0; key > 0;
   		//}
   	endclass

   	class dec_driver extends uvm_driver #(dec_seq_item);

   		virtual dec_interface dec_vif;
   		`uvm_component_utils(dec_driver)

   		function new(string name="", uvm_component parent);
   			super.new(name,parent);
   		endfunction

   		virtual function void build_phase(uvm_phase phase);
   			if(!(uvm_config_db#(virtual dec_interface)::get(this,"","dec_interface",dec_vif)) ) begin
   				`uvm_fatal("FATAL", "Can't get interface dec_vif\n");
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
        dec_seq_item itm;
        while(1) begin
           itm = dec_seq_item::type_id::create("itm");
           seq_item_port.get_next_item(itm);
           @(dec_vif.dcb);
           dec_vif.cipher = itm.cipher;
           dec_vif.key = itm.key;
           `uvm_info("DRV", $sformatf("1: DEBUG: @time %0t, Cipher=%0h, Key=%0h", $time, dec_vif.cipher, dec_vif.key), UVM_HIGH);
           seq_item_port.item_done();
        end
   		endtask
   	endclass

   	//Sequence
   	class dec_seq extends uvm_sequence #(dec_seq_item);
   		`uvm_object_utils(dec_seq)

   		function new(string name="");
   			super.new(name);
   		endfunction

   		task body();
   			dec_seq_item itm;
   			for(int i=0;i<1000;i++) begin
   				itm=dec_seq_item::type_id::create("itm");
   				start_item(itm);
   				assert(itm.randomize());
   				`uvm_info("SEQ",$sformatf("2: DEBUG: @time %0t,Seqitem %0d generated => cipher=%0h, key=%0h", $time, i, itm.cipher, itm.key), UVM_HIGH);
   				finish_item(itm);
   			end
   		endtask
   	endclass

   	//Monitor 

   	class dec_monitor extends uvm_monitor;
   		uvm_analysis_port#(dec_seq_item) ap;
   		virtual dec_interface dec_vif;

   		`uvm_component_utils(dec_monitor)

   		function new(string name="", uvm_component parent);
   			super.new(name,parent);
   		endfunction

   		virtual function void build_phase(uvm_phase phase);
   			if(!(uvm_config_db#(virtual dec_interface)::get(this,"","dec_interface",dec_vif))) begin
   				`uvm_fatal("FATAL", "Cant get interface dec_interface\n");
   			end
   			ap = new("Decrypt_monitor_analysis_port",this);
   		endfunction

   		task run_phase(uvm_phase phase);
   			dec_seq_item itm;
   			while(1) begin
   				itm = dec_seq_item::type_id::create("itm");
   				@(dec_vif.mcb);
   				@(negedge dec_vif.clk);
   				itm.cipher = dec_vif.cipher;
   				itm.key = dec_vif.key;
   				itm.decrypt = dec_vif.decrypt;
   				`uvm_info("MON", $sformatf("3: DEBUG: @time %0t, cipher=%0h, key=%0h, decrypt=%0h", $time, dec_vif.cipher, dec_vif.key, dec_vif.decrypt), UVM_HIGH);
   				ap.write(itm);
   			end
   		endtask
   	endclass

   	//Scoreboard

   	class dec_scoreboard extends uvm_scoreboard;
   		uvm_anaysis_imp #(dec_seq_item, dec_scoreboard) dec_item_collected_export;

   		`uvm_component_utils(dec_scoreboard)

   		GRDESDEC gr_decr;

   		function new(string name="", uvm_component parent);
   			super.new(name,parent);
   		endfunction

   		virtual function void build_phase(uvm_phase phase);
   			dec_item_collected_export = new("dec_item_collected_export",this);
   		endfunction

   		virtual function void write(dec_seq_item itm);
   			`uvm_info("SCBD", $sformatf("@time %0t, printing cipher=%0h, key=%0h, decrypt=%0h", $time, itm.cipher, itm.key, itm.decrypt), UVM_LOW);
   			gr_decr = new();
			//Immediate assertion that acts as checker
   			//Insert a assert here that checks for DES Decrypt
   			assert(gr_decr.decryption(itm.key,itm.cipher) == itm.decrypt)
   			else
   				`uvm_error("MISMATCH", $sformatf("@time %0t, cipher=%0h, key=%0h, decrypt=%0h",$time, itm.cipher, itm.key, itm.decrypt));
   		endfunction
   	endclass

   	//Coverage

   	class dec_coverage_subscriber extends uvm_subscriber #(dec_seq_item);

   		uvm_analysis_imp #(dec_seq_item, dec_coverage_subscriber) dec_item_collected_export;
   		`uvm_component_utils(dec_coverage_subscriber)

   		dec_seq_item myitem;

   		bit ptr[192];
		
   		covergroup mycov;
   			cipher: coverpoint myitem.cipher {
   				bins ptr = {0,1};
   			}
   			key: coverpoint myitem.key {
   				bins ptr = {0,1};
   			}
   			decrypt: coverpoint myitem.decrypt {
   				bins ptr = {0,1};
   			}
   		endgroup

   		function new(string name="",uvm_component parent);
   			super.new(name,parent);
   			mycov = new();
   		endfunction

   		virtual function void build_phase(uvm_phase phase);
   			dec_item_collected_export = new("dec_item_collected_export",this);
   		endfunction

   		function void write(dec_seq_item t);
   			myitem = t;
   			`uvm_info("COVSB", $sformatf("@time %0t, printing cipher=%0h, key=%0h, decrypt=%0h", $time, itm.cipher, itm.key, itm.decrypt), UVM_HIGH);
   			mycov.sample();
   			`uvm_info("COVSB", $sformatf("@time %0t, Coverage%3.2f percent\n", $time, mycov.get_coverage()), UVM_MEDIUM);
   		endfunction

   	endclass

   	//Agent

   	class dec_agent extends uvm_agent;
   		uvm_sequencer #(dec_seq_item) dec_seqr;
   		dec_driver 						dec_drvr;
   		dec_monitor						dec_mon;
   		dec_scoreboard					dec_scbd;
   		dec_coverage_subscriber			dec_cov;
   		uvm_active_passive_enum 		is_active;

   		`uvm_component_utils(dec_agent)

   		function new(string name="",uvm_component parent);
   			super.new(name,parent);
   		endfunction

   		virtual function void build_phase(uvm_phase phase);
   			if(!(uvm_config_db#(uvm_active_passive_enum)::get(this,"","active_passive", is_active))) begin
   				`uvm_fatal("FATAL", "Cant get active_passive for agent\n");
   			end
   			if(is_active == UVM_ACTIVE) begin
   				dec_seqr = uvm_sequencer#(dec_seq_item)::type_id::create("dec_seqr",this);
   				dec_drvr = dec_driver::type_id::create("dec_drvr",this);
   			end
   			dec_mon = dec_monitor::type_id::create("dec_mon", this);
   			dec_scbd = dec_scoreboard::type_id::create("dec_scbd",this);
   			dec_cov = dec_coverage_subscriber::type_id::create("dec_cov",this);
   		endfunction

   		virtual function void connect_phase(uvm_phase phase);
      		if (is_active == UVM_ACTIVE) begin
         		dec_drvr.seq_item_port.connect(dec_seqr.seq_item_export);
      		end
         	dec_mon.ap.connect(dec_scbd.dec_item_collected_export);
         	dec_mon.ap.connect(dec_cov.dec_item_collected_export);
   		endfunction

	endclass

// Environment 

	class dec_env extends uvm_env;
   		dec_agent dec_agent_h;

   		`uvm_component_utils(dec_env)

	   function new(string name="", uvm_component parent);
	      super.new(name, parent);
	      dec_agent_h = dec_agent::type_id::create("dec_agent_h", this);
	      uvm_config_db#(uvm_active_passive_enum)::set(null, "*", "active_passive", UVM_ACTIVE);
	   endfunction
	   
	endclass

	// Test 
	class dec_test extends uvm_test;
	    dec_seq seq_h;
	    dec_env env_h;
	   `uvm_component_utils(dec_test)

	   function new(string name="", uvm_component parent);
	      super.new(name, parent);
	      seq_h = dec_seq::type_id::create("seq_h", this);
	      env_h = dec_env::type_id::create("env_h", this);
	   endfunction
	   
	   task run_phase(uvm_phase phase);
	      phase.raise_objection(this, "Raised objection in test");
	      seq_h.start(env_h.dec_agent_h.dec_seqr);
	      phase.drop_objection(this, "Dropped objection in test");
	   endtask
	   
	endclass
	
endpackage // Contains all the testbench components



