function [Gaussian_1D_2_Diff_Modified]=MLOG(sigma,N)
%%
%	1D Modified Laplacian of Gaussian (MLOG).
%   [Gaussian_1D_2_Diff_Modified]=MLOG(sigma,N) returns the 1-D Modified
%   Laplacian of Gaussian Mask.
%   This Filter introduced in a paper with the title of...
%   "Automatic arrival time detection for earthquakes based on Modified...
%   Laplacian of Gaussian filter", in Computers and Geosciences journal.
%   This filter is a denoising filter which can deal with several types of
%   signals.
%   DOI: https://doi.org/10.1016/j.cageo.2018.01.013
%
%   INPUT VARIABLES
%   N      : Filter Order	
%   sigma  : standard deviation 
%
%	OUTPUT VARIABLES
%	Gaussian_1D_2_Diff_Modified :  The Cofficients of MLOG (Mask)
%
%   COMMENTS:
%   If you need to reach any equation in the paper rather than the final equation, 
%   you can change the name of the output in this function
%   DOI : 
%
%   EXAMPLE:
%   N = 10; sigma = 2.5;
%   [Gaussian_1D_2_Diff_Modified]=MLOG(sigma,N);
%
%   Code written by Omar M. Saad
%   Last update: January 25, 2018
%   Copyright 2018 Omar M. Saad
%   Contact : omar.saad@ejust.edu.eg


%% Check if the Filter order is odd or even.
Check_Even_Odd = mod(N,2);
if Check_Even_Odd ==1
len   = (N-1)/2;    
n=-len:len;
else
len   = N/2;    
n=[-len:-1 1:len];
end

% 1D Gaussian filter, where sigma represents the standard deviation of the Gaussian filter and n is the Gaussian index.
% For example : if you need to construct a filter with N cofficients,
% n will be written as n = -len:1:len, where len = N/2.
% Equation (1)
Gaussian_1D = (1/ (sqrt (2*pi) * sigma) ) * (exp ((-n.^2)/ (2*sigma^2)) );


% The first derivative of the Gaussian filter is obtained.
% Equation (2)
% Gaussian_1D_1_Diff = (-n/ (sqrt (2*pi) * sigma^3) ) .* (exp ((-n.^2)/ (2*sigma^2)) );
Gaussian_1D_1_Diff = (-n/sigma^2) .* Gaussian_1D;


% The LoG filter is the second derivative of the Gaussian filter,
% The second derivative of Gaussian filter is obtained.
% Equation (3)
% Gaussian_1D_2_Diff = (1/ (sqrt (2*pi) * sigma^2) ) .* ( ((n.^2)/ sigma^2) -1 ) .* (exp ((-n.^2)/ (2*sigma^2)) );
Gaussian_1D_2_Diff = Gaussian_1D_1_Diff .* ( (((n.^2)/ sigma^2) -1) /sigma ) ./ ((-n/sigma^2));

% The scaling factor in front of the exponential is primarily concerned with ensuring that the area underneath the Gaussian is one.
% Therefore, the normalized LoG filter can be reached by dividing Equation (3) by the exponential sum
% Equation (4)
% Gaussian_1D_2_Diff_Normalized = ((1/ (sqrt (2*pi) * sigma^2) ) .* ( ((n.^2)/ sigma^2) -1 ) .* (exp ((-n.^2)/ (2*sigma^2)) ) )...
%                                / (sum ((exp ((-n.^2)/ (2*sigma^2)) )) );
Gaussian_1D_2_Diff_Normalized = Gaussian_1D_2_Diff / (sum ((exp ((-n.^2)/ (2*sigma^2)) )) );

% The sum of taps should be zero
% Equation (5)
Gaussian_1D_2_Diff_Modified = Gaussian_1D_2_Diff_Normalized - ((1/N) * sum(Gaussian_1D_2_Diff_Normalized));

% Extra Equation (only, if you need to make it zero mean)
% Gaussian_1D_2_Diff_Modified = (Gaussian_1D_2_Diff_Modified - mean(Gaussian_1D_2_Diff_Modified) ) /std(Gaussian_1D_2_Diff_Modified)
%% End 





