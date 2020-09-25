function [ arr_cell,slice_cell ] = imgSlice( data,px,py )
%imgSlice Cut image into 360 strips
%   data:input image
%   px,py:center point's location
%   输出：两个元胞，arr_cell(1,n)表示度数n切条的xy,slice_cell记录img值
%   Author：gp.sysu 周财霖，李恒利

len=size(data);
for deg=0:359     
    n=0;
    sector=0.*data;
    ix=px;iy=py;
    arrlist=[[px py]];
    while ix<len(2) && iy<len(1) && ix>1 && iy>1
        n=n+1;
        oix=ix;oiy=iy;
        ix=uint16(px+n*cosd(deg));
        iy=uint16(py+n*sind(deg));
        if oix~=ix || oiy~=iy
            arrlist=[arrlist;[ix iy]];
        end
    end 
    slice=sector;
    slice(slice==0)=[];
    sliced=[data(px,py)];
    slicelen=length(arrlist);
    for n=1:(slicelen-1) 
        xy=[arrlist(n,1) arrlist(n,2)];
        sliced=[sliced data(xy(2),xy(1))];
    end 
    %缩小切片范围，只切到最后一个0点
    cutpoint=find(sliced>0,1,'last');
    slice_cell{1,deg+1}=sliced(1:cutpoint);
    arr_cell{1,deg+1}=arrlist(1:cutpoint);
    
    clear tslice;

end

        