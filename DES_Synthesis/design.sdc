
set_units -time 1ns

create_clock -name clk -period 1 [get_ports clk]
create_clock -name VCLK -period 1 

set_clock_uncertainty -setup 0.1 [get_clocks clk]
set_clock_uncertainty -hold 0.03 [get_clocks clk]

set_input_delay -clock VCLK  0.40 [all_inputs]
set_output_delay -clock VCLK  0.40 [all_outputs]

set_input_transition 0.05 [remove_from_collection [all_inputs] clk]

set_load 0.01 [get_ports -filter {port_direction == out}]

