%% Clean up
clear;
close all;

%% Test Initialisation
% load('1080p_BaseTest.mat')
% load('720p_BaseTest.mat')
% load('768p_BaseTest.mat')
% load('768_Lu_BaseTest.mat')
% load('600_Elhossini_BaseTest.mat')
% load('512_Chen_BaseTest.mat')
% load('480p_BaseTest.mat')
% load('333_Zhou_BaseTest.mat')
load('240p_BaseTest.mat')

Y = double(imresize(rgb2gray(imread('brick_wall.jpg')),...
    [bt.height, bt.width]));

%%
% Apply the Sobel operators to the greyscale image to obtain the binary
% edge image and gradient orientation.
SobelThreshold = 30;
[edge, Gdir] = Sobel(Y, SobelThreshold);

%
Gdir = round(Gdir/bt.deltaTheta);

%%
% Lu uses strange limits in the reported work maxTheta is ~90. We have to
% modify our edge image to ignore theta values over ~90.
if strcmp(bt.name, '768_Lu')
    edge = ~(Gdir > bt.maxTheta).*edge;
    % Then set those values to zero
    Gdir = (Gdir <= bt.maxTheta).*Gdir;
end
    
% Set input image
bt.inputImage = double(bitconcat(fi(edge, 0, 1, 0), fi(floor(Gdir), 0, ceil(log2(bt.nTheta)), 0)));

if strcmp(bdroot, 'hybrid_lht_accumulator')
    % Squash some bugs and override the model (still messy)
    if ceil(log2((bt.maxRho*2))) <= 9
        set_param([bdroot, '/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
            '9_bits');
    else
        set_param([bdroot, '/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM'], 'OverrideUsingVariant',...
            'other_bits');

        set_param([bdroot, '/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
            'd', int2str(bt.nRho));

        set_param([bdroot, '/Hybrid LHT/Hybrid LHT Accumulator/Accumulator with Switches/Accumulator/Block RAM/Simple Dual Port RAM Generator'],...
            'b', int2str(ceil(log2(bt.nRho))));
    end
end