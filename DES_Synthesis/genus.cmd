# Cadence Genus(TM) Synthesis Solution, Version 18.10-p003_1, built Jun  7 2018 23:53:27

# Date: Wed Mar 10 18:45:19 2021
# Host: vlsi-09 (x86_64 w/Linux 2.6.32-696.20.1.el6.x86_64) (6cores*6cpus*1physical cpu*Intel(R) Core(TM) i5-8400 CPU @ 2.80GHz 9216KB)
# OS:   Red Hat Enterprise Linux Server release 6.9 (Santiago)

set_db init_lib_search_path ./
set_db init_hdl_search_path ./
set_db library fast.lib
gui_show
read_hdl -sv top.sv Encrypt.sv Fiestal.sv
exit
