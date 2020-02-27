%% Clean up
clear;
close all;

%% Test Initialisation
load('600_Elhossini_BaseTest.mat')

Y = double(imresize(rgb2gray(imread('brick_wall.jpg')),...
    [bt.height, bt.width]));

%%
% Apply the Sobel operators to the greyscale image to obtain the binary
% edge image and gradient orientation.
SobelThreshold = 30;
[edge, Gdir] = Sobel(Y, SobelThreshold);

%%
% Set input image
bt.inputImage = bitconcat(fi(edge, 0, 1, 0), fi(floor(Gdir), 0, 8, 0));

% Squash some bugs and override the model (still messy)
% if ceil(log2((bt.maxRho*2))) <= 9
%     set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
%         '9_bits');
% else
%     set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
%         'other_bits');
%     
%     set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
%         'd', int2str(bt.nRho));
% 
%     set_param([bdroot, '/Parallel LHT/Parallel LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
%         'b', int2str(ceil(log2(bt.nRho))));
% end