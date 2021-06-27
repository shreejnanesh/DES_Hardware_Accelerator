interface dec_interface(input bit clk);
	logic [64:1]msg;
	logic [64:1]key;
	logic [64:1]cipher;
	logic [64:1]decrypt;

	clocking dcb @(negedge clk);			
		output cipher;
		output key;
	endclocking

	clocking mcb @(negedge clk);			
		input cipher;
		input key;
		input decrypt;
	endclocking
endinterface