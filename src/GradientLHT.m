function [hps] = GradientLHT(edge, Gdir, dTheta, dRho, lambda)
%GradientLHT Applies the Gradient Line Hough Transform to binary images.
%   The Gradient Line Hough Transform (LHT), as defined by O'Gorman & 
%   Clowes [1], is applied to a binary edge image using this function. The
%   discretisation step of theta and rho are set using the respective
%   arguments. The Hough Parameter Space (HPS) is produced by applying the
%   analytical function for lines as described in [2]. The HPS is returned
%   as a double precision array. The lambda argument determines the search
%   area in the HPS around the orientation of the pixel gradient.
%
%   [1]  -  F. O'Gorman and M. B. Clowes, "Finding picture edges through
%           collinearity of greature points," IEEE Transactions on
%           Computers, vol. C-25, no. 4, pp. 449-456, April 1976.
%
%   [2]  -  R. O. Duda, P. E. Hart, "Use of the Hough transformation to 
%           detect lines and curves in pictures", Commun. ACM, vol. 15,
%           no. 1, pp. 11-15, Jan. 1972.

%Check arguments
switch nargin
    case 0
        error('Not enough input arguments.');
    case 1
        error('Not enough input arguments.');
    case 2
        dTheta = 1;
        dRho = 1;
        lambda = 0;
    case 3
        dRho = 1;
        lambda = 0;
    case 4
        lambda = 0;
    case 5
        % Do nothing
    otherwise
        error('Error occurred.');
end

%TODO Insert checks to ensure that dTheta, dRho, and Lambda are good.

%Get the dimensions of the input image.
[height, width] = size(edge);

%Get the maximum Rho
maxRho = ceil(sqrt((height/2)^2+(width/2)^2));

%Get theta and rho
theta = (0:dTheta:180-dTheta);

%   Remove the zero element in the middle as the formula will never give a
%   zero value.
vrho = cat(2,(-maxRho:dRho:-dRho), (dRho:dRho:maxRho));

if isempty(vrho)
    vrho = 1;
end

%Get HPS dimensions
[~, m] = size(theta);
[~, n] = size(vrho);

%Initialise the Accumulator array (A)
A = zeros(n, m);

% If the number of theta is odd, then we need to adjust the operational
% range for the theta index. Also check if lambda is zero so we can ignore
% this issue.
subflag = ~mod(m, 2)*(lambda~=0);

%Get HPS by iterating through the binary edge image and operating on
%feature points.
for y = 1:height
    for x = 1:width
        
        % Iterate over binary edge pixels
        if edge(y,x) > 0
            
            % Adjust Cartesian Positions
            xTemp = x-width/2;
            yTemp = y-height/2;
            
            % Get the index of the gradient orientation in relation to the
            % operational range of theta
            idx = floor(Gdir(y, x)/dTheta)+1;
            %gTheta = dTheta*idx;
                        
            % Iterate across values of theta around gradient theta
            for i = idx-lambda:1:idx+lambda-subflag
                
                % Get a temporary index for manipulation
                i_temp = i;
                
                % Check the theta index for limits
                if i_temp < 1
                    i_temp = i_temp + m;
                end
                if i_temp > m
                    i_temp = i_temp - m;
                end
                
                % Obtain the value of theta relative to our temporary index
                theta_i = theta(i_temp);
                
                % Get Hough Parameters
                rho = round((xTemp*cos(deg2rad(theta_i))+yTemp*...
                    sin(deg2rad(theta_i))+maxRho));
                
                rhotemp = floor(rho/dRho)+1;
                
                % Apply vote to HPS                
                A(rhotemp, (theta_i/dTheta)+1) = A(rhotemp, (theta_i/dTheta)+1) + 1;
                
            end
        end
    end
end

%Assign the accumulator array to the HPS output array
hps = A;

end