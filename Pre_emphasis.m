function xx=Pre_emphasis(signal)
% 预加重  input:输入信号
%        output:预加重后信号
    x=double(signal);
    xx=filter([1,-0.98],1,x); %预加重滤波器
end