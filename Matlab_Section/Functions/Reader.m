function Data = Reader(Folder)

Data = struct();
Directory = dir(Folder);
Target_Folder = Directory(3:end);
Number_of_Elements = length(Target_Folder);

for i = 1:Number_of_Elements
    
    Address = [Target_Folder(i).folder '\' Target_Folder(i).name] ;
    Structured_Data = load(Address);
    
    Data(i).Name = Target_Folder(i).name;
    Data(i).Values = Structured_Data.Cropped_Data;
    
end

end

%% The End :)