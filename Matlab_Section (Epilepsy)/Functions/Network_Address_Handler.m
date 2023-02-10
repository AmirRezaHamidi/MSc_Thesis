function Network_Data  = Network_Address_Handler(Folder)

if ~exist(Folder, "dir")
    
    error("Directory Does Not Exists")

end

Network_Data_Folder_Content = dir(Folder);
Categories = string(ones(1, length(Network_Data_Folder_Content) - 2));

for i = 3:length(Network_Data_Folder_Content)

    k = i - 2;
    Category = string(Network_Data_Folder_Content(i).name);
    Categories(k) = Category;

end

Network_Data = fullfile(Folder , Categories );

end

