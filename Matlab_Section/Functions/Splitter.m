function Data_Splitted = Splitter(Data, Sample_Size, Channel_Division)

Fs = 256;
Overall_Data_Size = 0;
Forged_Data = containers.Map();

for key = string(Data.keys)

    First_Size = size(Data(key), 1);
    Channel_Aggregate = Advanced_Division(First_Size, Channel_Division);

    Second_Size = size(Data(key), 2);
    Overall_Data_Size = Overall_Data_Size + Second_Size;
    Forged_Data(key) = Channel_Forger(Data(key), Channel_Aggregate);

end

Overall_Data = zeros(Channel_Division , Overall_Data_Size);
Start = 1;

for key = string(Forged_Data.keys)

    End = size(Forged_Data(key), 2) + Start - 1;
    Overall_Data(:, Start:End) = Forged_Data(key);
    Start  = End + 1;

end

Sample_Numbers = floor(Overall_Data_Size / (Fs * Sample_Size));
Data_Splitted = ones(Sample_Numbers, Channel_Division, (Fs * Sample_Size));

for i = 0:Sample_Numbers - 1

    Start = (i * (Fs * Sample_Size) + 1);
    End = (i + 1) * (Fs * Sample_Size);
    Data_Splitted(i + 1, :, :) = Overall_Data(:, Start:End);

end

end
%% The End :)