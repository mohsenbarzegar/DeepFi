function y=smoother(x)
%x is csi matrix 1*3*30
y=zeros(30,32);
%x is 3*30
x=x.'; %30*3

for i=1:16
    y(:,i)=[x(i:14+i,1);x(i:i+14,2)];
end
for i=1:16
    y(:,i+16)=[x(i:14+i,2);x(i:i+14,3)];
end
