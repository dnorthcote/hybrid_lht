%% Verify simulation using software model

% Set Operational Range
L = floor(36/ceil(log2(bt.nRho)));
lambda = floor(bt.nTheta/(2*L));

% Set upper and lower bounds for idx
upper = bt.nTheta/L : bt.nTheta/L : bt.maxTheta + 1;
lower = 0 : bt.nTheta/L : bt.maxTheta;

% Set bitshift idx
P = (0:1:L-1)*36/L;

% Get hough parameter space
Hparam = zeros(bt.height, bt.width, bt.nTheta/L);
Hidx = zeros(bt.height, bt.width, bt.nTheta/L);
HPS = zeros(bt.nRho, bt.nTheta);

% Get Quantised Trig
cosQ = double(fi(cos(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));
sinQ = double(fi(sin(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));

% If the number of theta is odd, then we need to adjust the operational
% range for the theta index. Also check if lambda is zero so we can ignore
% this issue.
subflag = ~mod(bt.nTheta/L, 2);

for y = 1:bt.height
    for x = 1:bt.width
        idx = floor(Gdir(y, x));
        yTemp = y - bt.height/2 -1;
        xTemp = x - bt.width/2 -1;
        
        j = 0;

        for i = idx - lambda : 1 : idx + lambda - subflag

            % Get a temporary index for manipulation
            i_temp = i;
            
            j = j + 1;

            % Check the theta index for limits
            if i_temp < 0
                i_temp = i_temp + bt.nTheta;
            end
            if i_temp > bt.maxTheta
                i_temp = i_temp - bt.nTheta;
            end

            % Obtain the value of theta relative to our temporary index
            theta_i = i_temp;

            % This calculation will need to be changed when using the Basic
            % models that do not round/truncate
            rhoTemp = round(round(xTemp*cosQ(theta_i+1)) + ...
                round(yTemp*sinQ(theta_i+1)) + bt.maxRho);

            Hparam(y, x, j) = rhoTemp;
            
            % Populate Hidx
            for a = 1:L
                if theta_i < upper(a) && theta_i >= lower(a)
                    Hidx(y, x, j) = P(a);
                end
            end
                
        end
    end
end

% Compare software model against simulation
simrho = reshape(out.datarho, [bt.width, bt.height, bt.nTheta/L]);
simrho = permute(simrho, [2, 1, 3]);

simidx = reshape(out.dataidx, [bt.width, bt.height, bt.nTheta/L]);
simidx = permute(simidx, [2, 1, 3]);

Hdiff = abs(Hparam - simrho);
Hdiffidx = abs(Hidx - simidx);
format long
fprintf(2, ['Rho Difference between software model and simulation: %.40f\n' ...
    'Idx Difference between software model and simulation: %.40f\n'], ...
    max(max(max(Hdiff))), max(max(max(Hdiffidx))));