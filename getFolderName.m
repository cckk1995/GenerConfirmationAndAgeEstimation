function fileFolder = getFolderName(str)
    bmpPath = str; 
    FileList = dir(bmpPath);
    ff=1;
    fileFolder={};
    for rr=1:length(FileList)
        if(FileList(rr).isdir==1&&~strcmp(FileList(rr).name,'data')&&~strcmp(FileList(rr).name,'.')&&~strcmp(FileList(rr).name,'..'))
            fileFolder{ff}=[FileList(rr).name];
            ff=ff+1;
        end
    end
end