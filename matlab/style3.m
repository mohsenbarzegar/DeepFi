 clc;clear;
csi_trace= read_bf_file('my_data/420-part2/LOC4/loc4_1/t6.dat');
 csi_entry=csi_trace{1};
  csi=get_scaled_csi(csi_entry);
  rssi= get_total_rss(csi_entry)


% n=1:4;
% a=csi_entry.rssi_a;
% b=csi_entry.rssi_b;
% c=csi_entry.rssi_c;
% d=rssi;
% spec=[a,b,c,abs(d)]; 
% 
% figure
% % 
% % for i=1:30
%      plot(n,spec,'*','color','r');
% %     hold on
% %     
% %      plot(n(i),abs(b(i)),'*','color','g');
% %     hold on
% %     
% %      plot(n(i),abs(c(i)),'*','color','b');
% %     hold on
% %     ylim([0 30]);
%      grid on
%      ylim([25,65]);
% % end
% % legend('red is A','green is B','blue is C');
% % 
% % 
