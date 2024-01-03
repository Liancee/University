onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_labor4_task2/c
add wave -noupdate -expand /testbench_labor4_task2/X
add wave -noupdate /testbench_labor4_task2/P
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3308 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 186
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
WaveRestoreZoom {182 ps} {105254 ps}
