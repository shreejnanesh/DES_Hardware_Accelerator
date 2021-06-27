class dram_seq_item extends uvm_sequence_item;
`uvm_object_utils(dram_seq_item)

rand bit[63:0] data_in;
rand bit[5:0] add;
bit wr;
bit en;
bit[63:0] data_out;


function new(string name="dram_seq_item");
super.new(name);
endfunction

endclass
