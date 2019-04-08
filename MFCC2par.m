function getmfcc= MFCC2par(x,fs)
 %=========================================================
 % 提取MFCC特征参数
 % 无去噪及端点检测
 % Input:音频数据x,采样率fs
 % Output：(N,M)大小的特征参数矩阵  其中N为分帧个数，M为特征维度
 % 特征参数：M=24 倒谱系数12维，一阶差分12维
 %=========================================================
tic
%[x fs]=wavread(sound);
%取单声道信号
[~,etmp]=size(x);
if (etmp==2)
x=x(:,1);
end

%归一化mel滤波器组系数

bank=melbankm(24,256,fs,0,0.5,'m');%Mel滤波器的阶数为24，fft变换的长度为256

bank=full(bank);

bank=bank/max(bank(:));%[24*129]

 %设定DCT系数
 
for k=1:12

n=0:23;

dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));

end

%归一化倒谱提升窗口

w=1+6*sin(pi*[1:12]./12);

w=w/max(w);


%预加重滤波器

xx=double(x);

xx=filter([1-0.98],1,xx);%预加重

xx=enframe(xx,256,128);%对x 256点分为一帧

%计算每帧的MFCC参数

for i=1:size(xx,1)

y=xx(i,:);%取一帧数据

s=y'.*hamming(256);

t=abs(fft(s));%fft快速傅立叶变换  幅度谱

t=t.^2; %能量谱

%对fft参数进行mel滤波取对数再计算倒谱
c1=dctcoef*log(bank*t(1:129));%对能量谱滤波及DCT %t(1:129)对一帧的前128个数（帧移为128）

c2=c1.*w';%归一化倒谱

%mfcc参数

m(i,:)=c2';

end

%求取一阶差分系数

dtm=zeros(size(m));

for i=3:size(m,1)-2

dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);

end

dtm=dtm/3;

%合并mfcc参数和一阶差分mfcc参数

ccc=[m dtm];

%去除首尾两帧，因为这两帧的一阶差分参数为0
ccc=ccc(3:size(m,1)-2,:);

getmfcc=ccc;%返回特征值

end



