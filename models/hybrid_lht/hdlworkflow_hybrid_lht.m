%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.7 (R2019b) at 17:52:43 on 28/02/2020
% This script was generated using the following parameter values:
%     Filename  : 'C:\hybrid_lht\models\hybrid_lht\hdlworkflow_hybrid_lht.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'hybrid_lht/Hybrid LHT'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','hybrid_lht/Hybrid LHT');
%--------------------------------------------------------------------------

%% Load the Model
load_system('hybrid_lht');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('hybrid_lht/Hybrid LHT');

%% Model HDL Parameters
%% Set Model 'hybrid_lht' HDL parameters
hdlset_param('hybrid_lht', 'BalanceDelays', 'off');
hdlset_param('hybrid_lht', 'GenerateHDLTestBench', 'off');
hdlset_param('hybrid_lht', 'GenerateValidationModel', 'on');
hdlset_param('hybrid_lht', 'HDLSubsystem', 'hybrid_lht/Hybrid LHT');
hdlset_param('hybrid_lht', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('hybrid_lht', 'SynthesisToolChipFamily', 'Zynq UltraScale+');
hdlset_param('hybrid_lht', 'SynthesisToolDeviceName', 'xczu7ev-ffvc1156-2-e');
hdlset_param('hybrid_lht', 'SynthesisToolPackageName', '');
hdlset_param('hybrid_lht', 'SynthesisToolSpeedValue', '');
hdlset_param('hybrid_lht', 'TargetDirectory', 'hdl_prj\hdlsrc');
hdlset_param('hybrid_lht', 'TargetFrequency', 150);

% Set SubSystem HDL parameters
hdlset_param('hybrid_lht/Hybrid LHT/Hybrid LHT Kernel/Gradient Kernel System/Hough Kernel/Look Ahead Hough', 'DistributedPipelining', 'on');


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
hdlcoder.runWorkflow('hybrid_lht/Hybrid LHT', hWC);
