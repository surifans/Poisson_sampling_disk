clc;
close all;
clear;
%a=ceil(4.0);
a=rand;
cellSize=4;
%n=3;%�����ά��
Width=500;
Height=500;
%r=ceil(cellSize*sqrt(2));%��С����
r=2*cellSize;
min_dist=r;%����r
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
%a=isempty(cell2mat(processlist));%����ǿշ���1����Ϊ�շ���0��
%����������һ���㡪����������
 W=randi([1 Width]);
 H=randi([1 Height]);
 Wcell=randi([1 cellSize]);
 Hcell=randi([1 cellSize]);
 
 %��������һ���������С�������
outputlist{W,H}(Wcell,Hcell)=1;
%processlist{W,H}=outputlist{W,H};
processlist(1,1)=W;
processlist(1,2)=H;
processlist(1,3)=Wcell;
processlist(1,4)=Hcell;
grid(W,H)=1;
%b=isempty(cell2mat(processlist));
%b=cell2mat(processlist);

I=zeros(Width*cellSize,Height*cellSize);%��outputlistת����һ��ͼ;
I((W-1)*cellSize+Wcell,(H-1)*cellSize+Hcell)=255;%��һ������I����ʾ

num1=1;
Wnum1(1)=W;
Hnum1(1)=H;

%while (isempty(cell2mat(processlist))==0)
 while (num1>0)
   
    %-����������������ȡprocesslist�е�һ���㡪����������
    W1=processlist(1,1);
    H1=processlist(1,2);
    Wcell1=processlist(1,3);
    Hcell1=processlist(1,4);
    %���������õ���I�е��������¡�����������
    xp=(W1-1)*cellSize+Wcell1;%��
    yp=(H1-1)*cellSize+Hcell1;%��
    
    grid(W1,H1)=1;%�������Ե���
    I(xp,yp)=255;%���Ե���
    
    %�������������������������ΪԲ�ĵ�Բ����ȡ30���㡪����������������������������������
    k=30;
    for i=1:k
       %�����������ȡ�㡪������ 
       r1=rand;
       r2=rand;
       angle=r1*2*pi;%���ѡȡ�Ƕ�  %angle=345;
       %r=randi([min_dist max_dist]);%���ѡ��뾶
       r=(r2+1)*min_dist;
       %a=cos(angle*pi/180);
       %b=sin(angle*pi/180);
       Wcellx=cos(angle)*r+xp;%����ͼƬ�е�����
       Hcelly=sin(angle)*r+yp;%����ͼƬ�е�����
       
       if mod(Wcellx,cellSize)==0
            W2=ceil(Wcellx/cellSize);
            Wcell2=cellSize;
       else
           W2=ceil(Wcellx/cellSize);%������ڵ�cell
           Wcell2=ceil(mod(Wcellx,cellSize));
       end
       if mod(Hcelly,cellSize)==0
            H2=ceil(Hcelly/cellSize);%������ڵ�cell
            Hcell2=cellSize;
       else
            H2=ceil(Hcelly/cellSize);%������ڵ�cell
            Hcell2=ceil(mod(Hcelly,cellSize));
       end
     
       if (W2<Width-1&&H2<Height-1&&W2>2&&H2>2)
           %cell5=outputlist(W2-2:W2+2,H2-2:H2+2);%��outputlist���õ���Χ5*5�������Ƿ��е�
           %sum1=sum(sum(cell2mat(cell5)));
           sum1=sum(sum(grid(W2-2:W2+2,H2-2:H2+2)));
       else 
           sum1=1;%˵��û�ҵ���
       end
       if(sum1==0) %˵���ҵ�����
           mid=zeros(cellSize,cellSize);
           mid(Wcell2,Hcell2)=1;%��cell�е������¼����
           outputlist{W2,H2}=mid;
           
           num1=num1+1;%processlist������һ����
           %�����������õ�洢��processlistĩβ
           processlist(num1,1)=W2;
           processlist(num1,2)=H2;
           processlist(num1,3)=Wcell2;
           processlist(num1,4)=Hcell2;
      
           grid(W2,H2)=1;%grid�е����õ����ڵ�cell
           I(ceil(Wcellx),ceil(Hcelly))=255;%I�е����õ�
       end
    end
    %������������ɾ��processlist��һ���㣬��Ϊ���ϲ������ڵ�1�������ڵ�Բ�����ҡ�����������
    processlist=processlist(2:num1,:);
    num1=num1-1;
end
figure(1);
imshow(I);
imwrite(I,'I.jpg');