function [energy] = average_energy(signal)
   s=fra(256,128,signal);               
   s2=power(s,2);               %һ֡�ڸ����������
   energy=sum(s2,2);            %��һ֡����
end

