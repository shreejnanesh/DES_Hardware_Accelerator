/*`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

*/
class environment;

	generator gen;
	driver driv;
	monitor mon;
	scoreboard scb;

	mailbox gen2driv;
	mailbox mon2scb;

	virtual intf vif;

	function new(virtual intf vif);
		this.vif=vif;
		gen2driv = new();
		mon2scb = new();

		gen = new(gen2driv);
		driv = new(vif,gen2driv);
		mon = new(vif,mon2scb);
		scb = new(mon2scb);
	endfunction


	task preTest();
    driv.reset();
  	endtask
   
  	task test();
    	fork
    	gen.main();
    	driv.main();
    	mon.main();
    	scb.main();
    	join_any
  	endtask
   
  	task postTest();
    	wait(gen.ended.triggered);
    	wait(gen.rptCount == driv.noOfTrans);
    	wait(gen.rptCount == scb.noOfTransactions);
  	endtask 
   
  
  	task run;
    	preTest();
    	test();
   		postTest();
    	$finish;
  	endtask

endclass : environment