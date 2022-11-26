function Half_Splitted_Data = Half_Splitter(Data, Half_Time, Half)

Fs = 256;
Half_Data = containers.Map();
Half_Time_Length = Fs * Half_Time * 60;
Keys = Data.keys;
Sample_Size = Half_Time / 2;
Data_Length = size(Data(string(Keys{1})), 2);

if Half == "First"
    Start = (Data_Length - (2 * Half_Time_Length)) + 1;
    End = Data_Length - Half_Time_Length;
    Slicing = Start:End;

elseif Half == "Second"
    
    Start = (Data_Length - Half_Time_Length) + 1;
    End = Data_Length;
    Slicing = Start: End;
    
end

for key = string(Data.keys)
    
    Temp_Data = Data(key);
    Half_Data(key) = Temp_Data(:, Slicing);

end

Half_Splitted_Data = Splitter(Half_Data, Sample_Size, 3);

end

