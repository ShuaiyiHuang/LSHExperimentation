%   filename:Main.m
%   author:Huang Shuaiyi,Tongji University
%   time:September,2016
%   description:Run Main.m to start the experimentation between LSH and FLANN-KDTree 
%   Param:struct with fileds:
%       qpath:queryset path
%       dpath:dataset path
%       qNum:# of queryset
%       dNum:# of dataset
%       dHam:# of dimensions in Hamming Space
%       knn:# of nearest neighbors
%       tNum:# of tables
%       varname:name of variable,which can be 'qNum','dNum','dHam','knn','tNum'
%       varmin:var range from varmin to varmax and interval is vargap
%       varmax:var range from varmin to varmax and interval is vargap
%       vargap:var range from varmin to varmax and interval is vargap

clc;
siftq='../sift/sift_query.fvecs';
siftb='../sift/sift_base.fvecs';
gistq='../gist/gist_query.fvecs';
gistb='../gist/gist_base.fvecs';

% % % % % % % % % % % % % %Accuracy rate(ratio) VS dHam,variable is dHam
% Figure1,SIFT Case1
fprintf('figure 1...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',10,'dNum',100,'dHam',[],...
    'knn',6,'tNum',10,'varname','dHam','varmin',20,'varmax',130,'vargap',10);
StartExperiment(Param);
% Figure2,SIFT Case2
fprintf('figure 2...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',100,'dNum',1000,'dHam',[],...
'knn',6,'tNum',10,'varname','dHam','varmin',20,'varmax',130,'vargap',10);
StartExperiment(Param);
% Figure3,GIST Case1
fprintf('figure 3...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',10,'dNum',100,'dHam',[],...
    'knn',6,'tNum',20,'varname','dHam','varmin',64,'varmax',256,'vargap',16);
StartExperiment(Param);
% Figure4,GIST Case2
fprintf('figure 4...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',100,'dNum',1000,'dHam',[],...
    'knn',6,'tNum',12,'varname','dHam','varmin',64,'varmax',256,'vargap',16);
StartExperiment(Param);
% % % % % % % % % % % % % % %ratio VS tNum,variable is tNum
%Figure5,SIFT Case1
fprintf('figure 5...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',10,'dNum',100,'dHam',64,...
    'knn',8,'tNum',[],'varname','tNum','varmin',1,'varmax',25,'vargap',1);
StartExperiment(Param);
%Figure6,SIFT Case1
fprintf('figure 6...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',100,'dNum',2000,'dHam',64,...
    'knn',6,'tNum',[],'varname','tNum','varmin',1,'varmax',25,'vargap',1);
StartExperiment(Param);
% Figure7,GIST Case1
fprintf('figure 7...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',100,'dNum',100,'dHam',512,...
    'knn',6,'tNum',[],'varname','tNum','varmin',1,'varmax',25,'vargap',1);
StartExperiment(Param);
% Figure8,GIST Case2
fprintf('figure 8...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',100,'dNum',1000,'dHam',512,...
    'knn',6,'tNum',[],'varname','tNum','varmin',1,'varmax',25,'vargap',1);
StartExperiment(Param);

% % % % % % % % % % % % % % %ratio VS dNum,variable is dNum
%Figure9,SIFT Case1
fprintf('figure 9...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',10,'dNum',[],'dHam',64,...
    'knn',8,'tNum',12,'varname','dNum','varmin',10,'varmax',8000,'vargap',200);
StartExperiment(Param);
%Figure10,GIST Case1
fprintf('figure 10...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',100,'dNum',[],'dHam',128,...
    'knn',8,'tNum',12,'varname','dNum','varmin',10,'varmax',4000,'vargap',100);
StartExperiment(Param);

% % % % % % % % % % % % % % %ratio VS qNum,variable is qNum
%Figure11,SIFT Case
fprintf('figure 11...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',[],'dNum',1000,'dHam',64,...
    'knn',8,'tNum',10,'varname','qNum','varmin',10,'varmax',1000,'vargap',50);
StartExperiment(Param);
%Figure12,GIST Case
fprintf('figure 12...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',[],'dNum',500,'dHam',256,...
    'knn',6,'tNum',10,'varname','qNum','varmin',10,'varmax',200,'vargap',10);
StartExperiment(Param);

% % % % % % % % % % % % % %ratio VS knn,variable is knn
%Figure13,SIFT Case
fprintf('figure 13...');
Param=struct('qpath',siftq,'dpath',siftb,'qNum',50,'dNum',1000,'dHam',64,...
    'knn',[],'tNum',10,'varname','knn','varmin',1,'varmax',20,'vargap',1);
StartExperiment(Param);
% Figure14,GIST Case
fprintf('figure 14...');
Param=struct('qpath',gistq,'dpath',gistb,'qNum',100,'dNum',500,'dHam',256,...
    'knn',[],'tNum',10,'varname','knn','varmin',1,'varmax',40,'vargap',2);
StartExperiment(Param);

