 clc;clear;
csi_trace1= read_bf_file('my_data/420-part2/LOC18/loc18_1/t9.dat');
 csi_entry1=csi_trace1{1};
  csi1=get_scaled_csi(csi_entry1);
  rssi1= get_total_rss(csi_entry1);
  
  
  csi_trace2= read_bf_file('my_data/420-part2/LOC5/loc5_1/t9.dat');
 csi_entry2=csi_trace2{1};
  csi2=get_scaled_csi(csi_entry2);
  rssi2= get_total_rss(csi_entry2);
  
  