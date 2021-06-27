# **[Manipal_codeRepo](https://github.com/shreejnanesh/Manipal_codeRepo)**

###UVM ENVIRONMENT DEC

- To Run (Questa)
Go to the project Directory then Run these commands in transcript.

```
> vlog -coveropt 3 +cover +incdir+C:/questasim64_10.6c/verilog_src/uvm-1.1d/src +incdir+C:/questasim64_10.6c/verilog_src/uvm-1.1d/src C:/questasim64_10.6c/verilog_src/uvm-1.1d/src/uvm.sv  +incdir+. top.sv +define+UVM_NO_DPI
> vsim -coverage -vopt work.dec_top -c -do "coverage save -onexit -directive -codeAll coverage2.ucdb; run -all"
> vcover report -html coverage2.ucdb
```

>  Code by ***shree Jnanesh***