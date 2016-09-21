%   filename:SearchMain.m
%   author:Huang Shuaiyi,Tongji University
%   time:September,2016
function [LSHaverate,KDaverate]=SearchMain(querysetPath,datasetPath,querysetNum,datasetNum,DimHashData,knn,Tablecnt,kdtype)
dataset=[];
queryset=[];
if ~isempty(querysetPath)
    queryset=fvecs_read(querysetPath,querysetNum); 
end

if ~isempty(datasetPath)
    dataset=fvecs_read(datasetPath,datasetNum);
end
% fprintf('Single test begin.\n');


%LSH Search 
tic;
LSHIndex=buildIndexImp(dataset,DimHashData,Tablecnt);
[LSHids,LSHdists]=LSHSearch(queryset,dataset,knn,LSHIndex);
time=toc;
% fprintf('LSH done %g sec\n',time);





if strcmp(kdtype,'matlab')
    %KDTree Search from Matlab
    tic;
    NS = createns(dataset','NSMethod','kdtree');
    [KDidsMatlab, KDdistsMatlab] = knnsearch(NS,queryset','k',knn);
    time=toc;
    % fprintf('KDTree done %g sec\n',time);
else
    %KDTree Search from FLANN
    tic;
    [KDidsFLANN,KDdistsFLANN]=flann_search(dataset,queryset,knn,struct('algorithm','kdtree','trees',8,'checks',64));
    time=toc;
    % fprintf('KDTree done %g sec\n',time);
end
    

%Linear Search from Matlab built-in function
[truthids,truthdists]=knnsearch(dataset',queryset','NSMethod','exhaustive','k',knn);

truthids=truthids';
truthdists=truthdists';
 
% Compare result 

[LSHaverate,LSHrateset]=testrate('LSH test',truthids,LSHids);

if strcmp(kdtype,'matlab')
    [KDaverate,KDrateset]=testrate('KDTree Matlab test',truthids,KDidsMatlab');
else
    [KDaverate,KDrateset]=testrate('KDTree Flann test',truthids,KDidsFLANN);
end

 
% fprintf('Single test done.\n');

end