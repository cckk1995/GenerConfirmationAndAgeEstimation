function Y_new = audiocut(x,fs,length) 
    start_time = 0;  
    end_time = length;  
    Y_new=x((fs*start_time+1):fs*end_time,1);  
end