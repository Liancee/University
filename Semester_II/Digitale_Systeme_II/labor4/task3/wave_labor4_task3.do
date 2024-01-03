onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_labor4_task3/Reset
add wave -noupdate /testbench_labor4_task3/Clk
add wave -noupdate /testbench_labor4_task3/X
add wave -noupdate /testbench_labor4_task3/a
add wave -noupdate /testbench_labor4_task3/b
add wave -noupdate /testbench_labor4_task3/c
add wave -noupdate /testbench_labor4_task3/Y_Actual
add wave -noupdate /testbench_labor4_task3/Y_Desired
add wave -noupdate /testbench_labor4_task3/Y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19291 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
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
WaveRestoreZoom {0 ps} {250 ns}
