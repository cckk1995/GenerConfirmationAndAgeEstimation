function ff=addWindow(framelength,step,signal)
%��֡��Ӵ�����
    ff=fra(framelength,step,signal);
    [n,m]=size(ff);
    i=1;
    while i<=n
        ff(i,:)=ff(i,:).*(hamming(framelength))';
        i=i+1;
    end
end