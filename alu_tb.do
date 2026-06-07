# =============================================================
# Project: 8-bit ALU
# Author: Creighton Townsley, Wakana Sakane, Trevor Bahm
# Description: ModelSim do file — loads the ALU testbench,
#              adds all signals to waveform, and runs simulation.
# Date: June 2026
# =============================================================

# Load the testbench
vsim -gui work.alu_tb

# Add all top-level testbench signals
add wave *

# Add internal signals from alu_top
add wave -radix hex    sim:/alu_tb/uut/reg_A
add wave -radix hex    sim:/alu_tb/uut/reg_B
add wave -radix binary sim:/alu_tb/uut/current_opcode
add wave -radix binary sim:/alu_tb/uut/display_enable
add wave -radix hex    sim:/alu_tb/uut/alu_out
add wave -radix binary sim:/alu_tb/uut/selected_overflow

# Run simulation
run -all
