%% Resovling Environment
addpath("Functions")
Resolve_Environment
close all; clear; clc

%% Processing the Raw Data
Processed_Directory = fullfile("Processed_Data");
Processed_Directory_is_Full = Check(Processed_Directory);
Produce_Processed_Data = true;

if Processed_Directory_is_Full

    Message = "Processed Data Exists, Do you want to Overwrite it [y/N]?";
    Produce_Processed_Data = Asker(Message);

end

clear Processed_Directory Processed_Directory_is_Full Message

if Produce_Processed_Data

    % Raw Data Path
    RD_HC = fullfile("Raw_Data\HC\");
    RD_PD = fullfile("Raw_Data\PD\");

    % Processed Data Path
    PD_HC = fullfile("Processed_Data\HC\");
    PD_PD = fullfile("Processed_Data\PD\");
    Make_Sure(PD_HC, PD_PD)

    % Processing and Saving the Data
    Threshold = 0.8;
    Processor(RD_HC, PD_HC, Threshold)
    Processor(RD_PD, PD_PD, Threshold)

    clear RD_HC RD_PD PD_HC PD_PD Produce_Processed_Data

end

%% Reading and Splitting Processed Data
addpath("Functions")
close all; clear; clc

% Processed Data Path
PD_HC = fullfile("Processed_Data\HC\");
PD_PD = fullfile("Processed_Data\PD\");

% Reading Data
Processed_HC = Reader(PD_HC);
Processed_PD = Reader(PD_PD);

clear PD_HC PD_PD

% Splitting Data Properties
Sample_Size = 2; Depth = 3; Overlap = 0;

% Splitting Data
Splitted_HC = Splitter(Processed_HC, Sample_Size, Depth, Overlap=Overlap);
Splitted_PD = Splitter(Processed_PD, Sample_Size, Depth, Overlap=Overlap);

clear Sample_Size Depth Overlap Processed_HC Processed_PD
%% Creating Forged Data

Network_Directory = fullfile("Network_Data\");
Network_Directory_is_Full = Check(Network_Directory);
Produce_Network_Data = true;

if Network_Directory_is_Full

    Message = "Network Data Exists, Do you want to Overwrite it [y/N]?";
    Produce_Network_Data = Asker(Message);

end

clear Network_Directory_is_Full Message

if Produce_Network_Data

    Image_Size = [256 256 Depth];
    Make_Sure(Network_Directory)

    RGB_SPWVD_Maker(Splitted_HC, Network_Directory, "HC", Image_Size);
    RGB_SPWVD_Maker(Splitted_PD, Network_Directory, "PD", Image_Size);

    clear Image_Size Produce_Network_Data Image_Size Network_Directory

end

%% The End :)