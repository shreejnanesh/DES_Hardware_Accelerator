# **[DES_Hardware_Accelerator](https://github.com/shreejnanesh/DES_Hardware_Accelerator)**

### SV Verification Decyption DES

To Run (Cadence)
Go to the project Directory then Run these commands in terminal.

```
>  irun -sv transaction.sv generator.sv interface.sv driver.sv  monitor.sv grDesEnc.sv grDesDec.sv scoreboard.sv  dut.sv dutdec.sv environment.sv test.sv  top.sv 
>  irun -sv transaction.sv generator.sv interface.sv driver.sv  monitor.sv grDesEnc.sv grDesDec.sv scoreboard.sv  dut.sv dutdec.sv environment.sv test.sv  top.sv  -access rw +gui
```

>  Code by ***shree Jnanesh***
