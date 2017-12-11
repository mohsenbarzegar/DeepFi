 clc;clear;
csi_trace= read_bf_file('my_data/otagh_defa/loc16_1.dat');
 csi_entry=csi_trace{1};
  csi=get_scaled_csi(csi_entry);
  rssi= get_total_rss(csi_entry);


n=1:30;
a=squeeze(csi(1,1,:));
b=squeeze(csi(1,2,:));
c=squeeze(csi(1,3,:));

figure
 plot(n,angle(a),'color','r');
 hold on;
 grid on;
 plot(n,angle(b),'color','g');
 hold on;
 plot(n,angle(c),'color','b');

legend('red is A','green is B','blue is C');


