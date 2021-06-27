#cd C:/Users/jnane/Documents/GitHub/Manipal_codeRepo/SemisterTwo/Project/DES_Verification/UVM/EncryptionBlock
vlog -coveropt 3 +cover +incdir+C:/questasim64_10.6c/verilog_src/uvm-1.1d/src +incdir+C:/questasim64_10.6c/verilog_src/uvm-1.1d/src C:/questasim64_10.6c/verilog_src/uvm-1.1d/src/uvm.sv  +incdir+. ENC_top.sv +define+UVM_NO_DPI
vsim -coverage -vopt work.enc_top -c -do "coverage save -onexit -directive -codeAll coverage2.ucdb; run -all"
