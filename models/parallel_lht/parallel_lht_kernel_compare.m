%% Verify simulation using software model

% Get hough parameters
Hparam = zeros(bt.height, bt.width, length(bt.theta));

% Get Quantised Trig
cosQ = double(fi(cos(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));
sinQ = double(fi(sin(deg2rad(bt.theta)), 1, bt.paramWord, bt.paramWord-2));

for y = 1:bt.height
    for x = 1:bt.width
        yTemp = y - bt.height/2 -1;
        xTemp = x - bt.width/2 -1;
        Hparam(y, x, :) = round(round(xTemp*cosQ) + round(yTemp*sinQ) + bt.maxRho);
    end
end

% Compare software model against simulation
Hsim = reshape(out.dataout, [bt.width, bt.height, bt.nTheta]);
Hsim = permute(Hsim, [2, 1, 3]);
Hdiff = abs(Hparam - Hsim);
format long
fprintf(2, 'Difference between software model and simulation: %.40f\n', max(max(max(Hdiff))));