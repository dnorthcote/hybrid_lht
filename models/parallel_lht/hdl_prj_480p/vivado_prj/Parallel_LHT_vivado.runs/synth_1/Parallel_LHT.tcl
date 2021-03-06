# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xczu7ev-ffvc1156-2-e

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/vivado_prj/Parallel_LHT_vivado.cache/wt [current_project]
set_property parent.project_path C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/vivado_prj/Parallel_LHT_vivado.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/SimpleDualPortRAM_generic.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Simple_Dual_Port_RAM.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Block_RAM.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Accumulator.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Accumulator_Controller.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Parallel_LHT_pkg.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Accumulator_with_Switches.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/MATLAB_Function.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Register_Bank.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Look_Ahead_Hough.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Hough_Kernel_Symmetric.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Hough_Kernel_Symmetric_Look_Ahead.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Hough_Kernel.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Parallel_LHT_Kernel.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Parallel_LHT_Accumulator.vhd
  C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/Parallel_LHT.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/clock_constraint.xdc
set_property used_in_implementation false [get_files C:/hybrid_lht/models/parallel_lht/hdl_prj_480p/hdlsrc/parallel_lht/clock_constraint.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top Parallel_LHT -part xczu7ev-ffvc1156-2-e -mode out_of_context


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Parallel_LHT.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Parallel_LHT_utilization_synth.rpt -pb Parallel_LHT_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
