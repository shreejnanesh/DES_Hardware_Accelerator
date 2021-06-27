# **[Manipal_codeRepo](https://github.com/shreejnanesh/Manipal_codeRepo)**

### UVM ENVIRONMENT DRAM


- TO run (Questa)
Go to the project Directory then Run these commands in transcript.

```
> vlog -coveropt 3 +cover +incdir+C:/questasim64_10.6c/verilog_src/uvm-1.1d/src +incdir+C:/questasim64_10.6c/verilog_src/uvm-1.1d/src C:/questasim64_10.6c/verilog_src/uvm-1.1d/src/uvm.sv  +incdir+. TOP.sv +define+UVM_NO_DPI
> vsim -coverage -vopt work.dram_top -c -do "coverage save -onexit -directive -codeAll coverage2.ucdb; run -all"
> vcover report -html coverage2.ucdb
```
- To view the schematic
`> vsim -debugDB dram_top`

- For the Coverage Report after ***simulation with coverage*** run this command in transcript
`> coverage report -all`

Go to View->Schematic

>  Code by ***shree Jnanesh***