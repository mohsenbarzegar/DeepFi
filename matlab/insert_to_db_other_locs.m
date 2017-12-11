clc;clear
folder3='C:/Users/zevik/Desktop/New folder/420/';
files3 = dir('C:/Users/zevik/Desktop/New folder/420/*.mat');
CSI={};
for i=1:length(files3)
   CSI(1,i)=num2cell(load([folder3 files3(i).name]));
end


colnames = {'Id','SubCarrier','Antenna1','Antenna2','Antenna3'};


dbname = 'csi';
username = 'root';
password = '';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];

javaaddpath 'mysql-connector-java-5.0.8-bin.jar';

%conn = database(dbname, username, password, driver, dburl);
conn=database('csi', 'root', '', 'com.mysql.jdbc.Driver', 'jdbc:mysql://localhost/');

%sent to table1=loc1
for i=1:30  %num of packets
    csi=squeeze(CSI{i+30*18}.csi); %packeti
    csi_A=(csi(1,:));
    csi_B=(csi(2,:));
    csi_C=(csi(3,:));
    csi_sent=[csi_A,csi_B,csi_C]; %1*90
    tablename1 = 'loc19';


    %*****************************************************************
    for j=1:30

        insertdata1_1 = cell2table({(i-1)*30+j,j,abs(csi_A(j)),abs(csi_B(j)),abs(csi_C(j))},'VariableNames',colnames)
        fastinsert(conn,tablename1,colnames,insertdata1_1)

    end
end
