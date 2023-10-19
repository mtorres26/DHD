onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /my_scomp_v0_0/reloj
add wave -noupdate /my_scomp_v0_0/reset
add wave -noupdate /my_scomp_v0_0/IR_out
add wave -noupdate /my_scomp_v0_0/AC_out
add wave -noupdate /my_scomp_v0_0/PC_out
add wave -noupdate /my_scomp_v0_0/PROC/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {177 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 209
configure wave -valuecolwidth 119
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {977 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ns -endtime 8ns sim:/my_scomp_v0_0/reloj 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 8ns sim:/my_scomp_v0_0/reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 50ps Edit:/my_scomp_v0_0/reset 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 100ps -dutycycle 50 -starttime 0ns -endtime 8ns Edit:/my_scomp_v0_0/reloj 
WaveCollapseAll -1
wave clipboard restore
