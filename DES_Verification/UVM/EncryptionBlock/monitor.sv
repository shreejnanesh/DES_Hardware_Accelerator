
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
