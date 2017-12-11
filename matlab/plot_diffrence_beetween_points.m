clc;clear;
files  = dir('C:\Users\zevik\Desktop\CSI3s\*.mat');
l=length(files');
csi={};
a=zeros(l,1,1,30); b=zeros(l,1,1,30);  c=zeros(l,1,1,30);
for i=1:l
    csi{i}=load(strcat('C:\Users\zevik\Desktop\CSI3s\',files(i).name));
    z=struct2array(csi{i});
    a(i,:,1,:)=z(1,1,:);
    b(i,:,1,:)=z(1,2,:);
    c(i,:,1,:)=z(1,3,:);
    A=abs(squeeze(a))';
    B=abs(squeeze(b))';
    C=abs(squeeze(c))';
    
    
end

% figure
% mesh(A);
% title('antenna A');
% xlabel('time intervals');
% ylabel('sub-carriers');
% zlabel('CSI Magnitude')
% 
% figure
% mesh(B);
% title('antenna B');
% xlabel('time intervals');
% ylabel('sub-carriers');
% zlabel('CSI Magnitude')
% 
% figure
% mesh(C);
% title('antenna C');
% xlabel('time intervals');
% ylabel('sub-carriers');
% zlabel('CSI Magnitude')

% A=sort(A)
% B=sort(B)
% C=sort(C)
std_A=[]
std_B=[]
std_C=[]
for i=1:19
    std_A(i)=std(A(:,i)./max(A(:,i)))
    std_B(i)=std(B(:,i)./max(A(:,i)))
    std_C(i)=std(C(:,i)./max(A(:,i)))
end
mu = 0;
sigma = 1;
pd = makedist('Normal',mu,sigma);
A_ = cdf(pd,(std_A));
B_ = cdf(pd,(std_B));
C_ = cdf(pd,(std_C));

x_=linspace(0,1,length(A_));
plot([0,sort(std_A),1],[0,sort(A_),1],'-rs','LineWidth',1.5,...
    'MarkerSize',5)
hold on
plot([0,sort(std_B),1],[0,sort(B_),1],'--g*','LineWidth',1.5,...
    'MarkerSize',5)
hold on
plot([0,sort(std_C)],[0,sort(C_)],'-.b*','LineWidth',1.5,...
    'MarkerSize',5)
xlabel('Std of CSI values in 30 diffrent locations over 3 antennas')
% xlim([0 1])
ylim([0 1])
grid on
ylabel('CDF')
legend('Antenna 1','Antenna 2','Antenna 3','Location','southeast')
