%% demo 1
%% Code by Liu He
%    aresmiki@163.com
%    XHU
%%
clc
clear all
close all
K=30;
Fs=10000;
N=10000;
t=(0:1:N-1)/Fs;
%% load mix-signal, pure-signal
load('Simdata.mat');%odata
load('Simpure.mat');%x
%% 快速卷积稀疏字典学习
% L. He, C. Yi, Q. Zhou, J.-H. Lin, Fast Convolutional Sparse Dictionary Learning 
% Based on LocOMP and Its Application to Bearing Fault Detection, 
% IEEE Trans. Instrum. Meas. 71 (2022) 1–12. https://doi.org/10.1109/TIM.2022.3193962.
Lq=20;
[dic1,xcofe1,rec1]=Fast_CSDL(odata,Lq,K,100); %LoCOMP
figure
plot(t,x,'LineWidth',1)
hold on
plot(t,rec1,'-.','LineWidth',1)
xlabel('Time [s]','fontsize',12)
ylabel('Amplitude','fontsize',12)
set(gca,'linewidth',1);
set(gca,'FontSize',12);
set(gca,'Box','on');
set(gcf,'position',[200,300,300,120]);
ylim([-1,2])
set(gca,'Ytick',[-1,0,1,2]);
l1=legend('Simulation fault signal','Reconstructed signal')
set(l1,'Fontname', 'Times New Roman','FontSize',12)
set(l1,'Box','off');

figure
plot(t,x,'LineWidth',1)
hold on
plot(t,rec1,'-.','LineWidth',1)
xlabel('Time [s]','fontsize',12)
ylabel('Amplitude','fontsize',12)
set(gca,'linewidth',1);
set(gca,'FontSize',12);
set(gca,'Box','on');
set(gcf,'position',[200,300,400,150]);
xlim([0.2,0.206])
ylim([-1,2])
set(gca,'Ytick',[-1,0,1,2]);
l1=legend('Simulation fault signal','Reconstructed signal')
set(l1,'Fontname', 'Times New Roman','FontSize',12)
set(l1,'Box','off');
%% 完全局部卷积稀疏字典学习
% L. He, X. Li, C. Yi, Q. Zhou, H. Dong, P. Liu, Complete Local Convolutional 
% Sparse Dictionary Learning for the Detection of Rotating Machinery Transient 
% Faults, IEEE Sensors J. 25 (2025) 28618–28631. https://doi.org/10.1109/JSEN.2025.3574649.
[dic1,xcofe1,rec1]=CL_CSDL(odata,Lq,K,100); %CL_CSDL
figure
plot(t,x,'LineWidth',1)
hold on
plot(t,rec1,'-.','LineWidth',1)
xlabel('Time [s]','fontsize',12)
ylabel('Amplitude','fontsize',12)
set(gca,'linewidth',1);
set(gca,'FontSize',12);
set(gca,'Box','on');
set(gcf,'position',[200,300,300,120]);
ylim([-1,2])
set(gca,'Ytick',[-1,0,1,2]);
l1=legend('Simulation fault signal','Reconstructed signal')
set(l1,'Fontname', 'Times New Roman','FontSize',12)
set(l1,'Box','off');

figure
plot(t,x,'LineWidth',1)
hold on
plot(t,rec1,'-.','LineWidth',1)
xlabel('Time [s]','fontsize',12)
ylabel('Amplitude','fontsize',12)
set(gca,'linewidth',1);
set(gca,'FontSize',12);
set(gca,'Box','on');
set(gcf,'position',[200,300,400,150]);
xlim([0.2,0.206])
ylim([-1,2])
set(gca,'Ytick',[-1,0,1,2]);
l1=legend('Simulation fault signal','Reconstructed signal')
set(l1,'Fontname', 'Times New Roman','FontSize',12)
set(l1,'Box','off');
%% 计算速度统计  
ct1=tic
for i=1:10
    [dic1,xcofe1,rec1]=Fast_CSDL(odata,Lq,K,100); %LoCOMP
end
ct2=toc(ct1)
(ct2)/10

ct3=tic
for i=1:10
    [dic1,xcofe1,rec1]=CL_CSDL(odata,Lq,K,100); %CL_CSDL
end
ct4=toc(ct3)
(ct4)/10