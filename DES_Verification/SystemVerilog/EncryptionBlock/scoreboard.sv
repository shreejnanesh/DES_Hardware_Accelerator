`include "grDesEnc.sv"

class scoreboard;

	mailbox mon2scb;

	int noOfTransactions;

	reg [64:1] GRencrypt, GRdecrypt;

	GRDESENC grEncDut;

	function new (mailbox mon2scb);
		this.mon2scb = mon2scb;	
	endfunction  

	task main();
		transaction trans;
		forever begin 
			mon2scb.get(trans);
			grEncDut = new;
			GRencrypt = grEncDut.encryption(trans.key,trans.msg);
			if (GRencrypt == trans.cipher) 
				$display("Result is as Expected");
			else
				$display("Wrong Result. ENC: \n \t Expected : %d Actual: %d\n",GRencrypt,trans.cipher);
			noOfTransactions++;
			trans.displayenc("[ scoreboard - ENC ]");
		end
	endtask : main

endclass : scoreboard

