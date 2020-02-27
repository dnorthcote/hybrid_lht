%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.7 (R2019b) at 19:10:03 on 27/02/2020
% This script was generated using the following parameter values:
%     Filename  : 'C:\hybrid_lht\models\parallel_lht\hdlworkflow_parallel_lht.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'parallel_lht/Parallel LHT'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','parallel_lht/Parallel LHT');
%--------------------------------------------------------------------------

%% Load the Model
load_system('parallel_lht');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('parallel_lht/Parallel LHT');

%% Model HDL Parameters
%% Set Model 'parallel_lht' HDL parameters
hdlset_param('parallel_lht', 'GenerateHDLTestBench', 'off');
hdlset_param('parallel_lht', 'GenerateValidationModel', 'on');
hdlset_param('parallel_lht', 'HDLSubsystem', 'parallel_lht/Parallel LHT');
hdlset_param('parallel_lht', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('parallel_lht', 'SynthesisToolChipFamily', 'Zynq UltraScale+');
hdlset_param('parallel_lht', 'SynthesisToolDeviceName', 'xczu7ev-ffvc1156-2-e');
hdlset_param('parallel_lht', 'SynthesisToolPackageName', '');
hdlset_param('parallel_lht', 'SynthesisToolSpeedValue', '');
hdlset_param('parallel_lht', 'TargetDirectory', 'hdl_prj\hdlsrc');
hdlset_param('parallel_lht', 'TargetFrequency', 150);

% Set SubSystem HDL parameters
hdlset_param('parallel_lht/Parallel LHT/Parallel LHT Kernel/Hough Kernel/Hough Kernel Symmetric Look Ahead/Hough Kernel Symmetric', 'DistributedPipelining', 'on');

% Set SubSystem HDL parameters
hdlset_param('parallel_lht/Parallel LHT/Parallel LHT Kernel/Hough Kernel/Hough Kernel Symmetric Look Ahead/Look Ahead Hough', 'DistributedPipelining', 'on');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','Generic ASIC/FPGA');

% Specify the top level project directory
hWC.ProjectFolder = 'hdl_prj';

% Set Workflow tasks to run
hWC.RunTaskGenerateRTLCodeAndTestbench = true;
hWC.RunTaskVerifyWithHDLCosimulation = false;
hWC.RunTaskCreateProject = true;
hWC.RunTaskRunSynthesis = true;
hWC.RunTaskRunImplementation = true;
hWC.RunTaskAnnotateModelWithSynthesisResult = true;

% Set properties related to 'RunTaskGenerateRTLCodeAndTestbench' Task
hWC.GenerateRTLCode = true;
hWC.GenerateTestbench = false;
hWC.GenerateValidationModel = true;

% Set properties related to 'RunTaskCreateProject' Task
hWC.Objective = hdlcoder.Objective.None;
hWC.AdditionalProjectCreationTclFiles = '';

% Set properties related to 'RunTaskRunSynthesis' Task
hWC.SkipPreRouteTimingAnalysis = false;

% Set properties related to 'RunTaskRunImplementation' Task
hWC.IgnorePlaceAndRouteErrors = false;

% Set properties related to 'RunTaskAnnotateModelWithSynthesisResult' Task
hWC.CriticalPathSource = 'pre-route';
hWC.CriticalPathNumber =  1;
hWC.ShowAllPaths = false;
hWC.ShowDelayData = false;
hWC.ShowUniquePaths = false;
hWC.ShowEndsOnly = false;

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('parallel_lht/Parallel LHT', hWC);
