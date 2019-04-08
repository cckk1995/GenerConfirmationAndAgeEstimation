function [energy] = average_energy(signal)
   s=fra(256,128,signal);               
   s2=power(s,2);               %一帧内各样点的能量
   energy=sum(s2,2);            %求一帧能量
end

