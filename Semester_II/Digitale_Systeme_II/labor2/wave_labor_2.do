onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_labor_2/E
add wave -noupdate /testbench_labor_2/S
add wave -noupdate /testbench_labor_2/A
add wave -noupdate /testbench_labor_2/B
add wave -noupdate /testbench_labor_2/SUM
add wave -noupdate /testbench_labor_2/SUM_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/EVEN_PARITY
add wave -noupdate /testbench_labor_2/EVEN_PARITY_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/EVEN_PARITY_XNOR_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/ODD_PARITY
add wave -noupdate /testbench_labor_2/ODD_PARITY_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/ODD_PARITY_XNOR_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/P_IN
add wave -noupdate /testbench_labor_2/P_IN_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/P_IN_XNOR_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/Y
add wave -noupdate /testbench_labor_2/Y_DESIRED_CONDITION
add wave -noupdate /testbench_labor_2/Y_XNOR_DESIRED_CONDITION
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21814 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 345
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {160 ns}
