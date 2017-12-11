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
  
   csi_trace6= read_bf_file('my_data/otagh_defa/loc15_6.dat');
 csi_entry6=csi_trace6{1}
  csi6=get_scaled_csi(csi_entry6);
  



%%%antena A
a1=csi1(1,1,:);   b1=csi1(1,2,:);   c1=csi1(1,3,:);
a2=csi2(1,1,:);   b2=csi2(1,2,:);   c2=csi2(1,3,:);
a3=csi3(1,1,:);   b3=csi3(1,2,:);   c3=csi3(1,3,:);
a4=csi4(1,1,:);   b4=csi4(1,2,:);   c4=csi4(1,3,:);
a5=csi5(1,1,:);   b5=csi5(1,2,:);   c5=csi5(1,3,:);
a6=csi6(1,1,:);   b6=csi6(1,2,:);   c6=csi6(1,3,:);

B=[squeeze(b1(1,1,:)) squeeze(b2(1,1,:)) squeeze(b3(1,1,:)) squeeze(b4(1,1,:)) squeeze(b5(1,1,:)) squeeze(b6(1,1,:)) ];
f=linspace(2.4-0.02,2.4+0.02,30);
f0=2.4;
CSI_eff1=0;CSI_eff2=0;CSI_eff3=0;CSI_eff4=0;CSI_eff5=0;CSI_eff6=0;
for i=1:30
    CSI_eff1=CSI_eff1+(f(i)*abs(a1(i)))/f0/30;
    CSI_eff2=CSI_eff2+(f(i)*abs(a2(i)))/f0/30;
    CSI_eff3=CSI_eff3+(f(i)*abs(a3(i)))/f0/30;
    CSI_eff4=CSI_eff4+(f(i)*abs(a4(i)))/f0/30;
    CSI_eff5=CSI_eff5+(f(i)*abs(a5(i)))/f0/30;
    CSI_eff6=CSI_eff6+f(i)*(abs(a6(i)))/f0/30;
end


CSI_eff_a=[CSI_eff1,CSI_eff2,CSI_eff3,CSI_eff4,CSI_eff5,...
    CSI_eff6];

%%%antena B
CSI_eff1=0;CSI_eff2=0;CSI_eff3=0;CSI_eff4=0;CSI_eff5=0;CSI_eff6=0;
for i=1:30
    CSI_eff1=CSI_eff1+f(i)*abs(b1(i))/f0/30;
    CSI_eff2=CSI_eff2+f(i)*abs(b2(i))/f0/30;
    CSI_eff3=CSI_eff3+f(i)*abs(b3(i))/f0/30;
    CSI_eff4=CSI_eff4+f(i)*abs(b4(i))/f0/30;
    CSI_eff5=CSI_eff5+f(i)*abs(b5(i))/f0/30;
    CSI_eff6=CSI_eff6+f(i)*abs(b6(i))/f0/30;
end


CSI_eff_b=[CSI_eff1,CSI_eff2,CSI_eff3,CSI_eff4,CSI_eff5,...
    CSI_eff6];

%%%antena C

CSI_eff1=0;CSI_eff2=0;CSI_eff3=0;CSI_eff4=0;CSI_eff5=0;CSI_eff6=0;
for i=1:30
    CSI_eff1=CSI_eff1+f(i)*abs(c1(i))/f0/30;
    CSI_eff2=CSI_eff2+f(i)*abs(c2(i))/f0/30;
    CSI_eff3=CSI_eff3+f(i)*abs(c3(i))/f0/30;
    CSI_eff4=CSI_eff4+f(i)*abs(c4(i))/f0/30;
    CSI_eff5=CSI_eff5+f(i)*abs(c5(i))/f0/30;
    CSI_eff6=CSI_eff6+f(i)*abs(c6(i))/f0/30;
end

CSI_eff_c=[CSI_eff1,CSI_eff2,CSI_eff3,CSI_eff4,CSI_eff5,...
    CSI_eff6];

figure
t=1:6;

subplot(221);
plot(t,CSI_eff_a,'*','color','b');title('CSI-eff-a');xlabel('Time Interval');ylabel('db');
ylim([0 30]);
grid on;
subplot(222);
plot(t,CSI_eff_b,'*','color','r');title('CSI-eff-b');xlabel('Time Interval');ylabel('db');
ylim([0 30]);
grid on;
subplot(223);
plot(t,CSI_eff_c,'*','color','g');title('CSI-eff-c');xlabel('Time Interval');ylabel('db');
ylim([0 30]);
grid on;

