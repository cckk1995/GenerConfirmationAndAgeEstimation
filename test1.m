train=[0 0;2 4;3 3;3 4;4 2;4 4;4 3;5 3;6 2;7 1;2 9;3 8;4 6;4 7;5 6;5 8;6 6;7 4;8 4;10 10];                                              %ѵ�����ݵ�
group=[1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2]'; %ѵ��������֪�������
                                                                            %��train˳���Ӧ
test=[3 2;4 8;6 5;7 6;2 5;5 2];                                                    %��������

%ѵ������ģ��
svmModel = svmtrain(train,group,'kernel_function','linear','showplot',true);

%�������
classification=svmclassify(svmModel,test,'Showplot',true);