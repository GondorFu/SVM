
clear;
clc;
close all;

x = [randn(30,1); 5+randn(30,1)];
[f,xi] = ksdensity(x); 
plot(xi,f); 

% A histogram represents the probability distribution by 
% establishing bins and placing each data value in the appropriate bin.

SixMPG = [13;15;23;29;32;34];
figure
hist(SixMPG)

% Alternatively, the kernel distribution builds the pdf by creating an
% individual probability density curve for each data value, 
% then summing the smooth curves. 
% This approach creates one smooth, continuous probability density function 
% for the data set.

figure
pdSix = fitdist(SixMPG,'Kernel','Width',4);
x = 0:.1:45;
ySix = pdf(pdSix,x);
plot(x,ySix,'k-','LineWidth',2)

% % Plot each individual pdf and scale its appearance on the plot
% hold on
% for i=1:6
%     pd = makedist('Normal','mu',SixMPG(i),'sigma',4);
%     y = pdf(pd,x);
%     y = y/6;
%     plot(x,y,'b:')
% end
% hold off

% You can choose one of several options for the kernel smoothing function. 
% This plot shows the shapes of the available smoothing functions.
% Set plot specifications
hname = {'normal' 'epanechnikov' 'box' 'triangle'};
colors = {'r' 'b' 'g' 'm'};
lines = {'-','-.','--',':'};

% Generate a sample of each kernel smoothing function and plot
data = [0];
figure
for j=1:4
    pd = fitdist(data,'kernel','Kernel',hname{j});
    x = -3:.1:3;
    y = pdf(pd,x);
    plot(x,y,'Color',colors{j},'LineStyle',lines{j})
    hold on;
end
legend(hname{:})
hold off

% To understand the effect of different kernel smoothing functions 
% on the shape of the resulting pdf estimate, 
% compare plots of the mileage data (MPG) from carbig.mat 
% using each available kernel function.

load carbig
% Set plot specifications
hname = {'normal' 'epanechnikov' 'box' 'triangle'};
colors = {'r' 'b' 'g' 'm'};
lines = {'-','-.','--',':'};

% Generate kernel distribution objects and plot
figure
for j=1:4
    pd = fitdist(MPG,'kernel','Kernel',hname{j});
    x = -10:1:60;
    y = pdf(pd,x);
    plot(x,y,'Color',colors{j},'LineStyle',lines{j})
    hold on
end
legend(hname{:})
hold off

% The choice of bandwidth value controls the smoothness of 
% the resulting probability density curve. 
% This plot shows the density estimate for the same MPG data, 
% using a normal kernel smoothing function with three different bandwidths.
% Create kernel distribution objects

pd1 = fitdist(MPG,'kernel');
pd2 = fitdist(MPG,'kernel','Width',1);
pd3 = fitdist(MPG,'kernel','Width',5);

% Compute each pdf
x = -10:1:60;
y1 = pdf(pd1,x);
y2 = pdf(pd2,x);
y3 = pdf(pd3,x);

% Plot each pdf
plot(x,y1,'Color','r','LineStyle','-')
hold on
plot(x,y2,'Color','k','LineStyle',':')
plot(x,y3,'Color','b','LineStyle','--')
legend({'BandWidth = Default','BandWidth = 1','BandWidth = 5'})
hold off























