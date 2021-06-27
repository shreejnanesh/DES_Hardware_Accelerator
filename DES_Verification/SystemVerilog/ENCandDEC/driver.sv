class driver;

	int noOfTrans;

	virtual intf vif;

	mailbox gen2driv;

	function new (virtual intf vif, mailbox gen2driv);
		this.vif=vif;
		this.gen2driv=gen2driv;
	endfunction 

	task reset();
		wait(vif.reset);
		$display("[Driver]--Reset Started--");
		vif.cipher <= 64'd0;
		vif.decrypt <= 64'd0;
		wait(!vif.reset);
		$display("[Driver]--Reset Ended--");
	endtask : reset

	task main();
		forever begin 
			transaction trans;
			gen2driv.get(trans);
			@(posedge vif.clk)	
			vif.msg <= trans.msg;
			vif.key <= trans.key;
			
			@(posedge vif.clk)
			trans.cipher = vif.cipher;

/*

			@(posedge vif.clk);					//-------//
			vif.cipher <= trans.cipher;
			vif.key <= trans.key;
*/


			@(posedge vif.clk)	
			trans.decrypt = vif.decrypt;
			
		
//			@(posedge vif.clk);
			trans.displayenc("[Driver - ENC ]");

//			@(posedge vif.clk);
			trans.displaydec("[Driver - DEC ]");

			noOfTrans++;
		end
	endtask : main

endclass : driver