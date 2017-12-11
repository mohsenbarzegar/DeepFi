%get 3 results of 3 intervals and get the final results
simulate_interval1;
simulate_interval2;
simulate_interval3;

res1=struct2array(load('r1.mat'))
res2=struct2array(load('r2.mat'))
res3=struct2array(load('r3.mat'))
theta1=res1(2); L1=res1(1);
theta2=res2(2); L2=res2(1);
theta3=res3(2); L3=res3(1);

if (sign(theta1) == sign(theta2) || sign(theta1) == sign(theta3) )
    Li=[L1,L2,L3];
    Thetai=[theta2,theta2,theta3];
    theta_avg=sum(Li.*Thetai)./sum(Li)  
else
    disp('try Again');
end



