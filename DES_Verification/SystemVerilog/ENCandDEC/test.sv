/*`include "environment.sv"*/

program test(intf intf);

	environment env;

	initial begin
		env = new(intf);
		env.gen.rptCount=20;
		env.run();
	end

endprogram