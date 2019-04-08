function [data,audionumber]  = getTableData( projectLocation )
    audionumber=0;
    folderName=getFolderName(projectLocation);
    cnt=length(folderName);
    i=1;
    data={};
    while i<=cnt
        temp=[projectLocation,'/',char(folderName(1,i))];
        t=fullfile(temp);
        tt=dir(fullfile(t,'*.wav'));
        num=length(tt);
        audionumber=audionumber+num;
        temp={char(folderName(1,i)),num2str(num)};
        data(i,:)=temp;
        i=i+1;
    end
end

