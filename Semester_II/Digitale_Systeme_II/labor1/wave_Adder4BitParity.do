onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_adder4bitparity/A
add wave -noupdate /testbench_adder4bitparity/B
add wave -noupdate /testbench_adder4bitparity/SUM
add wave -noupdate /testbench_adder4bitparity/SUM_DESIRED_CONDITION
add wave -noupdate /testbench_adder4bitparity/EVEN_PARITY
add wave -noupdate /testbench_adder4bitparity/EVEN_PARITY_DESIRED_CONDITION
add wave -noupdate /testbench_adder4bitparity/EVEN_PARITY_XNOR_DESIRED_CONDITION
add wave -noupdate /testbench_adder4bitparity/ODD_PARITY
add wave -noupdate /testbench_adder4bitparity/ODD_PARITY_DESIRED_CONDITION
add wave -noupdate /testbench_adder4bitparity/ODD_PARITY_XNOR_DESIRED_CONDITION
add wave -noupdate /testbench_adder4bitparity/SUM_XNOR_DESIRED_CONDITION4
add wave -noupdate /testbench_adder4bitparity/SUM_XNOR_DESIRED_CONDITION3
add wave -noupdate /testbench_adder4bitparity/SUM_XNOR_DESIRED_CONDITION2
add wave -noupdate /testbench_adder4bitparity/SUM_XNOR_DESIRED_CONDITION1
add wave -noupdate /testbench_adder4bitparity/SUM_XNOR_DESIRED_CONDITION0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 361
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
WaveRestoreZoom {0 ps} {80 ns}
