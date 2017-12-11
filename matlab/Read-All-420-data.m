clc;clear;
warning('off');


mkdir('C:\Users\zevik\Desktop\New folder\420');

   for k=1:19
%        k=randi([1, 19])
       
       files  = dir(strcat('my_data/420-part2/LOC',num2str(k),'/loc',num2str(k),'_1','/*.dat'));
       l=length(files');
       for j=1:l
       
       csi_trace= read_bf_file(strcat('my_data/420-part2/LOC',num2str(k),'/loc',num2str(k),'_1','/',files(1).name));
       emptyCells = cellfun(@isempty, csi_trace);
      if(isempty(emptyCells))
          continue;
      end
      csi_entry=csi_trace{1};
      
      
      csi=get_scaled_csi(csi_entry);
      
    
      save(strcat('csi','_loc_',num2str(k),'_',num2str(j),'.mat'),'csi');
      movefile(strcat('csi',num2str(k),'.mat'),'C:\Users\zevik\Desktop\New folder\420')
      end
      
       
   end
