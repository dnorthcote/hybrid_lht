%% Use a clean workspace
clear;
close all;

%% Setup the names of tests we are going to complete
name = {'1080p', '720p', '768p', '480p', '512_Chen', '333_Zhou', '240p'};
status = ones(1, length(name)); % status vector all set to one which indicates fail.

%% Load a test image
I = imread('brick_wall.jpg');

%% Open the model
open_system('parallel_lht');

%% Turn Validation Model on
hdlset_param('parallel_lht', 'GenerateValidationModel', 'on');

%% Setup toolpath to HDL tools (VIVADO)
hdlsetuptoolpath('ToolName','Xilinx Vivado','ToolPath','C:\Xilinx\Vivado\2019.1\bin')

%% Iterate through each test
for name_idx = 1:length(name)
    
    % Load the basetest
    load([name{name_idx}, '_BaseTest.mat']);

    % Image Initialisation
    Y = double(imresize(rgb2gray(I), [bt.height, bt.width]));

    % Apply the Sobel operators to the greyscale image to obtain the binary
    % edge image and gradient orientation.
    SobelThreshold = 30;
    [edge, ~] = Sobel(Y, SobelThreshold);

    % Set input image
    bt.inputImage = uint8(edge);

    % Update simulink model
    set_param('parallel_lht', 'SimulationCommand', 'update'); 
    
    % Crank out some HDL Coder commands
    
    % Set Model 'parallel_lht' HDL parameters
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


    % Workflow Configuration Settings
    % Construct the Workflow Configuration Object with default settings
    hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','Generic ASIC/FPGA');

    % Specify the top level project directory
    hWC.ProjectFolder = ['hdl_prj_', name{name_idx}];

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

    % Run the workflow
    hdlcoder.runWorkflow('parallel_lht/Parallel LHT', hWC);
end