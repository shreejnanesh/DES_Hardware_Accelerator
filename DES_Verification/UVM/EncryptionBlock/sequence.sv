class enc_seq extends uvm_sequence #(enc_seq_item);
	   `uvm_object_utils(enc_seq)

	   function new(string name="");
	      super.new(name);
	   endfunction

	   task body();
	       enc_seq_item itm;
	       for (int i = 0; i<100; i++) begin
	          itm = enc_seq_item::type_id::create("itm");
	          start_item(itm);
	          assert(itm.randomize());
	          `uvm_info("SEQ", $sformatf("2: DEBUG: @time %0t, Seqitem %0d generated => msg=%0d, key=%0d", $time, i, itm.msg, itm.key), UVM_HIGH);
	          finish_item(itm);
	       end
	   endtask

	endclass
