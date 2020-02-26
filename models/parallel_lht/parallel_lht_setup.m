%% Clean up workspace before running
hdlset_param(bdroot, 'GenerateValidationModel', 'on');

%% Test Initialisation
load('240p_BaseTest.mat')

Y = double(imresize(rgb2gray(imread('brick_wall.jpg')),...
    [bt.height, bt.width]));

bt.theta = 0:1:179; % Do not change (no support provided)
[~, bt.nTheta] = size(bt.theta);
bt.minTheta = bt.theta(1);
bt.maxTheta = bt.theta(end);

%%
% Apply the Sobel operators to the greyscale image to obtain the binary
% edge image and gradient orientation.
SobelThreshold = 30;
[edge, Gdir] = Sobel(Y, SobelThreshold);

%%
% Set input image
bt.inputImage = uint8(edge);

% Squash some bugs and override the model (still messy)
if ceil(log2((bt.maxRho*2))) <= 9
    set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
        '9_bits');
else
    set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
        'other_bits');
    
    set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
        'd', int2str(bt.nRho));

    set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
        'b', int2str(ceil(log2(bt.nRho))));
end