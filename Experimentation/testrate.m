%   filename:StartExperiment.m
%   author:Huang Shuaiyi,Tongji University
%   time:September,2016
%   calculate accuracy rate:
function [averagerate,rateset]=testrate(testname,truthids,get_indices)

[knn1,NumofData1]=size(truthids);
[knn2,NumofData2]=size(get_indices);
if knn1==knn2&&NumofData1==NumofData2
    actual_knn=knn1;
    NumofData=NumofData1;
else
    error('Dimension not identical');
end

 rateset=[];

 for queryid=1:NumofData
     correct=0;
     for j=1:actual_knn
        if truthids(j,queryid)==get_indices(j,queryid)
         correct=correct+1;
        end
     end
     rate=correct/actual_knn;
     rateset=[rateset,rate];
 end
 
 averagerate=sum(rateset)/length(rateset);
%  fprintf('%s rate is: %f\n',testname,averagerate);
 
end