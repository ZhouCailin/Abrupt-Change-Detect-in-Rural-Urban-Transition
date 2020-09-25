%ApEn demo
%2020.6 by zhoucailin
data=imread('H:\FILE\RSPRIN\shp\rawtif\lubo_gf_3600_2017.tif');
temp=im2double(data);
map=data.*0;
px=2730;
py=3414;
[ arr_cell,slice_cell ] = imgSlice( temp,px,py );
H=200;
C=100;
T_cell=cell(1,360);
apen_cell=cell(1,360);
mcapen_cell=cell(1,360);

for deg=1:360
%     if deg~=140 && deg~=118 && deg~=100 && deg~=76 && deg~=15 && deg~=56;
%         continue;
%     end
    
    degSlice=slice_cell{1,deg};
    len=size(degSlice);
    lenSlice=len(1,2);
    AP=zeros(1,lenSlice);
    MCAP=AP;
    
    for n=1:length(degSlice)-H
        
        % cal T
        foredata=degSlice(1:n);
        afterdata=degSlice(n+1:length(degSlice)-H);
        v=lenSlice-2;
        s=sqrt((n*var(foredata)+(lenSlice-n)*var(afterdata))/v);
        T(n)=((mean(foredata)-mean(afterdata))/(s*sqrt(1/n+1/(lenSlice-n))));
        
        % cal ApEn
        DT=degSlice(n:n+H);
        Mf=2;
        Rf=0.1-0.2*std(DT);
        AP(n)=ApEn(Mf,Rf,DT);   
                     
    end
    T_cell{1,deg}=T;
    apen_cell{1,deg}=AP;  
%     List=1:lenSlice;
%     figure;plotyy(List,slice_cell{1,deg},List,AP,'plot');
%     axis([0 inf 0 1]);
%     legend('城镇用地比率','ApEn');
%     set(handle(1),'ytick',0:0.2:1);
%     set(handle(1),'ylim',[0 1]);
%     set(handle(2),'ytick',0:0.2:0.8);
%     set(handle(2),'ylim',[0 0.8]);
%     AP=0;
end