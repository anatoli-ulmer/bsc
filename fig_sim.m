clear all;
g=gpuDevice();
reset(g);
addpath('recon','simulation');
%% settings
fname='.\Tex\Images\fig_sim.pdf';

N=4*1024;
beta=1e-3;
delta=1e-3;
radius=200;
dx=1/2;
dz=1/4;
wavelength=1;

%% run
objects{1}=scatterObjects.sphere();
objects{1}.radius=radius;
objects{1}.beta=beta;
objects{1}.delta=delta;
run=singlerun2(N,dx,dz,wavelength,objects);

%% values
minangle=1;
maxangle=20;
angles=run.scatter_scale;
x=angles(end/2+1:end,end/2+1);
err=structfun(@(x)median(abs(x(angles>minangle&angles<maxangle))),run.error_rel,'UniformOutput',false);
disp(err);
names=fieldnames(run.scatter);



%% figure exitwave
f=figure('visible','off');
im=compleximagesc(run.exitwave.multislice(1+1/4*end:3/4*end,1+1/4*end:3/4*end));
axis square
ax=gca;
ax.XTick=[];
ax.YTick=[];
save_image();

%% figure scatter
f=figure('visible','off');
im=imagesc(log10(abs(run.scatter.multislice(1+3/8*end:5/8*end,1+3/8*end:5/8*end))));
colormap parula
axis square
ax=gca;
angles=run.scatter_scale(1+3/8*end:5/8*end,1+3/8*end:5/8*end);
axlabel=(angles(1:end,end/2+1));
ual=unique(round(axlabel));
leftpos=cell2mat(arrayfun(@(x)find(axlabel(1:end/2)>=x,1,'last'),ual,'UniformOutput',false));
pos=[flipud(leftpos);length(axlabel)-leftpos(2:end)];
lab=[flipud(ual);ual(2:end)];
ax.XAxis.TickValues=pos;
ax.XAxis.TickLabels=sprintf('%g�\n',lab);
ax.YAxis.TickValues=pos;
ax.YAxis.TickLabels=sprintf('%g�\n',lab);
ax.XAxis.Label.FontSize=12;
ax.YAxis.Label.FontSize=12;

save_image();