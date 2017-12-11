clc;clear;
csi_trace1= read_bf_file('my_data/otagh_defa/loc15_1.dat');
 csi_entry1=csi_trace1{1}
  csi1=get_scaled_csi(csi_entry1);
  
   csi_trace2= read_bf_file('my_data/otagh_defa/loc15_2.dat');
 csi_entry2=csi_trace2{1};
  csi2=get_scaled_csi(csi_entry2);
  
   csi_trace3= read_bf_file('my_data/otagh_defa/loc15_3.dat');
 csi_entry3=csi_trace3{1}
  csi3=get_scaled_csi(csi_entry3);
  
   csi_trace4= read_bf_file('my_data/otagh_defa/loc15_4.dat');
 csi_entry4=csi_trace4{1}
  csi4=get_scaled_csi(csi_entry4);
  
   csi_trace5= read_bf_file('my_data/otagh_defa/loc15_5.dat');
 csi_entry5=csi_trace5{1}
  csi5=get_scaled_csi(csi_entry5);
  



%%%antena A
a1=csi1(1,1,:);   b1=csi1(1,2,:);   c1=csi1(1,3,:);
a2=csi2(1,1,:);   b2=csi2(1,2,:);   c2=csi2(1,3,:);
a3=csi3(1,1,:);   b3=csi3(1,2,:);   c3=csi3(1,3,:);
a4=csi4(1,1,:);   b4=csi4(1,2,:);   c4=csi4(1,3,:);
a5=csi5(1,1,:);   b5=csi5(1,2,:);   c5=csi5(1,3,:);


A=abs([squeeze(a1(1,1,:)),squeeze(a2(1,1,:)),squeeze(a3(1,1,:)),squeeze(a4(1,1,:)),squeeze(a5(1,1,:))]);

B=abs([squeeze(b1(1,1,:)) squeeze(b2(1,1,:)) squeeze(b3(1,1,:)) squeeze(b4(1,1,:)) squeeze(b5(1,1,:))]);

C=abs([squeeze(c1(1,1,:)) squeeze(c2(1,1,:)) squeeze(c3(1,1,:)) squeeze(c4(1,1,:)) squeeze(c5(1,1,:))]);


mesh(A);
colormap winter
title('antenna A');
xlabel('time intervals');
ylabel('sub-carriers');
zlabel('dB');

figure
mesh(B);
colormap summer
title('antenna B');
xlabel('time intervals');
ylabel('sub-carriers');
zlabel('dB');

figure
mesh(C);
colormap spring
title('antenna C');
xlabel('time intervals');
ylabel('sub-carriers');
zlabel('dB');


