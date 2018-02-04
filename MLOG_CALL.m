clc
clear 
close all

%load Input example
load x_Example


% Sigma and Filter Order of MLOG
% Tune sigma, and N according to the application you want to use.
% For smoothing the background noise in DOI: 
% The optimum parameters are : 
sigma = 2.5;
N = 10;


% Call MLOG and stores the cofficients in Gaussian_1D_2_Diff_Modified
% MLOG
% [Gaussian_1D_2_Diff_Modified]=MLOG(sigma,N);
% For More Scaling dividing by sigma.
  [Gaussian_1D_2_Diff_Modified]=MLOG(sigma,N) /sigma;


% Filtering The Input (Denoising the Input Signal)
Output = filter (Gaussian_1D_2_Diff_Modified,1,x);

% Output Squaring 
Output = Output.^2;


% For more smoothing, average movabale window is obatined for m samples
% with k stride (moving by k samples)
% Adjustce m, and k according to the application you want to use.
Output_More_Smoothing = zeros(1,size(x,2));
m = 8;
k = 1;
count = 1;
 for j=1:k:(length(Output))-max([m k])
 Output_More_Smoothing(count)=(mean(Output(j:j+m-1)));
 count = count +1;
 end
 
 
% Plotting 
% Plotting the Cofficients of MLOG.
figure(1)
plot( (1:N), Gaussian_1D_2_Diff_Modified, 'LineWidth',3)
xlabel('Index (n)','FontSize',14,'FontWeight','bold')
ylabel('MLOG Mask Values','FontSize',14,'FontWeight','bold')
title('MLOG MASK','FontSize',14,'FontWeight','bold')
set(gca,'fontsize',12,'FontWeight','bold')
% Plotting Input, Output of MLOG, and Smoothed Output Signal.
figure(2)
subplot(3,1,1),plot(1:length(x),x)
xlabel('Sample Index','FontSize',14,'FontWeight','bold')
ylabel('Count','FontSize',14,'FontWeight','bold')
title('Input Seismic Event','FontSize',14,'FontWeight','bold')
set(gca,'fontsize',12,'FontWeight','bold')
subplot(3,1,2),plot(1:length(Output), Output)
xlabel('Sample Index','FontSize',14,'FontWeight','bold')
ylabel('Count^2','FontSize',14,'FontWeight','bold')
title('Output Signal of MLOG Filter','FontSize',14,'FontWeight','bold')
set(gca,'fontsize',12,'FontWeight','bold')
subplot(3,1,3),plot(1:length(Output_More_Smoothing), Output_More_Smoothing)
xlabel('Sample Index','FontSize',14,'FontWeight','bold')
ylabel('Count^2','FontSize',14,'FontWeight','bold')
title('Smoothed Output Signal','FontSize',14,'FontWeight','bold')
set(gca,'fontsize',12,'FontWeight','bold')
