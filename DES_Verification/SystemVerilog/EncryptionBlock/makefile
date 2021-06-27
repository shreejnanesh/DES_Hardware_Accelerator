FILE_NAME ?= transaction.sv generator.sv interface.sv driver.sv  monitor.sv grDesEnc.sv grDesDec.sv scoreboard.sv dut.sv dutdec.sv environment.sv test.sv top.sv

help: 
	@echo "Below are the Options:"
	@echo "make cmd: Compile and Executes the code"
	@echo "make gui: Compile and Executes the code then opens the gui"
	@echo "make clean: Removes all temporary files and compiled files"
	@echo "veride variables."
	@echo "FILE_NAME : overide if you need to have Custom SV files"

.PHONY: cmd
cmd: Reset_console
	irun -sv $(FILE_NAME)

.PHONY: gui
gui: Reset_console
	irun -sv $(FILE_NAME) -access rw +gui

clean: Reset_console
	@ rm -rf INCA_libs waves.shm run.txt ncelab.err irun.key irun.log verilog.dump

Reset_console:
	reset