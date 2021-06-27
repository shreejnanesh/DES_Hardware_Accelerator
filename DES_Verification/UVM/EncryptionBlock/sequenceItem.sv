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

	    //constraint enc_seq_item_c {
			//msg inside {[0:100]};
			//msg dist {0:=25,[1:2**64-2]:=75,2**64-1:=25};
			//msg inside {[0:(2**64)]};
	        //key inside {[0:(2**64)]};
	    //}

	endclass: enc_seq_item