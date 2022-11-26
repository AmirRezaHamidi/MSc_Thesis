function Data = Reader(Folder)

Data = containers.Map;
Target_Folder = dir(Folder);
Number_of_Elements= length(Target_Folder);

for i = 3:Number_of_Elements
    
    Address = [Target_Folder(i).folder '\' Target_Folder(i).name] ;
    Structured_Data = load(Address);
    Data(Target_Folder(i).name) = Structured_Data.Cropped_Data;
    
end

end

%% The End :)