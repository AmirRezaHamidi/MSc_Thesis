function [Cropped_Data] = ...
    Seizure_Detector(Data, Recording_Info, Recordings_Length)

Number_of_Seizures = Recording_Info.Number_of_Seizures;
Sampling_Frequency = 256;
Base = 1;

for i = 1:Number_of_Seizures 

    Start = Recording_Info.Seizures_Info(i).Start * Sampling_Frequency;
    Condition_1 = ((Start-Base) >= Recordings_Length);

    if Condition_1

        Cropped_Data = Data(:, Start - Recordings_Length:Start - 1);
        break
    
    else
        
        Base = Recording_Info.Seizures_Info(i).End * Sampling_Frequency;
        
    end

end

end