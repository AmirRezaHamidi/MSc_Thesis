function Data_Splitted = Splitter(Data, Sample_Size, Depth, varargin)

if numel(varargin) == 0

    Overlap = 0;

elseif numel(varargin) == 1

    Overlap = varargin{1};

end

if Overlap > Sample_Size

    error("Overlap should smaller than the Sample Size")

end

Sampling_Frequency = 256;
Overall_Data_Size = 0;
Forged_Data = struct();

for i = 1:length(Data)
    
    First_Size = size(Data(i).Values, 1);
    Channel_Aggregate = Advanced_Division(First_Size, Depth);

    Second_Size = size(Data(i).Values, 2);
    Overall_Data_Size = Overall_Data_Size + Second_Size;
    Forged_Data(i).Values = Channel_Forger(Data(i).Values, Channel_Aggregate);

end

Overall_Data = zeros(Depth , Overall_Data_Size);
Start = 1;

for i = 1:length(Forged_Data)
    
    End = size(Forged_Data(i).Values, 2) + Start -1;
    Overall_Data(:, Start:End) = Forged_Data(i).Values;
    Start  = End + 1;
    
end

Shift = Sample_Size - Overlap;
Number_of_Starts = (Overall_Data_Size / Sampling_Frequency) - Overlap;
Number_of_Samples = floor(Number_of_Starts / Shift) - 1;
Data_Splitted = ones(Number_of_Samples, Depth,...
                    (Sampling_Frequency * Sample_Size));

for i = 0:Number_of_Samples

    Start = i * Shift * Sampling_Frequency + 1;
    End = Start + Sample_Size * Sampling_Frequency - 1;
    Data_Splitted(i + 1, :, :) = Overall_Data(:, Start:End);

end

end

%% The End :)