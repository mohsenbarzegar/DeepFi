%% #AP ra jaye #zaman=interval yani masalan 2 zaman posht ham csi migirim
%packet ham yani csi 1 sanie i 
%pas 10 packet darim va 5 zaman yani 10 sanie migirim ye 5 sanie va misim
%dobare 10 sanie be hamin tartib
%dar vaghe:  har zaman=interval ---> 5s stop    har packet -->10s capture csi posht
%ham va baraye har zaman 10 packet darim  
%dar kol dar inja 2 interval va baraye har interval 10 packet darim  %R=2
%P=10

 clc;
 clear;
 warning('off');
 

 folder3='C:/Users/zevik/Desktop/Times/interval3/';
files3 = dir('C:/Users/zevik/Desktop/Times/interval3/*.mat');

CSI={};  %havi matris csi dar har packet va har interval

for i=1:length(files3)
   CSI(1,i)=num2cell(load([folder3 files3(i).name]));

end


param.c=3*(1e8);
%param.f_c=2.4*10^9
param.f_c=5*10^9;
param.delta_f=312.5e3;
param.Max_Phase=60;
param.Max_time=50;
param.N=30;


param.theta=linspace(-pi,pi,param.Max_Phase);
param.taw=linspace(0,5e-8,param.Max_time);

sigma_taw=zeros(1,5);
sigma_theta=zeros(1,5);
mean_taw=zeros(1,5);
mean_theta=zeros(1,5);

%C=zeros(1,5);
%Likelihood=zeros(1,5);
%wc,w_theta,w_taw,ws???

Eig_thresh=100;

a=creare_steering_vector(param);

for t=1:1
    data_f=[];
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
        CSI_tmp_adjust=CSI_tmp.*exp(j*CSI_ang_adjust);
        CSI_ang_adjust_ang=pi+angle(CSI_tmp_adjust);
        
       
        %Obtain smoothed CSI matrix X as in Fig
        X=smoother(CSI_tmp_adjust);
        %Construct matrix EN whose columns are eigenvectors of XXH 
        %corresponding to eigenvalues that are smaller than a threshold
        XH=(X');
        A=X*XH;
        %[evecs, D] = eigs(A);
        [U1, S, V ] = svd(A);
        evals = diag(S);
        Selected_vecs=find(evals<Eig_thresh);
        %Selected_vecs=length(evals); 
       % EN=U(:,Selected_vecs);
        EN=U1(:,end-20:end);
        
         
        
        %Evaluate MUSIC spectrum
        %3 antenna and 30 sensor steering vector is 
        
        ENH=EN'; 
        
        for itime=1:param.Max_time %Time
            for iPhase=1:param.Max_Phase %Phase
                a_l=a{itime,iPhase};
                a_lH=a_l';
                P_music(itime,iPhase)=1./(a_lH*(EN*ENH)*a_l);
            end
        end
    
        
        [B,Icol]=max(max(abs(P_music),[],1));
        [B,Irow]=max(max(abs(P_music),[],2));
       
       % AoA(t,p)=param.theta(Icol);  %havi khdoe peak be tanhayi
       % ToF(t,p)=param.taw(Irow)+10^-12;
        
        %FIND PEAK(S) of P_music
        AA=imregionalmax(abs(P_music));  %index haye local maxima=1 
        [r_i c_i]=find(AA==1); %satr , sotoon havi peak ha

        min_max=10^3;  
        max_max=0;
        for tmpidx=1:length(r_i)
            if (abs(P_music(r_i(tmpidx),c_i(tmpidx)))>=max_max)
                max_max=abs(P_music(r_i(tmpidx),c_i(tmpidx)));
            end
            if (abs(P_music(r_i(tmpidx),c_i(tmpidx)))<=min_max)
                min_max=abs(P_music(r_i(tmpidx),c_i(tmpidx)));
            end
        end
        peaks_thresh=min((4*min_max+max_max)/5,max_max/3); %treshhold , bayangaye yek treshhold baraye ertefa
       % [min_max max_max peaks_thresh];
        for tmpidx=1:length(r_i)
            if (abs(P_music(r_i(tmpidx),c_i(tmpidx)))>peaks_thresh)
                AoA_f(t,p,tmpidx)=param.theta(c_i(tmpidx));  %3D
                ToF_f(t,p,tmpidx)=param.taw(r_i(tmpidx))+10^-12; %3D
                data_f=[data_f
                        ToF_f(t,p,tmpidx) AoA_f(t,p,tmpidx)/2  ];
            end
         end
        % surf(abs(P_music));  %comment it for complete simulation
       
    end  %end of packets

     % data_f_norm=data_f./repmat(max(data_f),size(data_f,1),1);
     ToF_norm= data_f(:,1)/max(data_f(:,1));
      AoA_norm= data_f(:,2)/max(data_f(:,2));
      data_f_norm=[ToF_norm,AoA_norm];
     %ta inja har dafe sabet ast vali az inja be bad omdatan maghadir har
     %dafe avaz mishe!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
        
        n_clusters = 5;              % number of clusters
       
        %[center,U,obj_fcn] = fcm(data_f_norm, n_clusters);
        %[Group_IDX,U,obj_fcn] = kmeans(data_normalize, n_clusters);
        [Group_IDX,U1,obj_fcn] = kmeans(data_f_norm, n_clusters);
        %maxU = max(U);
        index={};
        for i=1:1:n_clusters

            %index{i} = find(U(i,:) == maxU);
            index{i} = find (Group_IDX==i);
            sigma_taw(i)=var(data_f_norm(index{i},1));
            mean_taw(i)=mean(data_f_norm(index{i},1));
            mean_theta(i)=mean(data_f_norm(index{i},2));
            mean_theta_origial(i)=mean(data_f(index{i},2));
            sigma_theta(i)=var(data_f_norm(index{i},2));
            C(i)=length(index{i});
            wc=0.1; w_theta=1/max(sigma_theta);
            w_taw=1/max(sigma_taw); ws=1/max(mean_taw);
            Likelihood(i)=(wc*C(i)-w_theta*sigma_theta(i)-...
                w_taw*sigma_taw(i)-ws* mean_taw(i));

        end

        colors=['r','m','b','k','g'];
        shapes=['O','*','>','x','+'];
        set(figure,'Color','w');
        title(strcat('The clustered data with 5 clusters for interval3'));
        for i=1:n_clusters
               line(data_f_norm(index{i},1),data_f_norm(index{i}, 2),'linestyle','none',...
                  'marker',shapes(i),'color',colors(i));
        end
        legend('1','2','3',...
              '4','5','Location','SE')
         
          
        
       [~,h_ind]=max(Likelihood); %index of highest likelihood value
          %Declare AoA of cluster with highest likelihood value
         %  as direct path AoA ?i 
         theta_i_interval3=mean_theta_origial(h_ind);  %direct path AoA
         Li_interval3=Likelihood(h_ind);
        
end 



Li_interval3
theta_i_interval3=theta_i_interval3*180/pi;
theta_i_interval3
res3=[Li_interval3,theta_i_interval3];
save('r3.mat','res3');



