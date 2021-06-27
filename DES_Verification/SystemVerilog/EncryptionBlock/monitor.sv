class monitor;

	virtual intf vif;

	mailbox mon2scb;

	function new (virtual intf vif, mailbox mon2scb);
		this.mon2scb = mon2scb;
		this.vif = vif;
	endfunction 

	

	task main();
		forever begin 
			transaction trans;
			trans = new();
			@(posedge vif.clk) 
			trans.msg = vif.msg;
			trans.key = vif.key;
			@(posedge vif.clk)
			trans.cipher = vif.cipher;			
			mon2scb.put(trans);
			trans.displayenc("[MONITOR] - ENC");
			
		end		
	endtask : main


endclass : monitor