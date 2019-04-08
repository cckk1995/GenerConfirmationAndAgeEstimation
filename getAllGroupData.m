function group = getAllGroupData(projectName,fileFolder,audionumber)
    group=[];
    cnt=length(fileFolder);
    i=1;
    pre=0;
    while i<=cnt
        temp=getAllAudioOfFoler(projectName,char(fileFolder(1,i)));
        tt=length(temp);
        mid=zeros(1,audionumber);
        mid(1,pre+1:pre+tt)=1;
        pre=pre+tt;
       	group(:,i)=mid';
        i=i+1;
    end
end

