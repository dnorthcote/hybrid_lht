# HDL Coder Downstream Integration Tcl Script

set myTool "Xilinx Vivado 2019.1"
set myProject "Hybrid_LHT_vivado"
set myProjectFile "Hybrid_LHT_vivado.xpr"
set myTopLevelEntity "Hybrid_LHT"

set Family "Zynq UltraScale+"
set Device "xczu7ev-ffvc1156-2-e"
set Package ""
set Speed ""
set MapTimePathNumber "3"
set MapTimeAdvAnalysis "True"
set PARTimePathNumber "3"
set PARTimeAdvAnalysis "True"

# Open existing project
puts "### Open existing $myTool project hdl_prj_333_Zhou\\vivado_prj\\Hybrid_LHT_vivado.xpr"
open_project ${myProject}

# Running Implementation
puts "### Running Implementation in $myTool ..."
if { [llength [get_runs impl_1] ] > 0 } { reset_run impl_1}
launch_runs impl_1 -force
wait_on_run impl_1
puts "### Implementation Complete."

# Running PostPARTiming
puts "### Running PostPARTiming in $myTool ..."
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained -check_timing_verbose -max_paths $PARTimePathNumber -nworst $PARTimePathNumber -name timing_post_route -file timing_post_route.rpt
source -quiet "C:\\Program Files\\MATLAB\\R2019b\\toolbox\\hdlcoder\\hdlcommon\\+downstreamtools\\extractVivadoTiming.tcl"
extracTimingReport ${myTopLevelEntity}_postroute.tvr
puts "### PostPARTiming Complete."

# Close project
puts "### Close $myTool project."
close_project

