clc;clear;
warning('off');


mkdir('C:\Users\zevik\Desktop\New folder\khoone');

   for k=1:22
%        k=randi([1, 19])
       
       files  = dir(strcat('my_data/khoone/LOC',num2str(k),'/*.dat'));
       l=length(files');
       for j=1:l
       
       csi_trace= read_bf_file(strcat('my_data/khoone/LOC',num2str(k),'/',files(1).name));
       emptyCells = cellfun(@isempty, csi_trace);
      if(isempty(emptyCells))
          continue;
      end
      csi_entry=csi_trace{1};
      
      
      csi=get_scaled_csi(csi_entry);
      
    
      save(strcat('csi',num2str(k),'.mat'),'csi');
      movefile(strcat('csi',num2str(k),'.mat'),'C:\Users\zevik\Desktop\New folder\khoone')
      end
      
       
   end
