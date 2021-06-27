`include "grDesDec.sv"
//`include "grDesEnc.sv"
class scoreboard;

	mailbox mon2scb;

	int noOfTransactions;

	//reg [64:1] GRencrypt, GRdecrypt;
	reg [64:1] GRdecrypt;

//	GRDESENC grEncDut;
	GRDESDEC grDecDut;

	function new (mailbox mon2scb);
		this.mon2scb = mon2scb;	
	endfunction  

	task main();
		transaction trans;
		forever begin 
			mon2scb.get(trans);
//			grEncDut = new;
			grDecDut = new;
//			GRencrypt = grEncDut.encryption(trans.key,trans.msg);
			GRdecrypt = grDecDut.decryption(trans.key,trans.cipher);
//			if (GRencrypt == trans.cipher) //&& GRdecrypt == trans.decrypt
			if (GRdecrypt == trans.decrypt)
				$display("Result is as Expected");
			else
//				$display("Wrong Result. ENC: \n \t Expected : %d Actual: %d\n",GRencrypt,trans.cipher);
				$display("Wrong Result. DEC: \n \t Expected : %d Actual: %d\n",GRdecrypt,trans.decrypt);
			noOfTransactions++;
//			trans.displayenc("[ scoreboard - ENC ]");
			trans.displaydec("[ scoreboard - DEC ]");
		end
	endtask : main

endclass : scoreboard

