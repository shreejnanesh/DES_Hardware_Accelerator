
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
