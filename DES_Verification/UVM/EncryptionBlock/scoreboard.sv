
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
