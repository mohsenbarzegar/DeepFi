function varagout=SpotFy_Read_Multiple(Loc_num);
clc;
warning('off');
files1  = dir(strcat('my_data/420-part2/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_1/*.dat'));
l=length(files1');
mkdir('C:\Users\zevik\Desktop\Times\interval1');

   for i=1:l
       csi_trace= read_bf_file(strcat(strcat('my_data/420-part2/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_1/'),files1(i).name));
       emptyCells = cellfun(@isempty, csi_trace);
      if(isempty(emptyCells))
          continue;
      end
      csi_entry=csi_trace{1};
      
      
      csi=get_scaled_csi(csi_entry);
      
    
      save(strcat('csi',num2str(i),'.mat'),'csi');
      movefile(strcat('csi',num2str(i),'.mat'),'C:\Users\zevik\Desktop\Times\interval1')
      

   end
   
   %************************%
   
   files2  = dir(strcat('my_data/420-part2/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_2/*.dat'));
l=length(files2');
mkdir('C:\Users\zevik\Desktop\Times\interval2');

   for i=1:l
       csi_trace= read_bf_file(strcat(strcat('my_data/420-part2/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_2/'),files2(i).name));
       emptyCells = cellfun(@isempty, csi_trace);
      if(isempty(emptyCells))
          continue;
      end
      csi_entry=csi_trace{1};
      
      
      csi=get_scaled_csi(csi_entry);
      
    
      save(strcat('csi',num2str(i),'.mat'),'csi');
      movefile(strcat('csi',num2str(i),'.mat'),'C:\Users\zevik\Desktop\Times\interval2')
      

   end
   
   
   
   %*************************%
files3  = dir(strcat('my_data/420-part2/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_3/*.dat'));
l=length(files3');
mkdir('C:\Users\zevik\Desktop\Times\interval3');

   for i=1:l
       csi_trace= read_bf_file(strcat(strcat('my_data/420-part2/LOC',num2str(Loc_num),'/loc',num2str(Loc_num),'_3/'),files3(i).name));
       emptyCells = cellfun(@isempty, csi_trace);
      if(isempty(emptyCells))
          continue;
      end
      csi_entry=csi_trace{1};
      
      
      csi=get_scaled_csi(csi_entry);
      
    
      save(strcat('csi',num2str(i),'.mat'),'csi');
      movefile(strcat('csi',num2str(i),'.mat'),'C:\Users\zevik\Desktop\Times\interval3')
      

   end

disp('The data has been Read Sucssesfully!');