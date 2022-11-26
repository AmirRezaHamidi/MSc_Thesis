function Processor(Input_Batch, Output_Folder)

Mintues = 16;
Sampling_Frequency = 256;
Recordings_Length = Mintues * 60 * Sampling_Frequency;

for i = Input_Batch
    
    Recording_Info = i.Info;
    Path = Recording_Info.Path;
    Number_of_Seizures = Recording_Info.Number_of_Seizures;

    Condition_1 = Number_of_Seizures == 0;
    Condition_2 = Number_of_Seizures > 0;
    
    if Condition_1

        EEG = pop_biosig(Path, 'channels', (1:22));
        Data = EEG.data * 1e4;
        Cropped_Data = Data(:,1:Recordings_Length);
        save(Output_Folder + (Path(24:31)) , "Cropped_Data");

    elseif Condition_2
        
        EEG = pop_biosig(Path, 'channels', (1:22));
        Data = EEG.data * 1e4;
        Cropped_Data = ...
            Seizure_Detector(Data, Recording_Info, Recordings_Length);
        save(Output_Folder + (Path(24:31)) , "Cropped_Data");
        
    end

end

clc

end

%% The End :)