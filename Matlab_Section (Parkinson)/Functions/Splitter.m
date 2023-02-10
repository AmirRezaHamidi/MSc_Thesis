function Splitted_Data = Splitter(Data, Sample_Size, Depth, options)

arguments
    
    Data 
    Sample_Size {mustBePositive}
    Depth
    options.SamplingFrequency = 512;
    options.Overlap = 0;

end

Splitted_Data = struct();
Forged_Data = struct();

Overlap = options.Overlap;
Sampling_Frequency = options.SamplingFrequency;

if Overlap >= Sample_Size

    error("Overlap should smaller than the Sample Size")

end


for i = 1:length(Data)
    
    First_Size = size(Data(i).Values, 1);
    Channel_Aggregate = Advanced_Division(First_Size, Depth);
    Forged_Data(i).Values = Channel_Forger(Data(i).Values, Channel_Aggregate);

end

for i = 1:length(Forged_Data)
    
    Current_Data_Size = size(Forged_Data(i).Values, 2);
    Shift = Sample_Size - Overlap;

    Number_of_Starts = (Current_Data_Size / Sampling_Frequency) - Overlap;
    Number_of_Samples = floor(Number_of_Starts / Shift) - 1;

    Current_Splitted = ones(Number_of_Samples, Depth,...
                        (Sampling_Frequency * Sample_Size));
    
    for j = 0:Number_of_Samples
    
        Start = j * Shift * Sampling_Frequency + 1;
        End = Start + Sample_Size * Sampling_Frequency - 1;
        Current_Splitted(j + 1, :, :) = Forged_Data(i).Values(:, Start:End);
    
    end
    
    Splitted_Data(i).Name = Data(i).Name;
    Splitted_Data(i).Values = Current_Splitted;
   
end

end

%% The End :)