clc;clear;
[csi]=create_my_array('my_data/otagh_defa/loc16_2.dat');
save('spec.mat','csi')
copyfile('spec.mat','C:\Users\zevik\PycharmProjects\get_csi')
