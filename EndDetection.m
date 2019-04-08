function [afterEndDet] =EndDetection(x)
 %================================i=========================
 % �˵���
 % Input:��Ƶ����x,������fs
 % Output�������˵�����ȡ�������ź�
 %=========================================================

%���ȹ�һ����[-1,1]
x = double(x);
x = x / max(abs(x));

%��������
FrameLen = 256;%֡��Ϊ256��
FrameInc = 80;%֡��Ϊ80��
amp1 = 10;%��ʼ��ʱ����������
amp2 = 2;%��ʼ��ʱ����������
zcr1 = 10;%��ʼ��ʱ�����ʸ�����
zcr2 = 5;%��ʼ��ʱ�����ʵ�����
maxsilence = 8;  % 8*10ms  = 80ms

%���������������������ȣ�����������еľ���֡��δ������ֵ������Ϊ������û���������������
%��ֵ����������γ���count�����жϣ���count<minlen������Ϊǰ���������Ϊ��������������������
%״̬0����count>minlen������Ϊ�����ν�����

minlen  = 15;    % 15*10ms = 150ms
%�����ε���̳��ȣ��������γ���С�ڴ�ֵ������Ϊ��Ϊһ������


status  = 0;     %��ʼ״̬Ϊ����״̬
count   = 0;     %��ʼ�����γ���Ϊ0
silence = 0;     %��ʼ�����γ���Ϊ0

%���������
x1=x(1:end-1);
x2=x(2:end);
%��֡
tmp1=enframe(x1,FrameLen,FrameInc);
tmp2=enframe(x2,FrameLen,FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);%һ֡һ��ֵ

%�����ʱ����
%һ֡һ��ֵ
%amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);
amp = sum(abs(enframe(x, FrameLen, FrameInc)), 2);

%������������

amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);
 

%��ʼ�˵���
%Forѭ���������źŸ�֡�Ƚ�
%���ݸ�֡�����ж�֡�����Ľ׶�
x1 = 0;
x2 = 0;
v_num=0;%��¼��������
v_Begin=[];%��¼���������ε����
v_End=[];%��¼���������ε��յ�

%length(zcr)��Ϊ֡��
for n=1:length(zcr)
   goto = 0;
   switch status
   case {0,1}                   % 0 = ����, 1 = ���ܿ�ʼ
      if amp(n) > amp1          % ȷ�Ž���������
         x1 = max(n-count-1,1);
%          '��ӡÿ��x1*FrameInc'
%          x1*FrameInc
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... % ���ܴ���������
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                       % ����״̬
         status  = 0;
         count   = 0;
      end
   case 2,                       % 2 = ������
      if amp(n) > amp2 | ...     % ������������
         zcr(n) > zcr2
         count = count + 1;
      else                       % ����������
         silence = silence+1;
         if silence < maxsilence % ����������������δ����
            count  = count + 1;
         elseif count < minlen   % ��������̫�̣���Ϊ������
            status  = 0;
            silence = 0;
            count   = 0;
         else                    % ��������
            status  = 3;
         end
      end
   case 3,
      %break;
      %��¼��ǰ����������
      v_num=v_num+1;   %�����θ�����һ
      count = count-silence/2;
      x2 = x1 + count -1;
      v_Begin(1,v_num)=x1*FrameInc; 
      v_End(1,v_num)=x2*FrameInc;
      %������ ���ݹ���������²�����һ������
      status  = 0;     %��ʼ״̬Ϊ����״̬
      count   = 0;     %��ʼ�����γ���Ϊ0
      silence = 0;     %��ʼ�����γ���Ϊ0


   end
end  

if length(v_End)==0
    x2 = x1 + count -1;
    v_Begin(1,1)=x1*FrameInc; 
    v_End(1,1)=x2*FrameInc;
end

lenafter=0;
beginnum=0;
endnum=0;
for len=1:length(v_End)
    tmp=v_End(1,len)-v_Begin(1,len);
    lenafter=lenafter+tmp;
end
afterEndDet=zeros(lenafter,1);%����ȥ�������ε������ź�

    for k=1:length(v_End)
        tmp=x(v_Begin(1,k):v_End(1,k));
        beginnum=endnum+1;
        endnum=beginnum+v_End(1,k)-v_Begin(1,k);
        afterEndDet(beginnum:endnum)=tmp; 
    end

end
