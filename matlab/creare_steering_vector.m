function a=creare_steering_vector(param)
 
d=1e-2; %2cm
%f_delta=linspace(312.5e3,312.5e3*29,29);
f_delta=312.5e3;



for itime=1:param.Max_time %Time
    for iPhase=1:param.Max_Phase %Phase
        %Omega_taw=my_omega(param.taw(itime),f_delta,param.N);
        Omega_taw=my_omega(param.taw(itime),f_delta,param.N/2); %15 ta
        Phi_theta1=my_phi(param.theta(iPhase),d,param);  %yek adad
        Phi_theta2=my_phi(param.theta(iPhase),2*d,param);  %yek adad
        %a{itime,iPhase}=[Omega_taw,Phi_theta1*Omega_taw,Phi_theta2*Omega_taw].';
        a{itime,iPhase}=[Omega_taw,Phi_theta1*Omega_taw].'; %%?
    end
end
  
       
    