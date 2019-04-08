function output = toOneDim( input,dim)
    output=[];
    [n,m]=size(input);
    i=1;
    while i<=n
        if dim<=m
            output=[output,input(i,1:dim)];
        else
            temp=input(i,1:m);
            j=m+1;
            while j<=dim
                temp(1,j)=0;
                j=j+1;
            end
            output=[output,temp];
        end
        i=i+1;
    end
end

