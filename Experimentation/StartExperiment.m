%   filename:StartExperiment.m
%   author:Huang Shuaiyi,Tongji University
%   time:September,2016
%   search and plot result 
%   INPUT:
%   Param:struct.refer to Main.m in detail.
function StartExperiment(Param)
    qpath=Param.qpath;
    dpath=Param.dpath;
    qNum=Param.qNum;
    dNum=Param.dNum;
    dHam=Param.dHam;
    knn=Param.knn;
    tNum=Param.tNum;
    varname=Param.varname;
    varmin=Param.varmin;
    varmax=Param.varmax;
    vargap=Param.vargap;
    kdtype=Param.kdtype;
    fprintf('Experiment begin.\n')
    fprintf('dataset is %s:%d\n',dpath,dNum);
    fprintf('queryset is %s:%d\n',qpath,qNum);
    fprintf('knn is %d\n',knn);
    fprintf('DimHashData is %d\n',dHam);
    fprintf('Table count is %d\n',tNum);

    
    LSHSet=[];
    KDTreeSet=[];
    Variables=[];

if strcmp(varname,'dHam')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,dNum,var,knn,tNum,kdtype);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='准确率VS海明空间维数';
    xlabelstr='海明空间维数';
    ylabelstr='准确率';
end 


if strcmp(varname,'tNum')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,dNum,dHam,knn,var,kdtype);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='准确率VS哈希表数';
    xlabelstr='哈希表数';
    ylabelstr='准确率';
end 
    
if strcmp(varname,'dNum')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,var,dHam,knn,tNum,kdtype);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='准确率VS数据库大小';
    xlabelstr='数据库大小';
    ylabelstr='准确率';
end 

if strcmp(varname,'qNum')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,var,dNum,dHam,knn,tNum,kdtype);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='准确率VS测试样本数量';
    xlabelstr='测试样本数量';
    ylabelstr='准确率';
end 

if strcmp(varname,'knn')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,dNum,dHam,var,tNum,kdtype);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='准确率VS最近邻居点数量';
    xlabelstr='最近邻居点数量';
    ylabelstr='准确率';
end 

    %Plot result
    experiment_LSHaverate=sum(LSHSet)/length(LSHSet);
    experiment_KDTreeaverate=sum(KDTreeSet)/length(KDTreeSet);
    fprintf('Experiment %d times,done.\n',length(LSHSet));
    fprintf('LSH average accuracy rate is:%f\n',experiment_LSHaverate);
    % plot(DimHashDataSet,LSHSet,'-*r',DimHashDataSet,KDTreeSet,'-*b')
     figure;
     plot(Variables,LSHSet,'-*r');
     title(titlestr);
     hold on;
     grid on;
     xlabel(xlabelstr);
     ylabel(ylabelstr);
     
     if strcmp(varname,'dHam')||strcmp(varname,'tNum')
        legend('LSH',0);
        ylim([0 1]);
     else
        fprintf('KDTree average accuracy rate is:%f\n',experiment_KDTreeaverate);
        plot(Variables,KDTreeSet,'-*b');
        legend('LSH','KDTree',0);
        ylim([0 1]);
     end
     
end
