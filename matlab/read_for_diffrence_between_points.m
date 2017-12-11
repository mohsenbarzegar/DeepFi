clc;clear;
warning('off');


mkdir('C:\Users\zevik\Desktop\CSI3s');

   
%        k=randi([1, 19])
    for i=1:19   
       files  = dir(strcat('my_data/420-part2/LOC',num2str(i),'/loc',num2str(i),'_1','/*.dat'));
       l=length(files');
       for k=1:l
       csi_trace= read_bf_file(strcat('my_data/420-part2/LOC',num2str(i),'/loc',num2str(i),'_1','/',files(k).name));
       emptyCells = cellfun(@isempty, csi_trace);
      if(isempty(emptyCells))
          continue;
      end
      csi_entry=csi_trace{1};
      
      
      csi=get_scaled_csi(csi_entry);
      
    
      save(strcat('csi',num2str(i),'_',num2str(k),'.mat'),'csi');
      movefile(strcat('csi',num2str(i),'_',num2str(k),'.mat'),'C:\Users\zevik\Desktop\CSI3s')
       end
    end
      
       

