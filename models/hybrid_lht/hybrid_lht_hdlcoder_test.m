%% Use a clean workspace
clear;
close all;

%% Setup the names of tests we are going to complete
name = {'1080p', '720p', '768p', '768_Lu', '600_Elhossini', '480p', '512_Chen', '333_Zhou', '240p'};
status = ones(1, length(name)); % status vector all set to one which indicates fail.

%% Load a test image
I = imread('brick_wall.jpg');

%% Open the model
open_system('hybrid_lht');

%% Turn Validation Model on
hdlset_param('hybrid_lht', 'GenerateValidationModel', 'on');

%% Setup toolpath to HDL tools (VIVADO)
hdlsetuptoolpath('ToolName','Xilinx Vivado','ToolPath','C:\Xilinx\Vivado\2019.1\bin')

%% Iterate through each test
for name_idx = 1:length(name)
    
    load([name{name_idx}, '_BaseTest.mat']);

    % Image Initialisation
    Y = double(imresize(rgb2gray(I{img_idx}), [bt.height, bt.width]));

    % Apply the Sobel operators to the greyscale image to obtain the binary
    % edge image and gradient orientation.
    SobelThreshold = 30;
    [edge, Gdir] = Sobel(Y, SobelThreshold);

    %
    Gdir = round(Gdir/bt.deltaTheta);

    %
    % Lu uses strange limits in the reported work maxTheta is ~90. We have to
    % modify our edge image to ignore theta values over ~90.
    if strcmp(bt.name, '768_Lu')
        edge = ~(Gdir > bt.maxTheta).*edge;
        % Then set those values to zero
        Gdir = (Gdir <= bt.maxTheta).*Gdir;
    end

    % Set input image
    bt.inputImage = (bitconcat(fi(edge, 0, 1, 0), fi(Gdir, 0, ceil(log2(bt.nTheta)), 0))); 
    
    % Squash some bugs and override the model (still messy)
    set_param([bdroot, '/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
        'd', int2str(bt.nRho));
    
    % Update simulink model
    set_param('hybrid_lht', 'SimulationCommand', 'update');
    
    % Crank out some HDL Coder commands
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

    %% Run the workflow
    hdlcoder.runWorkflow('hybrid_lht/Hybrid LHT', hWC);

end