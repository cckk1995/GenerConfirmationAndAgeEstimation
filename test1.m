train=[0 0;2 4;3 3;3 4;4 2;4 4;4 3;5 3;6 2;7 1;2 9;3 8;4 6;4 7;5 6;5 8;6 6;7 4;8 4;10 10];                                              %训练数据点
group=[1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2]'; %训练数据已知分类情况
                                                                            %与train顺序对应
test=[3 2;4 8;6 5;7 6;2 5;5 2];                                                    %测试数据

%训练分类模型
svmModel = svmtrain(train,group,'kernel_function','linear','showplot',true);

%分类测试
classification=svmclassify(svmModel,test,'Showplot',true);