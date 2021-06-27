class generator;

	rand transaction trans;

	mailbox gen2Driv;

	int rptCount;

	function new (mailbox gen2Driv);
		this.gen2Driv=gen2Driv;
	endfunction 

	event ended;

	task main();
		repeat(rptCount) begin 
			trans = new();
			if(!trans.randomize())
				$display("Gen:: transaction randomization failed");
			gen2Driv.put(trans);
		end
		-> ended;
	endtask : main

endclass : generator