 clc;clear;
csi_trace= read_bf_file('DataSet/LOC17/loc17_3/t8.dat');
%csi_trace= read_bf_file('my_data/khoone/LOC1/t2.dat')
 csi_entry=csi_trace{9};
  csi=get_scaled_csi(csi_entry);
  rssi= get_total_rss(csi_entry);


n=1:30;
a=csi(1,1,:);
b=csi(1,2,:);
c=csi(1,3,:);

figure

for i=1:30
    plot(n(i),abs(a(i)),'*','color','r');
    hold on
    
     plot(n(i),abs(b(i)),'*','color','g');
    hold on
    
     plot(n(i),abs(c(i)),'*','color','b');
    hold on
    ylim([0 30]);
    grid on
end
xlabel('SubCarrier')
ylabel('CSI_ABS')
legend('red is A','green is B','blue is C');


