%#AP ra jaye #zaman=interval yani masalan 2 zaman posht ham csi migirim
%packet ham yani csi 1 sanie i 
%pas 10 packet darim va 5 zaman yani 10 sanie migirim ye 5 sanie va misim
%dobare 10 sanie be hamin tartib
%dar vaghe:  har zaman=interval ---> 5s stop    har packet -->10s capture csi posht
%ham va baraye har zaman 10 packet darim  
%dar kol dar inja 2 interval va baraye har interval 10 packet darim  %R=2
%P=10

 clc;clear;
 
 
 folder1='C:/Users/zevik/Desktop/Times/interval1/';
files1 = dir('C:/Users/zevik/Desktop/Times/interval1/*.mat');
 folder2='C:/Users/zevik/Desktop/Times/interval2/';
files2 = dir('C:/Users/zevik/Desktop/Times/interval2/*.mat');
 folder3='C:/Users/zevik/Desktop/Times/interval3/';
files3 = dir('C:/Users/zevik/Desktop/Times/interval3/*.mat');

CSI={};  %havi matris csi dar har packet va har interval
for i=1:length(files1)
   CSI(1,i)=num2cell(load([folder1 files1(i).name]));
   CSI(2,i)=num2cell(load([folder2 files2(i).name]));
   CSI(3,i)=num2cell(load([folder3 files3(i).name]));
   
end
theta=linspace(0,2*pi,30);
taw=linspace(0,2e-8,30);
sigma_taw=zeros(1,5);
sigma_theta=zeros(1,5);
mean_taw=zeros(1,5);
mean_theta=zeros(1,5);
Li=zeros(1,3);

C=zeros(1,5);
Likelihood=zeros(1,5);
%wc,w_theta,w_taw,ws???
wc=1;w_theta=1e3;w_taw=1e4;ws=1;

theta_i=zeros(1,3);
Eig_thresh=700;
a=creare_steering_vector();

for t=1:3
    for p=1:20
        %Remove linear fit in CSI phase response by applying Algorithm1
        
        %Obtain smoothed CSI matrix X as in Fig
        X=smoother(CSI{t,p}.csi);
        %Construct matrix EN whose columns are eigenvectors of XXH 
        %corresponding to eigenvalues that are smaller than a threshold
        XH=(X');
        A=X*XH;
        [evecs, D] = eigs(A);
        evals = diag(D);
        %Selected_vecs=find(evals<Eig_thresh);
        Selected_vecs=length(evals);
        EN=evecs(:,Selected_vecs);
        
        
        
        %Evaluate MUSIC spectrum
        %3 antenna and 30 sensor steering vector is 
       % a1=reshape(a,30,3)';
        aH=a';
        ENH=EN';
        
       % P_music=1./(a*aH*(EN*ENH));
        P_music=1./(a*aH*(EN*ENH));
        [B,I]=max(abs(P_music(:)));
        index_row=ceil(I/30);
        index_col=mod(I,30)+1;
        
        AoA(t,p)=B;
       % AoA(t,p)=theta(index_row);
       % ToF(t,p)=taw(index_row);
       ToF(t,p)=taw(index_row);
       
          
    end
    
     ToF(t,:)=ToF(t,:)/(max(ToF(t,:))); %normalize TOF
     AoA(t,:)=AoA(t,:)/(max(AoA(t,:)))-0.5; %normalize AoA
     
        data=[ToF(t,:)',AoA(t,:)'];
      %  figure
      %  plot(data(:,1), data(:,2),'o','color','b');
      %  title(strcat('Raw data for interval',num2str(t)));
        
     
        
        n_clusters = 5;              % number of clusters
       
        [center,U,obj_fcn] = fcm(data, n_clusters);
        maxU = max(U);
        index={};
        for i=1:1:n_clusters

            index{i} = find(U(i,:) == maxU);
            sigma_taw(i)=var(data(index{i},1));
            mean_taw(i)=mean(data(index{i},1));
            mean_theta(i)=mean(data(index{i},2));
            sigma_theta(i)=var(data(index{i},2));
            C(i)=length(index{i});
            Likelihood(i)=exp(wc*C(i)*-w_theta*sigma_theta(i)-...
                w_taw*sigma_taw(i)-ws* mean_taw(i));

        end
        figure(t);
        colors=['r','m','b','y','k'];
        set(figure(t),'Color','w');
        title(strcat('The clustered data with 5 clusters for interval',num2str(t)));
        for i=1:n_clusters
               line(data(index{i},1),data(index{i}, 2),'linestyle','none',...
                  'marker','O','color',colors(i));
        end
        legend('1','2','3',...
              '4','5','Location','NW')
        
          
        
       [~,h_ind]=max(Likelihood); %index of highest likelihood value
          %Declare AoA of cluster with highest likelihood value
         %  as direct path AoA ?i 
         theta_i(t)=mean_theta(h_ind);  %direct path AoA
         Li(t)=max(Likelihood);
        
end

%Minimize objective with optimization variables as
%target’s location and path loss model parameters
disp(mean(theta_i.*Li)*180);


        


 
