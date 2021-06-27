# **[Manipal_codeRepo](https://github.com/shreejnanesh/Manipal_codeRepo)**

### SV Verification DRAM

To Run (Questa)
Go to the project Directory then Run these commands in transcript.

```
> vlib work
> vlog -coveropt 3 +cover +acc top.sv
> vsim -coverage -vopt work.top -c -do "coverage save -onexit -directive -codeAll coverage.ucdb; run 1000"
> vcover report -html coverage.ucdb
```

>  Code by ***shree Jnanesh***