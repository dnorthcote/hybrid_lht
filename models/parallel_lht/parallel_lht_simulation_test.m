%% Use a clean workspace
clear;
close all;

%% Setup the names of tests we are going to complete
name = {'1080p', '1024p', '720p', '768p', '480p', '512_Chen', '333_Zhou' '240p'};
status = ones(1, length(name)); % status vector all set to one which indicates fail.

%% Load a test image
I = {imread('brick_wall.jpg'), imread('circle_steps_twist.jpg')};
img_status = ones(1, length(I)); % status vector all set to one which indicates fail.

%% Open the model
open_system('parallel_lht');

%% Iterate through each test
for name_idx = 1:length(name)
    for img_idx = 1:length(I)
        load([name{name_idx}, '_BaseTest.mat']);

        % Image Initialisation
        Y = double(imresize(rgb2gray(I{img_idx}), [bt.height, bt.width]));

        % Apply the Sobel operators to the greyscale image to obtain the binary
        % edge image and gradient orientation.
        SobelThreshold = 30;
        [edge, ~] = Sobel(Y, SobelThreshold);

        % Set input image
        bt.inputImage = uint8(edge);

        % Run the simulation
        RunParallelLHT(bt);

        % Get hough parameter space
        Hparam = zeros(bt.height, bt.width, bt.nTheta);
        HPS = zeros(bt.nRho, bt.nTheta);

        % Get Quantised Trig
        cosQ = double(fi(cos(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));
        sinQ = double(fi(sin(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));

        for y = 1:bt.height
            for x = 1:bt.width
                if (bt.inputImage(y, x))
                    yTemp = y - floor(bt.height/2) -1;
                    xTemp = x - floor(bt.width/2) -1;
                    % This calculation will need to be changed when using the Basic
                    % models that do not round/truncate
                    rhoTemp = round(round(xTemp*cosQ) + round(yTemp*sinQ) + bt.maxRho);
                    Hparam(y, x, :) = rhoTemp;
                    for i = 1: bt.nTheta
                        HPS(rhoTemp(i) + 1, i) = HPS(rhoTemp(i) + 1, i) + 1;
                    end
                end
            end
        end

        % Get simulation hough parameter space
        hpsOutSim = double(reshape(out.simout, [bt.nRho bt.nTheta]));
        hpsDiff = HPS-hpsOutSim;
        max(max(abs(hpsDiff)));

        % Set status
        img_status(img_idx) = ~(max(max(abs(hpsDiff))) == 0);
    end
    
    status(name_idx) = max(img_status);
end

% Write results to file
if isfile('parallel_lht_simulation_test_results.txt')
    delete 'parallel_lht_simulation_test_results.txt';
end

fileid = fopen('parallel_lht_simulation_test_results.txt','w');
time = datestr(clock,'YYYY/mm/dd HH:MM:SS:FFF');
fprintf(fileid,'%23s\n',time);

if ~(max(status))
    fprintf(fileid, 'Test Successful! All tested resolutions passed using the candidate input images provided.\n');
else
    fprintf(fileid, 'Test Failed! One or more of the tested resolutions below failed using the candidate input images provided.\n');
    for name_idx = 1:length(name)
        if status(name_idx)
            fprintf(fileid, ['Failed!... ', name{name_idx}, '\n']);
        end
    end
end

fclose(fileid);