function Data_Splitted = Splitter(Data, Sample_Size, Depth)

Fs = 256;
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

Sample_Numbers = floor(Overall_Data_Size / (Fs * Sample_Size));
Data_Splitted = ones(Sample_Numbers, Depth, (Fs * Sample_Size));

for i = 0:Sample_Numbers - 1

    Start = (i * (Fs * Sample_Size) + 1);
    End = (i + 1) * (Fs * Sample_Size);
    Data_Splitted(i + 1, :, :) = Overall_Data(:, Start:End);

end

end

%% The End :)