onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UartRxrTB/r_fakeclock
add wave -noupdate /UartRxrTB/r_dataline
add wave -noupdate /UartRxrTB/w_data_ready
add wave -noupdate /UartRxrTB/w_data_byte
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {280 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {1 ns}
