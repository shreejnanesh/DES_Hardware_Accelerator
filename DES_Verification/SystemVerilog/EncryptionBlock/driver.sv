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

			@(posedge vif.clk)begin 
			vif.msg <= trans.msg;
			vif.key <= trans.key;
			end	
			
			@(posedge vif.clk) begin 
			trans.cipher = vif.cipher;
			end

			trans.displayenc("[Driver - ENC ]");

			noOfTrans++;
		end
	endtask : main

endclass : driver