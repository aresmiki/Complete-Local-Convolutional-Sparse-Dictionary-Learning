function [dic,xcofe,rec]=CL_CSDL(y,np,kp,iter,disp)
if (nargin <= 3)   %
    iter=100;
end
if (nargin <= 4)   %
    disp=2;
end
%% 快速卷积稀疏编码
% dic=randn(np,1);    %随机生成字典dic
% dic=dic./norm(dic); %归一化
% N=length(y(:));     %计算信号y长度
% erro(1)=0;          %误差向量 erro 的第一个元素设为 0
% 
dic=[  -0.9463
    0.2116
    0.5729
    0.9159
    1.7753
   -1.3951
    0.6053
   -0.8769
    0.4544
   -0.5584
    0.1260
    0.2551
    0.9061
   -0.2816
   -1.6914
    1.4604
    0.3662
   -0.7537
    0.5399
    1.0146];
dic=dic./norm(dic);
N=length(y(:));
erro(1)=0;

for i=1:iter     
    %% 固定原子，稀疏编码
    xcofe=LoCOMP(y,dic,kp);     %更新稀疏x
    rec=Rec_LoCOMP(dic,xcofe,N);%重构原子
%% 误差计算，终止条件    
    erro(i+1)=norm(y(:)-rec(:),'fro');
    if disp==1
        fprintf('iter = %d\n   erro = %f\n\r',i,erro(i+1));
    end
    if abs(erro(i+1)-erro(i))<1e-4
        break;
    end
    %% 固定稀疏，更新原子
    dic=update_dic_fast(y,xcofe,dic);
    dic=dic./norm(dic);  %dic/||dic||2
 end
end
