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
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,dNum,var,knn,tNum);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='׼ȷ��VS�����ռ�ά��';
    xlabelstr='�����ռ�ά��';
    ylabelstr='׼ȷ��';
end 


if strcmp(varname,'tNum')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,dNum,dHam,knn,var);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='׼ȷ��VS��ϣ����';
    xlabelstr='��ϣ����';
    ylabelstr='׼ȷ��';
end 
    
if strcmp(varname,'dNum')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,var,dHam,knn,tNum);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='׼ȷ��VSѵ����������';
    xlabelstr='ѵ����������';
    ylabelstr='׼ȷ��';
end 

if strcmp(varname,'qNum')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,var,dNum,dHam,knn,tNum);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='׼ȷ��VS������������';
    xlabelstr='������������';
    ylabelstr='׼ȷ��';
end 

if strcmp(varname,'knn')
    for var=varmin:vargap:varmax
        Variables=[Variables,var];
        [LSHaverate,KDTreeaverate]=SearchMain(qpath,dpath,qNum,dNum,dHam,var,tNum);
        LSHSet=[LSHSet,LSHaverate];
        KDTreeSet=[KDTreeSet,KDTreeaverate];
    end
    titlestr='׼ȷ��VS����ھӵ�����';
    xlabelstr='����ھӵ�����';
    ylabelstr='׼ȷ��';
end 

    %Plot result
    experiment_LSHaverate=sum(LSHSet)/length(LSHSet);
    experiment_KDTreeaverate=sum(KDTreeSet)/length(KDTreeSet);
    fprintf('Experiment %d times,done.\n',length(LSHSet));
    fprintf('LSH average accuracy rate is:%f\n',experiment_LSHaverate);
    fprintf('KDTree average accuracy rate is:%f\n',experiment_KDTreeaverate);
    % plot(DimHashDataSet,LSHSet,'-*r',DimHashDataSet,KDTreeSet,'-*b')
     figure;
     plot(Variables,LSHSet,'-*r');
     title(titlestr);
     hold on;
     plot(Variables,KDTreeSet,'-*b');
     grid on;
     xlabel(xlabelstr);
     ylabel(ylabelstr);
     legend('LSH','KDTree',0);
end