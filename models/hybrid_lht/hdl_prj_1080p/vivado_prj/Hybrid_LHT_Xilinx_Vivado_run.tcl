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

if { ! [ file exists $myProjectFile ] } {
    # Create new project
    puts "### Create new $myTool project <a href=\"matlab:downstream.handle('Model','hybrid_lht').openTargetTool;\">hdl_prj_1080p\\vivado_prj\\Hybrid_LHT_vivado.xpr</a>"
    create_project $myProject -force

} else {
    # Open existing project
    puts "### Open existing $myTool project <a href=\"matlab:downstream.handle('Model','hybrid_lht').openTargetTool;\">hdl_prj_1080p\\vivado_prj\\Hybrid_LHT_vivado.xpr</a>"
    open_project ${myProject}

    # Remove Old HDL source files
    set files_to_delete [get_files]
      if { [llength $files_to_delete] > 0 } {
        remove_files [get_files]
      }

}

# Set project properties
puts "### Set $myTool project properties"
if { [string compare -nocase $Family "virtexu"] == 0 || [string compare -nocase $Family "kintexu"] == 0  || [string match -nocase "*ultrascale*" $Family] == 1 } {
     set_property PART $Device [current_project]
} else {
     set_property PART ${Device}${Package}${Speed} [current_project]
}

# Add HDL source files
puts "### Update $myTool project with HDL source files"
add_file \
    {../hdlsrc/hybrid_lht/Hybrid_LHT_pkg.vhd} \
    {../hdlsrc/hybrid_lht/SimpleDualPortRAM_generic.vhd} \
    {../hdlsrc/hybrid_lht/Simple_Dual_Port_RAM_Generator.vhd} \
    {../hdlsrc/hybrid_lht/Block_RAM.vhd} \
    {../hdlsrc/hybrid_lht/Accumulator.vhd} \
    {../hdlsrc/hybrid_lht/Accumulator_with_Switches.vhd} \
    {../hdlsrc/hybrid_lht/Accumulator_Controller.vhd} \
    {../hdlsrc/hybrid_lht/Hybrid_LHT_Accumulator.vhd} \
    {../hdlsrc/hybrid_lht/GetShift.vhd} \
    {../hdlsrc/hybrid_lht/Extract_Active_Votes.vhd} \
    {../hdlsrc/hybrid_lht/Extract_Active_Votes_block.vhd} \
    {../hdlsrc/hybrid_lht/GetShift1.vhd} \
    {../hdlsrc/hybrid_lht/Get_Index_and_Fix_Limits.vhd} \
    {../hdlsrc/hybrid_lht/Hough_Kernel.vhd} \
    {../hdlsrc/hybrid_lht/MATLAB_Function.vhd} \
    {../hdlsrc/hybrid_lht/Register_Bank.vhd} \
    {../hdlsrc/hybrid_lht/Look_Ahead_Hough_Symmetric.vhd} \
    {../hdlsrc/hybrid_lht/Look_Ahead_Hough.vhd} \
    {../hdlsrc/hybrid_lht/Hough_Kernel_block.vhd} \
    {../hdlsrc/hybrid_lht/Gradient_Kernel_System.vhd} \
    {../hdlsrc/hybrid_lht/Hybrid_LHT_Kernel.vhd} \
    {../hdlsrc/hybrid_lht/Hybrid_LHT.vhd} \
{../hdlsrc/hybrid_lht/clock_constraint.xdc} \
  
update_compile_order -fileset sources_1
foreach fs [get_files *.tcl] {
source $fs
}

set_property {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]
# Close project
puts "### Close $myTool project."
close_project

