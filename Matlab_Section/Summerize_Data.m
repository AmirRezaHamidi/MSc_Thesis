addpath("Functions")
close all; clear; clc;
%% This Script Summerize the Information of the Subjects

Dataset_Address = "Dataset\Subjects\";
Directory_Folders = dir(Dataset_Address);
Number_of_Subjects = length(Directory_Folders);
Subjects_Information = struct();
Auxiliary_Index = 0;

for Subject_Number = 1:Number_of_Subjects - 3

    Subject_Folder = Directory_Folders(Subject_Number + 2).name;
    Subject_Folder_Address = Dataset_Address + Subject_Folder;

    TxT_File = Subject_Folder + "-summary.txt";
    TxT_File_Address = Subject_Folder_Address + "\" + TxT_File;
    
    R_N = 0;
    Sucessful = false;
    Structre = struct();
    FID = fopen(TxT_File_Address, "r");

    while true

        line = fgetl(FID);

        if line == -1
            
            Sucessful = true;
            break
        
        end

        if (length(line) > 9) && (line(1:9)) == "Channel 1"
            
            if line ~= "Channel 1: FP1-F7"

                break

            end

            line = fgetl(FID);

            if line ~= "Channel 2: F7-T7"
                
                break

            end
            
            line = fgetl(FID);
            
            if line ~= "Channel 3: T7-P7"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 4: P7-O1"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 5: FP1-F3"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 6: F3-C3"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 7: C3-P3"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 8: P3-O1"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 9: FP2-F4"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 10: F4-C4"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 11: C4-P4"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 12: P4-O2"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 13: FP2-F8"
                
                break

            end

            line = fgetl(FID);
            
            if line ~= "Channel 14: F8-T8"
                
                break

            end

            line = fgetl(FID);
            
            if line ~= "Channel 15: T8-P8"
                
                break

            end

            line = fgetl(FID);
            
            if line ~= "Channel 16: P8-O2"
                
                break

            end

            line = fgetl(FID);
            
            if line ~= "Channel 17: FZ-CZ"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 18: CZ-PZ"

                break

            end

            line = fgetl(FID);

            if line ~= "Channel 19: P7-T7"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 20: T7-FT9"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 21: FT9-FT10"
                
                break

            end

            line = fgetl(FID);

            if line ~= "Channel 22: FT10-T8"
                
                break

            end

            line = fgetl(FID);
        end

        if (length(line) > 9) && (line(1:9) == "File Name")

            R_N = R_N + 1;
            File_Address = Subject_Folder_Address + "\" + line(12:end);
            Structre(R_N).Path = convertStringsToChars(File_Address);

        elseif (length(line) > 15) && (line(1:15) == "File Start Time")

            Time_in_Day = Clock2Day(line(18:end));
            Structre(R_N).Record_Start = Time_in_Day;

        elseif (length(line) > 13) && (line(1:13) == "File End Time")

            Time_in_Day = Clock2Day(line(16:end));
            Structre(R_N).Record_End = Time_in_Day;

            Structre(R_N).Record_Length = Time_in_Day - ...
                Structre(R_N).Record_Start;

        elseif (length(line) > 26) && (line(1:6) == "Number")
            
            Number_of_Seizures = str2double(line(29));
            
            if Number_of_Seizures == 0

                Structre(R_N).Number_of_Seizures = 0;
            
            else

                Structre(R_N).Number_of_Seizures = ...
                    Number_of_Seizures;
                Structre(R_N).Seizures_Info = struct();

                for seizure = 1 : Number_of_Seizures

                    Structre(R_N).Seizures_Info(seizure).Seizure_Number = ...
                        seizure;

                    line = fgetl(FID);
                    [start_index, end_index] = Index_Finder(line);
                    Structre(R_N).Seizures_Info(seizure).Start...
                        = str2double(line(start_index:end_index));

                    line = fgetl(FID);
                    [start_index, end_index] = Index_Finder(line);
                    Structre(R_N).Seizures_Info(seizure).End...
                        = str2double(line(start_index:end_index));
                    
                    Structre(R_N).Seizures_Info(seizure).Length ...
                        = Structre(R_N).Seizures_Info(seizure).End ...
                        - Structre(R_N).Seizures_Info(seizure).Start;
                end

            end

        end

    end

    if Sucessful == true

        Auxiliary_Index = Auxiliary_Index + 1;
        Subject_Number_String = ['Number ', num2str(Subject_Number)];
        Subjects_Information(Auxiliary_Index).Subject_Number = ...
            Subject_Number_String;
        Subjects_Information(Auxiliary_Index).Subejct_Information = ...
            Structre;

    end

end

save('Dataset\Subjects_Information.mat','Subjects_Information')
close all; clear; clc
%% The End :)