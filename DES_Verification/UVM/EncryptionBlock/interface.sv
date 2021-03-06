interface enc_interface(input bit clock);
     logic [63:0] msg;
     logic [63:0] key;
     logic [63:0] cipher;

   clocking dcb @(negedge clock);
     output  msg;
     output  key;
   endclocking

   clocking mcb @(negedge clock);
     input msg;
     input key;
     input cipher;
   endclocking
endinterface