clc;
close all;
clear;
%a=ceil(4.0);
a=rand;
cellSize=4;
%n=3;%矩阵的维度
Width=500;
Height=500;
%r=ceil(cellSize*sqrt(2));%最小距离
r=2*cellSize;
min_dist=r;%就是r
max_dist=2*min_dist;
%new_points_count=0;

%cellSize=int32(r/2);
%cellSize=ceil(r/sqrt(n));

outputlist=cell(Width,Height);
grid=zeros(Width,Height);
for i=1:Width
    for j=1:Height
        outputlist{i,j}=zeros(cellSize,cellSize);
    end 
end

%processlist=cell(Width,Height);
%a=isempty(cell2mat(processlist));%如果是空返回1，不为空返回0；
%————第一个点——————
 W=randi([1 Width]);
 H=randi([1 Height]);
 Wcell=randi([1 cellSize]);
 Hcell=randi([1 cellSize]);
 
 %——将第一个点放入表中————
outputlist{W,H}(Wcell,Hcell)=1;
%processlist{W,H}=outputlist{W,H};
processlist(1,1)=W;
processlist(1,2)=H;
processlist(1,3)=Wcell;
processlist(1,4)=Hcell;
grid(W,H)=1;
%b=isempty(cell2mat(processlist));
%b=cell2mat(processlist);

I=zeros(Width*cellSize,Height*cellSize);%把outputlist转换成一张图;
I((W-1)*cellSize+Wcell,(H-1)*cellSize+Hcell)=255;%第一个点在I中显示

num1=1;
Wnum1(1)=W;
Hnum1(1)=H;

%while (isempty(cell2mat(processlist))==0)
 while (num1>0)
   
    %-——————总是取processlist中第一个点——————
    W1=processlist(1,1);
    H1=processlist(1,2);
    Wcell1=processlist(1,3);
    Hcell1=processlist(1,4);
    %————该点在I中的坐标如下——————
    xp=(W1-1)*cellSize+Wcell1;%列
    yp=(H1-1)*cellSize+Hcell1;%行
    
    grid(W1,H1)=1;%这个点可以点亮
    I(xp,yp)=255;%可以点亮
    
    %————————在以这个点为圆心的圆环内取30个点——————————————————
    k=30;
    for i=1:k
       %————随机取点———— 
       r1=rand;
       r2=rand;
       angle=r1*2*pi;%随机选取角度  %angle=345;
       %r=randi([min_dist max_dist]);%随机选择半径
       r=(r2+1)*min_dist;
       %a=cos(angle*pi/180);
       %b=sin(angle*pi/180);
       Wcellx=cos(angle)*r+xp;%点在图片中的坐标
       Hcelly=sin(angle)*r+yp;%点在图片中的坐标
       
       if mod(Wcellx,cellSize)==0
            W2=ceil(Wcellx/cellSize);
            Wcell2=cellSize;
       else
           W2=ceil(Wcellx/cellSize);%求点所在的cell
           Wcell2=ceil(mod(Wcellx,cellSize));
       end
       if mod(Hcelly,cellSize)==0
            H2=ceil(Hcelly/cellSize);%求点所在的cell
            Hcell2=cellSize;
       else
            H2=ceil(Hcelly/cellSize);%求点所在的cell
            Hcell2=ceil(mod(Hcelly,cellSize));
       end
     
       if (W2<Width-1&&H2<Height-1&&W2>2&&H2>2)
           %cell5=outputlist(W2-2:W2+2,H2-2:H2+2);%用outputlist检查该点周围5*5区域内是否有点
           %sum1=sum(sum(cell2mat(cell5)));
           sum1=sum(sum(grid(W2-2:W2+2,H2-2:H2+2)));
       else 
           sum1=1;%说明没找到点
       end
       if(sum1==0) %说明找到点了
           mid=zeros(cellSize,cellSize);
           mid(Wcell2,Hcell2)=1;%在cell中的坐标记录下来
           outputlist{W2,H2}=mid;
           
           num1=num1+1;%processlist中增加一个点
           %————将该点存储在processlist末尾
           processlist(num1,1)=W2;
           processlist(num1,2)=H2;
           processlist(num1,3)=Wcell2;
           processlist(num1,4)=Hcell2;
      
           grid(W2,H2)=1;%grid中点亮该点所在的cell
           I(ceil(Wcellx),ceil(Hcelly))=255;%I中点亮该点
       end
    end
    %——————删除processlist第一个点，因为以上步骤已在第1个点所在的圆环查找——————
    processlist=processlist(2:num1,:);
    num1=num1-1;
end
figure(1);
imshow(I);
imwrite(I,'I.jpg');