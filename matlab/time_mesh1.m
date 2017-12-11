 csi_trace1= read_bf_file('my_data/loc1-2/t1.dat');
 csi_entry1=csi_trace1{1};
  csi1=get_scaled_csi(csi_entry1);
  
   csi_trace2= read_bf_file('my_data/loc1-2/t2.dat');
 csi_entry2=csi_trace2{1};
  csi2=get_scaled_csi(csi_entry2);
  
   csi_trace3= read_bf_file('my_data/loc1-2/t3.dat');
 csi_entry3=csi_trace3{1};
  csi3=get_scaled_csi(csi_entry3);
  
   csi_trace4= read_bf_file('my_data/loc1-2/t4.dat');
 csi_entry4=csi_trace4{1};
  csi4=get_scaled_csi(csi_entry4);
  
   csi_trace5= read_bf_file('my_data/loc1-2/t5.dat');
 csi_entry5=csi_trace5{1};
  csi5=get_scaled_csi(csi_entry5);
  
   csi_trace6= read_bf_file('my_data/loc1-2/t6.dat');
 csi_entry6=csi_trace6{1};
  csi6=get_scaled_csi(csi_entry6);
  
   csi_trace7= read_bf_file('my_data/loc1-2/t7.dat');
 csi_entry7=csi_trace7{1};
  csi7=get_scaled_csi(csi_entry7);
  
   csi_trace8= read_bf_file('my_data/loc1-2/t8.dat');
 csi_entry8=csi_trace8{1};
  csi8=get_scaled_csi(csi_entry8);
  
   csi_trace9= read_bf_file('my_data/loc1-2/t9.dat');
 csi_entry9=csi_trace9{1};
  csi9=get_scaled_csi(csi_entry9);
  
   csi_trace10= read_bf_file('my_data/loc1-2/t10.dat');
 csi_entry10=csi_trace10{1};
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

A=[squeeze(a1(1,1,:)) squeeze(a2(1,1,:)) squeeze(a3(1,1,:)) ...
    squeeze(a4(1,1,:)) squeeze(a5(1,1,:)) squeeze(a6(1,1,:)) ...
  squeeze(a7(1,1,:)) squeeze(a8(1,1,:)) squeeze(a9(1,1,:)) squeeze(a10(1,1,:))  ];

B=[squeeze(b1(1,1,:)) squeeze(b2(1,1,:)) squeeze(b3(1,1,:)) ...
    squeeze(b4(1,1,:)) squeeze(b5(1,1,:)) squeeze(b6(1,1,:)) ...
  squeeze(b7(1,1,:)) squeeze(b8(1,1,:)) squeeze(b9(1,1,:)) squeeze(b10(1,1,:))  ];

C=[squeeze(c1(1,1,:)) squeeze(c2(1,1,:)) squeeze(c3(1,1,:)) ...
    squeeze(c4(1,1,:)) squeeze(c5(1,1,:)) squeeze(c6(1,1,:)) ...
  squeeze(c7(1,1,:)) squeeze(c8(1,1,:)) squeeze(c9(1,1,:)) squeeze(c10(1,1,:))  ];

A_abs=abs(A);   B_abs=abs(B);  C_abs=abs(C);

figure

mesh(A_abs);
colormap winter
title('antenna A');
xlabel('time intervals');
ylabel('sub-carriers');
zlabel('dB');

figure
mesh(B_abs);
colormap summer
title('antenna B');
xlabel('time intervals');
ylabel('sub-carriers');
zlabel('dB');

figure
mesh(C_abs);
colormap spring
title('antenna C');
xlabel('time intervals');
ylabel('sub-carriers');
zlabel('dB');
