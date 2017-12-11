myu=load('u.mat');
 myp=load('p.mat');
myd=load('d.mat');
mym=load('my_mean_thetha_org');

isequal(U,myu.U)
isequal(P_music,myp.P_music)
isequal(data_f_norm,myd.data_f_norm)

isequal(mean_theta_origial,mym.mean_theta_origial) %false