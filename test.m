src='/Users/chaikai/Downloads/j2at06f211.wav';
tosrc='/Users/chaikai/Desktop/WRD/aa';
[x,fs]=audioread(src);
x=resample(x,16000,44100);
newx=x(:,1);
len=length(x);
fs=16000;
i=1;
 while i*fs*8<=len
    newx=x((i-1)*fs*8+1:i*fs*8);
    name=[tosrc,num2str(i),'.wav'];
    audiowrite(name,newx,fs);
    i=i+1;
 end

