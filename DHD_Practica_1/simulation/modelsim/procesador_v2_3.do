view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ns -endtime 8ns sim:/my_scomp_v0_0/reloj 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 8ns sim:/my_scomp_v0_0/reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 50ps Edit:/my_scomp_v0_0/reset 
wave modify -driver freeze -pattern clock -initialvalue 1 -period 100ps -dutycycle 50 -starttime 0ns -endtime 8ns Edit:/my_scomp_v0_0/reloj 
WaveCollapseAll -1
wave clipboard restore
