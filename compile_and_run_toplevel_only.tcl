# Call command to elaborate your design and testbench.
vlog "D:/Cinna-BoN-FPGA-TB/cinnabontb.v"
elab
#
# Run the simulation.

add wave *

wave zoom out 16

run 1us

