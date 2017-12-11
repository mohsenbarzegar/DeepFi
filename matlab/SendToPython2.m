clc;
warning('off');

source = 'C:\Users\Mohsen.B\Documents\My Drive\Electrical engineering\Statistical Learning\Projects\Indoor localization\matlab\DataSet\room1\LOC'
dis = 'C:\Users\Mohsen.B\Documents\My Drive\Electrical engineering\Statistical Learning\Projects\Indoor localization\matlab\DataSet\room1_data\LOC'

for Loc_num=1:17
    mkdir(strcat(dist,num2str(Loc_num)));
    for k=1:3
        files1  = dir(strcat(source,num2str(Loc_num),'\loc',num2str(Loc_num) ,'_' ,num2str(k) , '/*.dat'));
        for i=1:20
               csi_trace= read_bf_file(strcat(strcat(source,num2str(Loc_num),'\loc',num2str(Loc_num) ,'_' ,num2str(k),'\'),files1(i).name));
               emptyCells = cellfun(@isempty, csi_trace);
              if(isempty(emptyCells))
                  continue;
              end
              csi_entry=csi_trace{1};


              csi=get_scaled_csi(csi_entry);
              rssi= get_total_rss(csi_entry);


              save(strcat(num2str(k),'_csi',num2str(i),'.mat'),'csi');
              save(strcat(num2str(k),'_rssi',num2str(i),'.mat'),'rssi');
              movefile(strcat(num2str(k),'_csi',num2str(i),'.mat'),strcat(dist,num2str(Loc_num)))
              movefile(strcat(num2str(k),'_rssi',num2str(i),'.mat'),strcat(dist,num2str(Loc_num)))


        end
    end

       
end
disp('The data Sent Sucssesfully!');

