interface intf (input logic clk, reset);
//	logic [64:1]msg;
	logic [64:1]key;
	logic [64:1]cipher;
	logic [64:1]decrypt;

//	clocking eClk @(posedge clk);
//		default input #1 output#1;
//		output msg,key;
//		input cipher;
//	endclocking

	clocking dClk @(posedge clk);			// Decryption clock @negedge
		default input #1 output#1;
		output cipher,key;
		input decrypt;
	endclocking

//	modport encrPorts (clocking eClk);
	modport decrPorts (clocking dClk);

//	modport DUTenc( input clk, msg, key,output cipher);
	modport DUTdec( input clk, cipher, key,output decrypt);
endinterface :intf 