 csi_trace1= read_bf_file('my_data/loc1-2/t1.dat');
 csi_entry1=csi_trace1{1}
  csi1=get_scaled_csi(csi_entry1);
  
   csi_trace2= read_bf_file('my_data/loc1-2/t2.dat');
 csi_entry2=csi_trace2{1}
  csi2=get_scaled_csi(csi_entry2);
  
   csi_trace3= read_bf_file('my_data/loc1-2/t3.dat');
 csi_entry3=csi_trace3{1}
  csi3=get_scaled_csi(csi_entry3);
  
   csi_trace4= read_bf_file('my_data/loc1-2/t4.dat');
 csi_entry4=csi_trace4{1}
  csi4=get_scaled_csi(csi_entry4);
  
   csi_trace5= read_bf_file('my_data/loc1-2/t5.dat');
 csi_entry5=csi_trace5{1}
  csi5=get_scaled_csi(csi_entry5);
  
   csi_trace6= read_bf_file('my_data/loc1-2/t6.dat');
 csi_entry6=csi_trace6{1}
  csi6=get_scaled_csi(csi_entry6);
  
   csi_trace7= read_bf_file('my_data/loc1-2/t7.dat');
 csi_entry7=csi_trace7{1}
  csi7=get_scaled_csi(csi_entry7);
  
   csi_trace8= read_bf_file('my_data/loc1-2/t8.dat');
 csi_entry8=csi_trace8{1}
  csi8=get_scaled_csi(csi_entry8);
  
   csi_trace9= read_bf_file('my_data/loc1-2/t9.dat');
 csi_entry9=csi_trace9{1}
  csi9=get_scaled_csi(csi_entry9);
  
   csi_trace10= read_bf_file('my_data/loc1-2/t10.dat');
 csi_entry10=csi_trace10{1}
  csi10=get_scaled_csi(csi_entry10);


a1=csi1(1,1,:);   b1=csi1(1,2,:);   c1=csi1(1,3,:);
a2=csi2(1,1,:);   b2=csi2(1,2,:);   c2=csi2(1,3,:);
a3=csi3(1,1,:);   b3=csi3(1,2,:);   c3=csi3(1,3,:);
a4=csi4(1,1,:);   b4=csi4(1,2,:);   c4=csi4(1,3,:);
a5=csi5(1,1,:);   b5=csi5(1,2,:);   c5=csi5(1,3,:);
a6=csi6(1,1,:);   b6=csi6(1,2,:);   c6=csi6(1,3,:);
a7=csi7(1,1,:);   b7=csi7(1,2,:);   c7=csi7(1,3,:);
a8=csi8(1,1,:);   b8=csi8(1,2,:);   c8=csi8(1,3,:);
a9=csi9(1,1,:);   b9=csi9(1,2,:);   c9=csi9(1,3,:);
a10=csi10(1,1,:); b10=csi10(1,2,:); c10=csi10(1,3,:);

%antenna A
f=linspace(2.4-0.02,2.4+0.02,30);
f0=2.4;
CSI_eff1=0;CSI_eff2=0;CSI_eff3=0;CSI_eff4=0;CSI_eff5=0;CSI_eff6=0;
CSI_eff7=0;CSI_eff8=0;CSI_eff9=0;CSI_eff10=0;
for i=1:30
    CSI_eff1=CSI_eff1+(f(i)*abs(a1(i)))/f0/30;
    CSI_eff2=CSI_eff2+(f(i)*abs(a2(i)))/f0/30;
    CSI_eff3=CSI_eff3+(f(i)*abs(a3(i)))/f0/30;
    CSI_eff4=CSI_eff4+(f(i)*abs(a4(i)))/f0/30;
    CSI_eff5=CSI_eff5+(f(i)*abs(a5(i)))/f0/30;
    CSI_eff6=CSI_eff6+f(i)*(abs(a6(i)))/f0/30;
    CSI_eff7=CSI_eff7+f(i)*(abs(a7(i)))/f0/30;
    CSI_eff8=CSI_eff8+f(i)*(abs(a8(i)))/f0/30;
    CSI_eff9=CSI_eff9+f(i)*(abs(a9(i)))/f0/30;
    CSI_eff10=CSI_eff10+f(i)*(abs(a10(i)))/f0/30;
end


CSI_eff_a=[CSI_eff1,CSI_eff2,CSI_eff3,CSI_eff4,CSI_eff5,...
    CSI_eff6,CSI_eff7,CSI_eff8,CSI_eff9,CSI_eff10];

%antenna B
CSI_eff1=0;CSI_eff2=0;CSI_eff3=0;CSI_eff4=0;CSI_eff5=0;CSI_eff6=0;
CSI_eff7=0;CSI_eff8=0;CSI_eff9=0;CSI_eff10=0;
for i=1:30
    CSI_eff1=CSI_eff1+(f(i)*abs(b1(i)))/f0/30;
    CSI_eff2=CSI_eff2+(f(i)*abs(b2(i)))/f0/30;
    CSI_eff3=CSI_eff3+(f(i)*abs(b3(i)))/f0/30;
    CSI_eff4=CSI_eff4+(f(i)*abs(b4(i)))/f0/30;
    CSI_eff5=CSI_eff5+(f(i)*abs(b5(i)))/f0/30;
    CSI_eff6=CSI_eff6+f(i)*(abs(b6(i)))/f0/30;
    CSI_eff7=CSI_eff7+f(i)*(abs(b7(i)))/f0/30;
    CSI_eff8=CSI_eff8+f(i)*(abs(b8(i)))/f0/30;
    CSI_eff9=CSI_eff9+f(i)*(abs(b9(i)))/f0/30;
    CSI_eff10=CSI_eff10+f(i)*(abs(b10(i)))/f0/30;
end


CSI_eff_b=[CSI_eff1,CSI_eff2,CSI_eff3,CSI_eff4,CSI_eff5,...
    CSI_eff6,CSI_eff7,CSI_eff8,CSI_eff9,CSI_eff10];

%antenna C
CSI_eff1=0;CSI_eff2=0;CSI_eff3=0;CSI_eff4=0;CSI_eff5=0;CSI_eff6=0;
CSI_eff7=0;CSI_eff8=0;CSI_eff9=0;CSI_eff10=0;

for i=1:30
    CSI_eff1=CSI_eff1+(f(i)*abs(c1(i)))/f0/30;
    CSI_eff2=CSI_eff2+(f(i)*abs(c2(i)))/f0/30;
    CSI_eff3=CSI_eff3+(f(i)*abs(c3(i)))/f0/30;
    CSI_eff4=CSI_eff4+(f(i)*abs(c4(i)))/f0/30;
    CSI_eff5=CSI_eff5+(f(i)*abs(c5(i)))/f0/30;
    CSI_eff6=CSI_eff6+f(i)*(abs(c6(i)))/f0/30;
    CSI_eff7=CSI_eff7+f(i)*(abs(c7(i)))/f0/30;
    CSI_eff8=CSI_eff8+f(i)*(abs(c8(i)))/f0/30;
    CSI_eff9=CSI_eff9+f(i)*(abs(c9(i)))/f0/30;
    CSI_eff10=CSI_eff10+f(i)*(abs(c10(i)))/f0/30;
end


CSI_eff_c=[CSI_eff1,CSI_eff2,CSI_eff3,CSI_eff4,CSI_eff5,...
    CSI_eff6,CSI_eff7,CSI_eff8,CSI_eff9,CSI_eff10];

figure
t=1:10;

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

