class dram_seq extends uvm_sequence#(dram_seq_item);
`uvm_object_utils(dram_seq)
dram_seq_item pkt;


function new(string name="dram_seq");
super.new(name);
endfunction

task body();
pkt=dram_seq_item::type_id::create("pkt");
repeat(100)
begin
start_item(pkt);
assert(pkt.randomize());
pkt.wr=0;
pkt.print();
//$display("1 data_in=%d,add=%d,wr=%d",pkt.data_in,pkt.add,pkt.wr);
finish_item(pkt);

start_item(pkt);
pkt.wr=1;
pkt.print();
//$display("2 data_in=%d,add=%d,wr=%d",pkt.data_in,pkt.add,pkt.wr);
finish_item(pkt);

`uvm_info("SEQ","SEQUENCE TRANSACTIONS",UVM_NONE);
end
endtask
endclass
