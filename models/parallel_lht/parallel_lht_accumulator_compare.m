%% Verify simulation using software model

% Get hough parameter space
Hparam = zeros(bt.height, bt.width, bt.nTheta);
HPS = zeros(bt.nRho, bt.nTheta);

% Get Quantised Trig
cosQ = double(fi(cos(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));
sinQ = double(fi(sin(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));

for y = 1:bt.height
    for x = 1:bt.width
        if (bt.inputImage(y, x))
            yTemp = y - bt.height/2 -1;
            xTemp = x - bt.width/2 -1;
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
