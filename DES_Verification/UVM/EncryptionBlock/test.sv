
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
