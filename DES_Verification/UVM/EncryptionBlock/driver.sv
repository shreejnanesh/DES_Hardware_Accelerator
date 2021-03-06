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
