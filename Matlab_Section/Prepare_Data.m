%% Resovling Environment
addpath("Functions")
Resolve_Environment
close all; clear; clc

%% Parameter Initialization
% Loading Raw Data Information
Summerize_Data
load("Dataset\Subjects_Information.mat")

% Processed Data Path
Processed_IN_Folder = fullfile("Processed_Data\IN\");
Processed_PR_Folder = fullfile("Processed_Data\PR\");

% 1 Minutes Pridction Data Path
First_One_PR_Folder = fullfile("Network_Data\1Minutes\First_Half\");
Second_One_PR_Folder = fullfile("Network_Data\1Minutes\Second_Half\");

% 2 Minutes Pridction Data Path
First_Two_PR_Folder = fullfile("Network_Data\2Minutes\First_Half\");
Second_Two_PR_Folder = fullfile("Network_Data\2Minutes\Second_Half\");

% 4 Minutes Pridction Data Path
First_Four_PR_Folder = fullfile("Network_Data\4Minutes\First_Half\");
Second_Four_PR_Folder = fullfile("Network_Data\4Minutes\Second_Half\");

% 8 Minutes Pridiction Data Path
First_Eight_PR_Folder = fullfile("Network_Data\8Minutes\First_Half\");
Second_Eight_PR_Folder = fullfile("Network_Data\8Minutes\Second_Half\");

% Detection Data Path
Network_IN_Folder = fullfile("Network_Data\Detection\IN\");
Network_PR_Folder = fullfile("Network_Data\Detection\PR\");

%% Choosing N Proper Data from the Raw Dataset
N = 2;
[IN_Batch, PR_Batch] = Choose(Subjects_Information, N);

%% Pre_Process the Raw Data
Process_Folder_is_Full = Check(Processed_IN_Folder);
Produce_Process_Data = "y";

if Process_Folder_is_Full
    
    Message = "Processed Data Exists Do you want to Overwrite it [y/N]?";
    Produce_Process_Data = Asker(Message);
    
end

switch Produce_Process_Data
    
    case "y"
        
        Delete_Path(Processed_IN_Folder)
        Processor(IN_Batch, Processed_IN_Folder)
        
        Delete_Path(Processed_PR_Folder)
        Processor(PR_Batch, Processed_PR_Folder)
        
end

%% Reading Processed Data
IN = Reader(Processed_IN_Folder);
PR = Reader(Processed_PR_Folder);

%% Splitting Data
% Splitted Data Properties
Sample_Size = 8; Channel_Division = 3;

% Splitting PR Data into two 8 Seconds Half
First_One_Splitted_PR = Half_Splitter(PR, 1, "First");
Second_One_Splitted_PR = Half_Splitter(PR, 1, "Second");

% Splitting PR Data into two 4 Seconds Half
First_Two_Splitted_PR = Half_Splitter(PR, 2, "First");
Second_Two_Splitted_PR = Half_Splitter(PR, 2, "Second");

% Splitting PR Data into two 2 Seconds Half
First_Four_Splitted_PR = Half_Splitter(PR, 4, "First");
Second_Four_Splitted_PR = Half_Splitter(PR, 4, "Second");

% Splitting PR Data into two 1 Seconds Half
First_Eight_Splitted_PR = Half_Splitter(PR, 8, "First");
Second_Eight_Splitted_PR = Half_Splitter(PR, 8, "Second");

% Splitting Data to the Seconds Value Intervals
Splitted_IN = Splitter(IN, Sample_Size, Channel_Division);
Splitted_PR = Splitter(PR, Sample_Size, Channel_Division);

%% Creating SPWVD Images
Network_Folder_is_Full = Check(Network_IN_Folder);
Produce_Network_Data = "y";

if Network_Folder_is_Full

    Message = "Network Data Exists Do you want to Overwrite it [y/N]?";
    Produce_Network_Data = Asker(Message);

end

switch Produce_Network_Data

    case "y"

        Image_Size = [256 256 Channel_Division];
        
        Forger(First_One_Splitted_PR, First_One_PR_Folder, Image_Size) 
        Forger(Second_One_Splitted_PR, Second_One_PR_Folder, Image_Size)

        Forger(First_Two_Splitted_PR, First_Two_PR_Folder, Image_Size) 
        Forger(Second_Two_Splitted_PR, Second_Two_PR_Folder, Image_Size)

        Forger(First_Four_Splitted_PR, First_Four_PR_Folder, Image_Size) 
        Forger(Second_Four_Splitted_PR, Second_Four_PR_Folder, Image_Size)

        Forger(First_Eight_Splitted_PR, First_Eight_PR_Folder, Image_Size) 
        Forger(Second_Eight_Splitted_PR, Second_Eight_PR_Folder, Image_Size)

        Forger(Splitted_IN, Network_IN_Folder, Image_Size)
        Forger(Splitted_PR, Network_PR_Folder, Image_Size)

end

%% The End :)