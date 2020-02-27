name = {'1080p', '1024p', '720p', '768_Lu', '768p', '600_Elhossini', '480p', '512_Chen', '333_Zhou' '240p'};
width = [1920, 1280, 1280, 1024, 1024, 800, 640, 512, 334, 320];
height = [1080, 1024, 720, 768, 768, 600, 480, 512, 334, 240];
widthpad = [2200, 1688, 1650, 1344, 1344, 1344, 800, 864, 402, 402];
heightpad = [1125, 1066, 750, 806, 806, 806, 525, 625, 525, 324];
activeline = [42, 42, 25, 10, 10, 1, 36, 47, 36, 1];
frontporch = [88, 48, 110, 24, 24, 24, 16, 12, 16, 44];
deltaTheta = [1, 1, 1, 0.8952, 1, 10, 1, 1, 1, 1];
maxTheta = [179, 179, 179, 91.3104-0.8952, 179, 170, 179, 179, 179, 179];

for i = 1:length(name)
    % Create BaseWorkspace Class for testing
    bt = BaseTest;

    % Set model parameters
    bt.name = name{i};
    bt.height = height(i);
    bt.width = width(i);
    bt.deltaRho = 1;
    bt.deltaTheta = deltaTheta(i);
    bt.minTheta = 0;
    bt.maxTheta = maxTheta(i);
    bt.theta = (bt.minTheta : bt.deltaTheta : bt.maxTheta);
    bt.paramWord = 16;
    bt.thetaDataType = 'fixdt(1, 16)';
    bt.maxRho = ceil(sqrt((bt.height/2)^2+(bt.width/2)^2));
    bt.nRho = (bt.maxRho*2)/bt.deltaRho;
    bt.nTheta = (bt.maxTheta+bt.deltaTheta)/bt.deltaTheta;
    bt.fps = 60;
    bt.heightpad = heightpad(i);
    bt.widthpad = widthpad(i);
    bt.frequency = (bt.heightpad)*(bt.widthpad)*bt.fps;
    bt.activeline = activeline(i);
    bt.frontporch = frontporch(i);
    
    save([name{i}, '_BaseTest.mat'], 'bt');
end