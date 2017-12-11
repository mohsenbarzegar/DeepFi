clc;
warning('off');


for Loc_num=1:17
    mkdir(strcat('C:\Users\zevik\PycharmProjects\get_csi\Data_otagh_defa_fom_MATLAB\LOC',num2str(Loc_num)));
    files1  = dir(strcat('my_data/otagh-defa/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_1/*.dat'));
    for i=1:20
           csi_trace= read_bf_file(strcat(strcat('my_data/otagh-defa/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_1/'),files1(i).name));
           emptyCells = cellfun(@isempty, csi_trace);
          if(isempty(emptyCells))
              continue;
          end
          csi_entry=csi_trace{1};


          csi=get_scaled_csi(csi_entry);
          rssi= get_total_rss(csi_entry);


          save(strcat('csi',num2str(i),'.mat'),'csi');
          save(strcat('rssi',num2str(i),'.mat'),'rssi');
          movefile(strcat('csi',num2str(i),'.mat'),strcat('C:\Users\zevik\PycharmProjects\get_csi\Data_otagh_defa_fom_MATLAB\LOC',num2str(Loc_num)))
          movefile(strcat('rssi',num2str(i),'.mat'),strcat('C:\Users\zevik\PycharmProjects\get_csi\Data_otagh_defa_fom_MATLAB\LOC',num2str(Loc_num)))


       end

       %************************%

      
end
disp('The data Sent Sucssesfully!');

