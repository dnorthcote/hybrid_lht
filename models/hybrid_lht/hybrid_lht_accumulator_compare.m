%% Verify simulation using software model

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

comp = zeros(bt.height* bt.width, bt.nTheta/L);
%edges = double(bitsliceget(bt.inputImage, ceil(log2(bt.nTheta*2)), ceil(log2(bt.nTheta*2))));
%orientations = double(bitsliceget(bt.inputImage, ceil(log2(bt.nTheta*2))-1, 1));

for y = 1:bt.height
    for x = 1:bt.width
        if (edge(y, x))
            
            idx = Gdir(y, x);
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
max(max(abs(hpsDiff)))

if bt.nTheta > 1
    plot3DHPS(HPS);
    plot3DHPS(hpsOutSim);
else
    figure
    stem(HPS);
    figure
    stem(hpsOutSim);
end

format long
fprintf(2, 'Difference between software model and simulation: %f\n', max(max(abs(hpsDiff))));
