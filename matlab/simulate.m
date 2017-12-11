%#AP ra jaye #zaman=interval yani masalan 2 zaman posht ham csi migirim
%packet ham yani csi 1 sanie i 
%pas 10 packet darim va 5 zaman yani 10 sanie migirim ye 5 sanie va misim
%dobare 10 sanie be hamin tartib
%dar vaghe:  har zaman=interval ---> 5s stop    har packet -->10s capture csi posht
%ham va baraye har zaman 10 packet darim  
%dar kol dar inja 2 interval va baraye har interval 10 packet darim  %R=2
%P=10
clc;
clear;
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

param.c=3*(1e8);
param.f_c=5*10^9;
param.delta_f=312.5e3;
param.Max_Phase=60;
param.Max_time=30;
param.N=30;
param.theta=linspace(-pi,pi,param.Max_Phase);
param.taw=linspace(1e-15,0.4e-7,param.Max_time);

sigma_taw=zeros(1,5);
sigma_theta=zeros(1,5);
mean_taw=zeros(1,5);
mean_theta=zeros(1,5);
Li=zeros(1,3); 
theta_i=zeros(1,3);
a=creare_steering_vector(param);

for t=1:3
    for p=1:40 
        fprintf('interval = %i, packet = %i\n', t,p)
        %Remove linear fit in CSI phase response by applying Algorithm1
        CSI_tmp=squeeze(CSI{t,p}.csi); 
        CSI_ang=(angle(CSI_tmp));
        
        CSI_ang_unwraped=unwrap(CSI_ang.');
        Inp_tmp=2*pi*param.delta_f*repmat(0:29,3,1)  ;
        Inp_tmp=reshape(Inp_tmp.',[],1); 
        Inp_tmp=[ones(length(Inp_tmp),1) Inp_tmp];
        ofset_estmated = Inp_tmp\reshape(CSI_ang_unwraped,[],1);

        CSI_ang_adjust=-2*pi*param.delta_f*repmat(0:29,3,1)*ofset_estmated(2); 
        CSI_tmp_adjust=(CSI_tmp).*exp(j*CSI_ang_adjust);
        CSI_ang_adjust_ang=pi+angle(CSI_tmp_adjust);
         
        %Obtain smoothed CSI matrix X as in Fig
        X=smoother( CSI_tmp_adjust);
        %Construct matrix EN whose columns are eigenvectors of XXH 
        %corresponding to eigenvalues that are smaller than a threshold
        XH=(X');
        A=X*XH;
        %[evecs, D] = eigs(A);
         
        [U1, S, V ] = svd(A);
        % evals = diag(D);
         %evals = diag(S);
         %Selected_vecs=find(evals<Eig_thresh);
        % EN=U(:,Selected_vecs);
        EN=U1(:,end-20:end);

        %Evaluate MUSIC spectrum
        %3 antenna and 30 sensor steering vector is 
  
        ENH=EN'; 

        for itime=1:param.Max_time %Time
            for iPhase=1:param.Max_Phase %Phase
                a_l=a{itime,iPhase};
                a_lH=a_l';
               P_music(itime,iPhase)=1/((a_lH*(EN*ENH))*a_l);
               
            end
        end
        
%     
        
%         surf(abs(P_music))  %comment that to full sim
        [~,Icol]=max(max(abs(P_music),[],1));
        [~,Irow]=max(max(abs(P_music),[],2));
        z1(t,p)=Icol;
        z2(t,p)=Irow;
        
        

        AoA(t,p)=param.theta(max(Icol));
        ToF(t,p)=param.taw(max(Irow))+1e-15;
        
        
          
    end
    
     ToF_normalize(t,:)=ToF(t,:)/(max(ToF(t,:))); %normalize TOF
     AoA_normalize(t,:)=AoA(t,:)/(max(AoA(t,:))); %normalize AoA

     
        data=[ToF(t,:)',AoA(t,:)'];
        data_normalize=[ToF_normalize(t,:)',AoA_normalize(t,:)'];
      %  figure
      %  plot(data(:,1), data(:,2),'o','color','b');
      %  title(strcat('Raw data for interval',num2str(t)));
 
        n_clusters = 5;              % number of clusters
       
        %[center,U,obj_fcn] = fcm(data_normalize, n_clusters);
        [Group_IDX,U,obj_fcn] = kmeans(data_normalize, n_clusters);
       % maxU = max(U);
        index={};
        for i=1:1:n_clusters

           % index{i} = find(U(i,:) == maxU);
            index{i} = find (Group_IDX==i);
            sigma_taw(i)=var(data_normalize(index{i},1));
            mean_taw(i)=mean(data_normalize(index{i},1));
            mean_theta(i)=mean(data_normalize(index{i},2));
            mean_theta_origial(i)=mean(data(index{i},2));
            sigma_theta(i)=var(data_normalize(index{i},2));
            C(i)=length(index{i});
           % C=C/max(C);
            w_c=1/mean(C);
            w_theta=0.5/mean(sigma_theta);
            w_taw=0.5/mean(sigma_taw);
            ws=0.5/mean(mean_taw(i));
            Likelihood(i)=exp(w_c*C(i)-w_theta*sigma_theta(i)-...
                w_taw*sigma_taw(i)-ws* mean_taw(i));

        end

        colors=['r','m','b','g','k'];
        set(figure,'Color','w');
        shapes=['O','*','>','x','+'];
        title(strcat('The clustered data with 5 clusters for interval',num2str(t)));
        for i=1:n_clusters
               line(data_normalize(index{i},1),data_normalize(index{i}, 2),'linestyle','none',...
                  'marker',shapes(i),'color',colors(i));
        end
        legend('1','2','3',...
              '4','5','Location','SE')
        
          
        
       [~,h_ind]=max(Likelihood); %index of highest likelihood value
          %Declare AoA of cluster with highest likelihood value
         %  as direct path AoA ?i 
         theta_i(t)=mean_theta(h_ind);  %direct path AoA
         Li(t)=Likelihood(h_ind);
        
end
% 
% %Minimize objective with optimization variables as
% %target’s location and path loss model parameters

Li
theta_i*180/pi
theta_avg=(sum(Li.*theta_i)/sum(Li))*180/pi






        


 
