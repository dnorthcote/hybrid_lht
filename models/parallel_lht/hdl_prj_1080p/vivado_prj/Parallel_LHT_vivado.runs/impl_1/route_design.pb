
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xczu7ev2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xczu7ev2default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
�
�Clock port "%s" does not have an associated HD.CLK_SRC. Without this constraint, timing analysis may not be accurate and upstream checks cannot be done to ensure correct clock placement.
88*route2
clk2default:defaultZ35-197h px� 
�
�Port "%s" does not have an associated HD.PARTPIN_LOCS, which will prevent the partial routing of the signal "%s". Without this partial route, timing analysis to/from this port will not be accurate, and no routing information for this port can be exported.
89*route2

clk_enable2default:default2

clk_enable2default:defaultZ35-198h px� 
�
�Port "%s" does not have an associated HD.PARTPIN_LOCS, which will prevent the partial routing of the signal "%s". Without this partial route, timing analysis to/from this port will not be accurate, and no routing information for this port can be exported.
89*route2
reset2default:default2
reset2default:defaultZ35-198h px� 
�
�Port "%s" does not have an associated HD.PARTPIN_LOCS, which will prevent the partial routing of the signal "%s". Without this partial route, timing analysis to/from this port will not be accurate, and no routing information for this port can be exported.
89*route2 
s_axis_tlast2default:default2 
s_axis_tlast2default:defaultZ35-198h px� 
�
�Port "%s" does not have an associated HD.PARTPIN_LOCS, which will prevent the partial routing of the signal "%s". Without this partial route, timing analysis to/from this port will not be accurate, and no routing information for this port can be exported.
89*route2!
s_axis_tvalid2default:default2!
s_axis_tvalid2default:defaultZ35-198h px� 
�
�Port "%s" does not have an associated HD.PARTPIN_LOCS, which will prevent the partial routing of the signal "%s". Without this partial route, timing analysis to/from this port will not be accurate, and no routing information for this port can be exported.
89*route2 
s_axis_tuser2default:default2 
s_axis_tuser2default:defaultZ35-198h px� 
�
�Port "%s" does not have an associated HD.PARTPIN_LOCS, which will prevent the partial routing of the signal "%s". Without this partial route, timing analysis to/from this port will not be accurate, and no routing information for this port can be exported.
89*route2 
s_axis_tdata2default:default2 
s_axis_tdata2default:defaultZ35-198h px� 
C
.Phase 1 Build RT Design | Checksum: 1103bfda2
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:04 ; elapsed = 00:00:43 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
B
-Phase 2.1 Create Timer | Checksum: 17fbf76f3
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:44 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 17fbf76f3
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:44 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 17fbf76f3
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:05 ; elapsed = 00:00:44 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
{

Phase %s%s
101*constraints2
2.4 2default:default2,
Global Clock Net Routing2default:defaultZ18-101h px� 
N
9Phase 2.4 Global Clock Net Routing | Checksum: 1a6dc59e4
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:08 ; elapsed = 00:00:47 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
p

Phase %s%s
101*constraints2
2.5 2default:default2!
Update Timing2default:defaultZ18-101h px� 
C
.Phase 2.5 Update Timing | Checksum: 16b96a2fa
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:22 ; elapsed = 00:00:55 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=2.316  | TNS=0.000  | WHS=0.018  | THS=0.000  |
2default:defaultZ35-416h px� 
I
4Phase 2 Router Initialization | Checksum: 19ad037a2
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:31 ; elapsed = 00:01:01 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
C
.Phase 3 Initial Routing | Checksum: 1567bd3b5
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:42 ; elapsed = 00:01:08 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=0.187  | TNS=0.000  | WHS=0.042  | THS=0.000  |
2default:defaultZ35-416h px� 
G
2Phase 4.1 Global Iteration 0 | Checksum: c8fa4617
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:10 ; elapsed = 00:01:25 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
�

Phase %s%s
101*constraints2
4.2 2default:default21
Additional Iteration for Hold2default:defaultZ18-101h px� 
R
=Phase 4.2 Additional Iteration for Hold | Checksum: f430996a
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:10 ; elapsed = 00:01:25 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
E
0Phase 4 Rip-up And Reroute | Checksum: f430996a
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:10 ; elapsed = 00:01:25 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
B
-Phase 5.1 Delay CleanUp | Checksum: f430996a
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:10 ; elapsed = 00:01:25 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
L
7Phase 5.2 Clock Skew Optimization | Checksum: f430996a
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:10 ; elapsed = 00:01:25 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
N
9Phase 5 Delay and Skew Optimization | Checksum: f430996a
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:10 ; elapsed = 00:01:25 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 6.1.1 Update Timing | Checksum: 143007d80
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:16 ; elapsed = 00:01:29 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
�
Intermediate Timing Summary %s164*route2J
6| WNS=0.187  | TNS=0.000  | WHS=0.042  | THS=0.000  |
2default:defaultZ35-416h px� 
C
.Phase 6.1 Hold Fix Iter | Checksum: 143007d80
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:17 ; elapsed = 00:01:29 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
A
,Phase 6 Post Hold Fix | Checksum: 143007d80
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:17 ; elapsed = 00:01:29 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
z

Phase %s%s
101*constraints2
7 2default:default2-
Leaf Clock Prog Delay Opt2default:defaultZ18-101h px� 
M
8Phase 7 Leaf Clock Prog Delay Opt | Checksum: 136194978
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:23 ; elapsed = 00:01:33 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
o

Phase %s%s
101*constraints2
8 2default:default2"
Route finalize2default:defaultZ18-101h px� 
B
-Phase 8 Route finalize | Checksum: 1126eaae0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:24 ; elapsed = 00:01:34 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
v

Phase %s%s
101*constraints2
9 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
I
4Phase 9 Verifying routed nets | Checksum: 1126eaae0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:24 ; elapsed = 00:01:34 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
s

Phase %s%s
101*constraints2
10 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
F
1Phase 10 Depositing Routes | Checksum: 1126eaae0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:27 ; elapsed = 00:01:39 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
11 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
�
Estimated Timing Summary %s
57*route2J
6| WNS=0.187  | TNS=0.000  | WHS=0.042  | THS=0.000  |
2default:defaultZ35-57h px� 
�
�The final timing numbers are based on the router estimated timing analysis. For a complete and accurate timing signoff, please run report_timing_summary.
127*routeZ35-327h px� 
G
2Phase 11 Post Router Timing | Checksum: 1126eaae0
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:28 ; elapsed = 00:01:39 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:28 ; elapsed = 00:01:39 . Memory (MB): peak = 4466.746 ; gain = 0.0002default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
772default:default2
82default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:02:332default:default2
00:01:422default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0102default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:092default:default2
00:00:032default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
rC:/hybrid_lht/models/parallel_lht/hdl_prj_1080p/vivado_prj/Parallel_LHT_vivado.runs/impl_1/Parallel_LHT_routed.dcp2default:defaultZ17-1381h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:142default:default2
00:00:082default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
yExecuting : report_drc -file Parallel_LHT_drc_routed.rpt -pb Parallel_LHT_drc_routed.pb -rpx Parallel_LHT_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
lreport_drc -file Parallel_LHT_drc_routed.rpt -pb Parallel_LHT_drc_routed.pb -rpx Parallel_LHT_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
vC:/hybrid_lht/models/parallel_lht/hdl_prj_1080p/vivado_prj/Parallel_LHT_vivado.runs/impl_1/Parallel_LHT_drc_routed.rptvC:/hybrid_lht/models/parallel_lht/hdl_prj_1080p/vivado_prj/Parallel_LHT_vivado.runs/impl_1/Parallel_LHT_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:142default:default2
00:00:082default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file Parallel_LHT_methodology_drc_routed.rpt -pb Parallel_LHT_methodology_drc_routed.pb -rpx Parallel_LHT_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file Parallel_LHT_methodology_drc_routed.rpt -pb Parallel_LHT_methodology_drc_routed.pb -rpx Parallel_LHT_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�
�The property HD.CLK_SRC of clock port %s is not set. In out-of-context mode, this prevents timing estimation for clock delay/skew167*timing2
clkclk2default:default8Z38-242h px� 
�
�The property HD.CLK_SRC of clock port %s is not set. In out-of-context mode, this prevents timing estimation for clock delay/skew167*timing2,

clk_enable
clk_enable2default:default8Z38-242h px� 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
450*coretcl2�
�C:/hybrid_lht/models/parallel_lht/hdl_prj_1080p/vivado_prj/Parallel_LHT_vivado.runs/impl_1/Parallel_LHT_methodology_drc_routed.rpt�C:/hybrid_lht/models/parallel_lht/hdl_prj_1080p/vivado_prj/Parallel_LHT_vivado.runs/impl_1/Parallel_LHT_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:242default:default2
00:00:132default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_power -file Parallel_LHT_power_routed.rpt -pb Parallel_LHT_power_summary_routed.pb -rpx Parallel_LHT_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
|report_power -file Parallel_LHT_power_routed.rpt -pb Parallel_LHT_power_summary_routed.pb -rpx Parallel_LHT_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
892default:default2
102default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:272default:default2
00:00:192default:default2
4466.7462default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2y
eExecuting : report_route_status -file Parallel_LHT_route_status.rpt -pb Parallel_LHT_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -file Parallel_LHT_timing_summary_routed.rpt -pb Parallel_LHT_timing_summary_routed.pb -rpx Parallel_LHT_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
�
UpdateTimingParams:%s.
91*timing2O
; Speed grade: -2, Temperature grade: E, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
�
%s4*runtcl2i
UExecuting : report_incremental_reuse -file Parallel_LHT_incremental_reuse_routed.rpt
2default:defaulth px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
%s4*runtcl2i
UExecuting : report_clock_utilization -file Parallel_LHT_clock_utilization_routed.rpt
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file Parallel_LHT_bus_skew_routed.rpt -pb Parallel_LHT_bus_skew_routed.pb -rpx Parallel_LHT_bus_skew_routed.rpx
2default:defaulth px� 
�
UpdateTimingParams:%s.
91*timing2O
; Speed grade: -2, Temperature grade: E, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 


End Record