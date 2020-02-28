%% Use a clean workspace
clear;
close all;

%% Setup the names of tests we are going to complete
name = {'1080p', '720p', '768p', '768_Lu', '600_Elhossini', '480p', '512_Chen', '333_Zhou', '240p'};
status = ones(1, length(name)); % status vector all set to one which indicates fail.

%% Load a test image
I = {imread('brick_wall.jpg'), imread('circle_steps_twist.jpg')};
img_status = ones(1, length(I)); % status vector all set to one which indicates fail.

%% Open the model
open_system('hybrid_lht');

%% Iterate through each test
for name_idx = 1:length(name)
    for img_idx = 1:length(I)
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

        % Run the simulation
        RunHybridLHT(bt);

        % Get hough parameter space
        Hparam = zeros(bt.height, bt.width, bt.nTheta);
        HPS = zeros(bt.nRho, bt.nTheta);
        
        L = floor(36/ceil(log2(bt.nRho)));
        lambda = floor(bt.nTheta/(2*L));

        % Get Quantised Trig
        cosQ = double(fi(cos(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));
        sinQ = double(fi(sin(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));
        
        % If the number of theta is odd, then we need to adjust the operational
        % range for the theta index. Also check if lambda is zero so we can ignore
        % this issue.
        subflag = ~mod(bt.nTheta/L, 2);

        edges = double(bitsliceget(bt.inputImage, ceil(log2(bt.nTheta*2)), ceil(log2(bt.nTheta*2))));
        orientations = double(bitsliceget(bt.inputImage, ceil(log2(bt.nTheta*2))-1, 1));

        for y = 1:bt.height
            for x = 1:bt.width
                if (edges(y, x))

                    idx = orientations(y, x);
                    yTemp = y - bt.height/2 -1;
                    xTemp = x - bt.width/2 -1;

                    for i = idx - lambda : 1 : idx + lambda - subflag
                        % Get a temporary index for manipulation
                        i_temp = i;

                        % Check the theta index for limits
                        if i_temp < 0
                            i_temp = i_temp + bt.nTheta;
                        end
                        if i_temp >= bt.nTheta
                            i_temp = i_temp - bt.nTheta;
                        end

                        % Obtain the value of theta relative to our temporary index
                        theta_i = i_temp;

                        % This calculation will need to be changed when using the Basic
                        % models that do not round/truncate
                        rhoTemp = (round(xTemp*cosQ(theta_i+1)) + ...
                            round(yTemp*sinQ(theta_i+1)) + bt.maxRho);

                        HPS(rhoTemp+1, theta_i+1) = HPS(rhoTemp+1, theta_i+1) + 1;
                    end
                end
            end
        end

        % Get simulation hough parameter space
        hpsOutSim = double(reshape(simout, [bt.nRho bt.nTheta]));
        hpsDiff = HPS-hpsOutSim;
        max(max(abs(hpsDiff)));

        % Set status
        img_status(img_idx) = ~(max(max(abs(hpsDiff))) == 0);
    end
    
    status(name_idx) = max(img_status);
end

% Write results to file
if isfile('hybrid_lht_simulation_test_results.txt')
    delete 'hybrid_lht_simulation_test_results.txt';
end

fileid = fopen('hybrid_lht_simulation_test_results.txt','w');
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