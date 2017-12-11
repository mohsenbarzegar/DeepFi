clc;clear;
for i =19
files  = dir(strcat('C:\Users\zevik\Desktop\CSI3s\loc',num2str(i),'\*.mat'));
l=length(files');
csi={};
a=zeros(l,1,1,30); b=zeros(l,1,1,30);  c=zeros(l,1,1,30);
std_A=[];
std_B=[];
std_C=[];
for ii=1:l
    csi=load(strcat('C:\Users\zevik\Desktop\CSI3s\loc',num2str(i),'\',files(ii).name));
    csi=((struct2array(csi)))
    csi=squeeze(csi)
    std_A(i)=std(csi(1,:)/max(csi(1,:)));
     std_B(i)=std(csi(2,:)/max(csi(2,:)));
      std_C(i)=std(csi(3,:)/max(csi(3,:)));
    
    
    
end
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
plot([0,sort(std_B)],[0,sort(B_)],'--g*','LineWidth',1.5,...
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
