function xx=Pre_emphasis(signal)
% Ԥ����  input:�����ź�
%        output:Ԥ���غ��ź�
    x=double(signal);
    xx=filter([1,-0.98],1,x); %Ԥ�����˲���
end