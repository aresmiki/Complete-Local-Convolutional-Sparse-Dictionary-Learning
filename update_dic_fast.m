function d=update_dic_fast(y,x,dic)
% x  是系数， y 是需要近似的函数 ，dic是字典 np 是字典原子大小
np=length(dic);
%% 根据字典长度长度和稀疏稀疏系数，求解原子的作用范围
%% 第一种方法
% b=find(x);
% b1=b+np-1;
% sup=[];
% for i=1:length(b)
%     sup=union(sup,[b(i):b1(i)]);
% end
%% 第2种方法
x1=x;  %稀疏表示x
b=find(x1);

for i=1:np-1
   x1(b+i)=1;
end
sup=find(x1);
%% 提取作用范围内的y，原子更新时只和这个范围内的y相关。
y1=y(sup);
x1=x(sup);
%% 用 x构造卷积字典
%%
XDic=get_Circshift(repmat(x1(:),1,np),[0:1:np-1]); 
y1=y1(:);
%  XDic*dic 是卷积结果. %这部分可直接用卷积代替矩阵乘法
%% argmin ||y-XDic*dic||_F 
% %% 用梯度下降求解
d=cgls(XDic,y1,0,1e-3,20,[],dic); %共轭梯度下降
% d=inv(XDic'*XDic)*XDic'*y1(:);
end




