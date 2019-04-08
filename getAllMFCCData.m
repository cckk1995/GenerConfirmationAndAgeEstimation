function data = getAllMFCCData(projectName,fileFolder)
    cnt=length(fileFolder);
    i=1;
    data=[];
    while i<=cnt
        temp=getAllAudioOfFoler(projectName,char(fileFolder(1,i)));
        j=1;
        jj=length(temp);
        while j<=jj
            src=char(temp(1,j));
            disp(src);
            [recdata,fs]=audioread(src);
            middata=getOneTrainData(recdata,fs);
            data=[data;middata];
            j=j+1;
        end
        i=i+1;
    end
    disp('ÑµÁ·Íê³É£¡£¡£¡');
end