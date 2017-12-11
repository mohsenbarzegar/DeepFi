clc;clear;
files  = dir('C:\Users\zevik\Desktop\New folder\khoone\*.mat');
l=length(files');
csi={};
a=zeros(l,1,1,30); b=zeros(l,1,1,30);  c=zeros(l,1,1,30);
for i=1:l
    csi{i}=load(strcat('C:\Users\zevik\Desktop\New folder\khoone\',files(i).name));
    z=struct2array(csi{i});
    a(i,:,1,:)=z(1,1,:);
    b(i,:,1,:)=z(1,2,:);
    c(i,:,1,:)=z(1,3,:);
    A=abs(squeeze(a))';
    B=abs(squeeze(b))';
    C=abs(squeeze(c))';
    
    
end

figure
mesh(A);
title('antenna A');
xlabel('loc number');
ylabel('sub-carriers');

figure
mesh(B);
title('antenna B');
xlabel('loc number');
ylabel('sub-carriers');

figure
mesh(C);
title('antenna C');
xlabel('loc number');
ylabel('sub-carriers');
