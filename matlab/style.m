 csi_trace= read_bf_file('my_data/csiade');
 csi_entry=csi_trace{1}
  csi=get_scaled_csi(csi_entry);






n=1:30;
a=csi(1,1,:);
b=csi(2,2,:);
c=csi(3,3,:);

figure

for i=1:30
    plot(n(i),abs(a(i)),'*');
    hold on
end
title('Antena A')

figure

for i=1:30
    plot(n(i),abs(b(i)),'*');
    hold on
end
title('Antena B')

figure
title('Antena C')
for i=1:30
    plot(n(i),abs(c(i)),'*');
    hold on
end
title('Antena C')


