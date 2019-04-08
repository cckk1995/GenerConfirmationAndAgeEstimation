function middata  = getOneTrainData( recdata,fs )
    recdata=Pre_emphasis(recdata);
    recdata=EndDetection(recdata);
    if length(recdata)>2*fs
        recdata=audiocut(recdata,fs,2);   
    end
	mfcc=MFCC2par(recdata,fs);
	energe=average_energy(recdata);
	mfcc=mfcc';
	energe=energe';
	middata=toOneDim(mfcc,500);
	middata=[middata,toOneDim(energe,1000)];
end

