 csi_trace= read_bf_file('my_data/pos19.dat');
 csi_entry=csi_trace{1}
  csi=get_scaled_csi(csi_entry);


n=1:30;
a=csi(1,1,:);
b=csi(1,2,:);
c=csi(1,3,:);

A=ifft(a); 
B=ifft(b);
C=ifft(c);

for i=1:30
    plot(abs(A(i)),'*','color','r');
    hold on
end


