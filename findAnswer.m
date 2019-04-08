function index = findAnswer(data,group,testdata)
   [n,m]=size(group);
   i=1;
   tt=zeros(1,m);
   if m==2
       temp=group(:,1);
       SVMstruct=svmtrain(data,temp);
       an=svmclassify(SVMstruct,testdata);
       index=an(1,1);
       if index==0
           index=2;
       end
       return;
   end
   while i<=m
       temp=group(:,i);
       SVMstruct=svmtrain(data,temp);
       an=svmclassify(SVMstruct,testdata);
       tt(1,i)=an(1,1);
       i=i+1;
   end
   i=1;
   while i<=m
       if tt(1,i)==1
           index=i;
           break;
       end
       i=i+1;
   end
   if i>m
        index=2;
   end
end

