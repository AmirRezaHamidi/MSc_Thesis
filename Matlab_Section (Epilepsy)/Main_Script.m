%% Resovling Environment
addpath("Functions")
Resolve_Environment
close all; clear; clc
h
%% Loading and Choosing the Raw Data Information
% Loading the Data
load("Dataset\Subjects_Information.mat")

% Choosing N Proper Data from the Raw Dataset
N = 2;
[IN_Batch, PR_Batch] = Choose(Subjects_Information, N);

% clear Subjects_Information N
%% Pre_Process the Raw Data

Processed_Folder = fullfile("Processed_Data");
Process_Folder_is_Full = Check(Processed_Folder);
Produce_Process_Data = "y";

if Process_Folder_is_Full

    Message = "Processed Data Exists Do you want to Overwrite it [y/N]?";
    Produce_Process_Data = Asker(Message);

end

clear Process_Folder_is_Full Message Processed_Folder

if Produce_Process_Data == "y"

    PF_IN = fullfile("Processed_Data\IN\");
    Make_Sure(PF_IN)
    Delete_Path(PF_IN)
    Processor(IN_Batch, PF_IN)

    PF_PR = fullfile("Processed_Data\PR\");
    Make_Sure(PF_PR)
    Delete_Path(PF_PR)
    Processor(PR_Batch, PF_PR)

end

clear IN_Batch PR_Batch Produce_Process_Data
%% Reading Processed Data
% Processed Data Path
PF_IN = fullfile("Processed_Data\IN\");
PF_PR = fullfile("Processed_Data\PR\");

Processed_IN = Reader(PF_IN);
Processed_PR = Reader(PF_PR);

clear PF_IN PF_PR
%% Splitting Data
% Splitted Data Properties
Sample_Size = 8; Depth = 3;

% Splitting PR Data into two, 1 Minutes Half
Splitted_PR_One_First = ...
    Half_Splitter(Processed_PR, 1, "First", 7);
Splitted_PR_One_Second = ...
    Half_Splitter(Processed_PR, 1, "Second", 7);

% Splitting PR Data into two, 2 Minutes Half
Splitted_PR_Two_First = ...
    Half_Splitter(Processed_PR, 2, "First", 6);
Splitted_PR_Two_Second = ...
    Half_Splitter(Processed_PR, 2, "Second", 6);

% Splitting PR Data into two, 4 Minutes Half
Splitted_PR_Four_First = ...
    Half_Splitter(Processed_PR, 4, "First", 4);
Splitted_PR_Four_Second = ...
    Half_Splitter(Processed_PR, 4, "Second", 4);

% Splitting PR Data into two, 8 Minutes Half
Splitted_PR_Eight_First = ...
    Half_Splitter(Processed_PR, 8, "First", 0);
Splitted_PR_Eight_Second = ...
    Half_Splitter(Processed_PR, 8, "Second", 0);

% Splitting Data to the 8 Seconds Value Intervals
Splitted_IN = Splitter(Processed_IN, Sample_Size, Depth);
Splitted_PR = Splitter(Processed_PR, Sample_Size, Depth);

%% Creating SPWVD Images

Network_Folder = fullfile("Network_Data");
Network_Folder_is_Full = Check(Network_Folder);

Produce_Network_Data = "y";

if Network_Folder_is_Full

    Message = "Network Data Exists Do you want to Overwrite it [y/N]?";
    Produce_Network_Data = Asker(Message);

end

if Produce_Network_Data == "y"

    Image_Size = [256 256 Depth];

    %     %%%%%%%%%% 1 Minutes Pridction Data %%%%%%%%%%
    %     NF_PR_One_First = ...
    %         fullfile("Network_Data\Prediction\1Minutes\First_Half\");
    %     NF_PR_One_Second = ...
    %         fullfile("Network_Data\Prediction\1Minutes\Second_Half\");
    %     Make_Sure(NF_PR_One_First ,NF_PR_One_Second)
    %
    %     SPWVD_Forger(Splitted_PR_One_First, NF_PR_One_First, Image_Size)
    %     SPWVD_Forger(Splitted_PR_One_Second, NF_PR_One_Second, Image_Size)
    %
    %     clear NF_PR_One_First NF_PR_One_Second
    %     %%%%%%%%%% 1 Minutes Pridction Data %%%%%%%%%%
    %
    %     %%%%%%%%%% 2 Minutes Pridction Data %%%%%%%%%%
    %     NF_PR_Two_First = ...
    %         fullfile("Network_Data\Prediction\2Minutes\First_Half\");
    %     NF_PR_Two_Second = ...
    %         fullfile("Network_Data\Prediction\2Minutes\Second_Half\");
    %     Make_Sure(NF_PR_Two_First ,NF_PR_Two_Second)
    %
    %     SPWVD_Forger(Splitted_PR_Two_First, NF_PR_Two_First, Image_Size)
    %     SPWVD_Forger(Splitted_PR_Two_Second, NF_PR_Two_Second, Image_Size)
    %
    %     clear NF_PR_Two_First NF_PR_Two_Second
    %     %%%%%%%%%% 2 Minutes Pridction Data %%%%%%%%%%
    %
    %     %%%%%%%%%% 4 Minutes Pridction Data %%%%%%%%%%
    %     NF_PR_Four_First = ...
    %         fullfile("Network_Data\Prediction\4Minutes\First_Half\");
    %     NF_PR_Four_Second = ...
    %         fullfile("Network_Data\Prediction\4Minutes\Second_Half\");
    %     Make_Sure(NF_PR_Four_First ,NF_PR_Four_Second)
    %
    %     SPWVD_Forger(Splitted_PR_Four_First, NF_PR_Four_First, Image_Size)
    %     SPWVD_Forger(Splitted_PR_Four_Second, NF_PR_Four_Second, Image_Size)
    %
    %     clear NF_PR_Four_First NF_PR_Four_Second
    %     %%%%%%%%%% 4 Minutes Pridction Data %%%%%%%%%%

    %%%%%%%%%% 8 Minutes Pridiction Data %%%%%%%%%%
    NF_PR_Eight_First = ...
        fullfile("Network_Data\Prediction\8Minutes\First_Half\");
    NF_PR_Eight_Second = ...
        fullfile("Network_Data\Prediction\8Minutes\Second_Half\");
    Make_Sure(NF_PR_Eight_First ,NF_PR_Eight_Second)

    SPWVD_Forger(Splitted_PR_Eight_First, NF_PR_Eight_First, Image_Size)
%     SPWVD_Forger(Splitted_PR_Eight_Second, NF_PR_Eight_Second, Image_Size)

    clear NF_PR_Eight_First NF_PR_Eight_Second
    %%%%%%%%%% 8 Minutes Pridiction Data %%%%%%%%%%

    %     %%%%%%%% Detection Data %%%%%%%%%%
    %     NF_IN = fullfile("Network_Data\Detection\SubjectWise\IN\");
    %     NF_PR = fullfile("Network_Data\Detection\SubjectWise\PR\");
    %     Make_Sure(NF_IN ,NF_PR)
    %
    %     SPWVD_Forger(Splitted_IN, NF_IN, Image_Size)
    %     SPWVD_Forger(Splitted_PR, NF_PR, Image_Size)
    %
    %     clear NF_IN NF_PR
    %     %%%%%%%%% Detection Data %%%%%%%%%%

end

%% The End :)