function getmfcc= MFCC2par(x,fs)
 %=========================================================
 % ��ȡMFCC��������
 % ��ȥ�뼰�˵���
 % Input:��Ƶ����x,������fs
 % Output��(N,M)��С��������������  ����NΪ��֡������MΪ����ά��
 % ����������M=24 ����ϵ��12ά��һ�ײ��12ά
 %=========================================================
tic
%[x fs]=wavread(sound);
%ȡ�������ź�
[~,etmp]=size(x);
if (etmp==2)
x=x(:,1);
end

%��һ��mel�˲�����ϵ��

bank=melbankm(24,256,fs,0,0.5,'m');%Mel�˲����Ľ���Ϊ24��fft�任�ĳ���Ϊ256

bank=full(bank);

bank=bank/max(bank(:));%[24*129]

 %�趨DCTϵ��
 
for k=1:12

n=0:23;

dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));

end

%��һ��������������

w=1+6*sin(pi*[1:12]./12);

w=w/max(w);


%Ԥ�����˲���

xx=double(x);

xx=filter([1-0.98],1,xx);%Ԥ����

xx=enframe(xx,256,128);%��x 256���Ϊһ֡

%����ÿ֡��MFCC����

for i=1:size(xx,1)

y=xx(i,:);%ȡһ֡����

s=y'.*hamming(256);

t=abs(fft(s));%fft���ٸ���Ҷ�任  ������

t=t.^2; %������

%��fft��������mel�˲�ȡ�����ټ��㵹��
c1=dctcoef*log(bank*t(1:129));%���������˲���DCT %t(1:129)��һ֡��ǰ128������֡��Ϊ128��

c2=c1.*w';%��һ������

%mfcc����

m(i,:)=c2';

end

%��ȡһ�ײ��ϵ��

dtm=zeros(size(m));

for i=3:size(m,1)-2

dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);

end

dtm=dtm/3;

%�ϲ�mfcc������һ�ײ��mfcc����

ccc=[m dtm];

%ȥ����β��֡����Ϊ����֡��һ�ײ�ֲ���Ϊ0
ccc=ccc(3:size(m,1)-2,:);

getmfcc=ccc;%��������ֵ

end



