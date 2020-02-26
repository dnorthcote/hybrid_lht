%% Clean up workspace before running
clc;
clear; 
close all;
imtool close all;

hdlset_param(bdroot, 'GenerateValidationModel', 'on');

%% Test Initialisation
load('1080p_BaseTest.mat')

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