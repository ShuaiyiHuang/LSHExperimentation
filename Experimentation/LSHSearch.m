%   filename:knnSearch.m
%   author:Huang Shuaiyi,Tongji University
%   time:September,2016
%   perform LSH knnsearch
function [LSHids,LSHdists]=LSHSearch(queryset,dataset,knn,LSHIndex)
%   T:# of tables
    T=LSHIndex.tableCnt;
%   P:# of dataset
    P=size(dataset,2);
%   M:# of queryset
    M=size(queryset,2);
    if knn>P
        knn=P;
    end
    
    LSHids=[];
    LSHdists=[];
    CandidateIndices_all=zeros(M,T*knn,'int64');

    HammingdistSet=zeros(M,P,'int64');
    for t=1:T
        Q=queryset'*LSHIndex(t).projMat;
        Q(Q>0)=1;
        Q(Q<=0)=0;
        D=LSHIndex(t).HashData;
        %HammingdistSet:[M*P]
        HammingdistSet=[];
        for i=1:M
            for j=1:P
%                 HammingdistSet(i,j)=calhamming(Q(i,:),D(j,:));
                hammingdist=length(find(xor(Q(i,:),D(j,:))==1));
                HammingdistSet(i,j)=hammingdist;
            end
        end
        
        [~,Indices]=sort(HammingdistSet,2);
        %   CandidateIndices_per_table:[P*knn] matrix containing
        CandidateIndices_per_table=Indices(:,(1:knn));
%         CandidateIndices_all=[C=andidateIndices_all,CandidateIndices_per_table];
        CandidateIndices_all(:,(1+(t-1)*knn:knn+(t-1)*knn))=CandidateIndices_per_table;
        
    end
    
    for i=1:M
        knnIndices=unique(CandidateIndices_all(i,:));
        Candidatedataset=dataset(:,knnIndices)';
        [lshids,lshdists]=knnsearch(Candidatedataset,queryset(:,i)','NSMethod','exhaustive','k',knn);
        LSHdists(:,i)=lshdists;
        LSHids(:,i)=knnIndices(lshids);
    end
     
end