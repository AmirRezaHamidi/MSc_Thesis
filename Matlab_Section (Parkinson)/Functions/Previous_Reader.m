function Data = Reader(Folder)

Data = containers.Map;
Target_Folder = dir(Folder);
Number_of_Subjects = length(Target_Folder);

for i = 3:Number_of_Subjects
    
    Subject_Number = Target_Folder(i).name(1:2);
    Address = Folder + Subject_Number + ".mat";
    Structured_Data = load(Address);
    Data(Subject_Number) = Structured_Data.Data;
    
end

end

%% The End :)