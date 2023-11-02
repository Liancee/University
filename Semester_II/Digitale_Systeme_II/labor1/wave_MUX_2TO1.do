onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_mux_2to1/E
add wave -noupdate /testbench_mux_2to1/S
add wave -noupdate /testbench_mux_2to1/A
add wave -noupdate /testbench_mux_2to1/B
add wave -noupdate /testbench_mux_2to1/Y
add wave -noupdate /testbench_mux_2to1/DESIRED_CONDITION
add wave -noupdate /testbench_mux_2to1/Y_XNOR_DESIRED_CONDITION
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 256
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
WaveRestoreZoom {0 ps} {162 ns}
