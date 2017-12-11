
%Time interval t  Packet p
clc;
z=squeeze(CSI{t,p}.csi);
n1=1:30;
%for ant 1
plot(n1,unwrap(angle(z(1,:))),'.','Color','g')
%for ant 2
hold on
plot(n1,unwrap(angle(z(2,:))),'.','Color','r')
%for ant 3
hold on
plot(n1,unwrap(angle(z(3,:))),'.','Color','b')

legend('ant 1','ant 2','ant 3');


 figure
        n1=1:30;
        plot(n1,(CSI_ang_adjust_ang),'Color','g')
         

