function [ temp ] = getAllAudioOfFoler(projectLocation,FolderName)
       src=[projectLocation,'/',FolderName];
       fileFolder=fullfile(src);
       fileList=dir(fullfile(fileFolder,'*wav'));
       temp={};
       i=1;
       cnt=length(fileList);
       while i<=cnt
           temp{i}=[fileList(i).folder,'/',fileList(i).name];
           i=i+1;
       end
end

