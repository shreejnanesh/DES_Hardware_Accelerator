class transaction;

	rand logic [64:1] msg;
	rand logic [64:1] key;
	logic [64:1] cipher;
	logic [64:1] decrypt;

	function void displayenc (string name);
		$display("---------------");
		$display("%s Input Generated",name);
		$display("---------------");
		$display("Msg: %d",msg);
		$display("key: %d",key);
		$display("---------------");
		$display("Output Observed");
		$display("---------------");
		$display("Cipher: %d",cipher);
		$display("---------------");
	endfunction 
	function void displaydec (string name);
		$display("---------------");
		$display("%s Input Generated",name);
		$display("---------------");
		$display("Cipher: %d",cipher);
		$display("key: %d",key);
		$display("---------------");
		$display("Output Observed");
		$display("---------------");
		$display("Decrypt: %d",decrypt);
		$display("---------------");
	endfunction 
	
endclass : transaction

