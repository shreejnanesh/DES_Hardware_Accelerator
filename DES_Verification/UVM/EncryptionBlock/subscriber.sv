
	class enc_coverage_subscriber extends uvm_subscriber #(enc_seq_item);

	  uvm_analysis_imp #(enc_seq_item, enc_coverage_subscriber) enc_item_collected_export;
	  `uvm_component_utils(enc_coverage_subscriber)
	  enc_seq_item myitem;
	  typedef bit [63:0] uint64_t;

		uint64_t min = 1;
		uint64_t max = 2**64-2;
	  

	  covergroup mycov;
	  msg: coverpoint myitem.msg {
	   	bins msgmin = {[min:min+1000]};
	  	bins msginter[1000] = {[min+1000:max-1000]};
	  	bins msgmax = {[max-1000:max]};
	   }
	  key: coverpoint myitem.key {
	    bins keymin = {[min:min+30]};
	  	bins keyinter[1000] = {[min+30:max-30]};
	  	bins keymax = {[max-30:max]};
	  }
	  cipher: coverpoint myitem.cipher {
	    bins ciphermin = {[min:min+30]};
	  	bins cipherinter[1000] = {[min+30:max-30]};
	  	bins ciphermax = {[max-30:max]};
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
