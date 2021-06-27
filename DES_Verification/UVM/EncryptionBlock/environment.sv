
	class enc_env extends uvm_env;
	   enc_agent enc_agent_h;

	   `uvm_component_utils(enc_env)

	   function new(string name="", uvm_component parent);
	      super.new(name, parent);
	      enc_agent_h = enc_agent::type_id::create("enc_agent_h", this);
	      uvm_config_db#(uvm_active_passive_enum)::set(null, "*", "active_passive", UVM_ACTIVE);
	   endfunction

	endclass
