%   filename:buildIndexImp.m
%   author:Huang Shuaiyi,Tongji University
%   time:September,2016
function   lshIndex=buildIndexImp(dataset,DimHashData,T)
%   Using random projection to project data and build LSH Index
%   INPUT:
%   T:# of tables
%   DimHashData:# of dimensions at projection spaces
%   dataset:[D*N] matrix containning N colums of D-dimension data
%   OUTPUT:
%   lshIndex:[1*L] array of structs with fields:
%   projMat:[D*DimHashData] projection Matrix
%   HashData:[N*M] binary matrix containing N rows of M-dimension data
%   DimHashData:# of dimensions at projection spaces
%   tabelCnt:# of tables

    [D,~]=size(dataset);
    lshIndex(T,4)=struct('projMat',[],'HashData',[],'DimHashData',DimHashData,'tabelCnt',T);
%   Create T tables
    for t=1:T
        projMat=normrnd(0,1,D,DimHashData);
        %   project data using random projection
        HashData=dataset'*projMat;
        HashData(HashData>0)=1;
        HashData(HashData<=0)=0;
        lshIndex(t).projMat=projMat;
        lshIndex(t).HashData=HashData;
        lshIndex(t).DimHashData=DimHashData;
        lshIndex(t).tableCnt=T;
    end
end


