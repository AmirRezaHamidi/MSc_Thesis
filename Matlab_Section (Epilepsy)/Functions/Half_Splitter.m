function Half_Splitted_Data = ...
    Half_Splitter(Data, Half_Time, Half, Overlap, options)
    
    arguments

        Data
        Half_Time
        Half
        Overlap
        options.Sample_Size = 8
        options.Depth = 3

    end

Fs = 256;
Half_Data = struct();
Half_Time_Length = Fs * Half_Time * 60;
Sample_Size = options.Sample_Size;
Depth = options.Depth;
Data_Length = size(Data(1).Values, 2);

if Half == "First"
    
    Start = (Data_Length - (2 * Half_Time_Length)) + 1;
    End = Data_Length - Half_Time_Length;
    Slicing = Start:End;

elseif Half == "Second"
    
    Start = (Data_Length - Half_Time_Length) + 1;
    End = Data_Length;
    Slicing = Start: End;

else

    error("You should choose between 'First' and 'Second' for Half parameter")
    
end

for i = 1:length(Data)

    Half_Data(i).Values = Data(i).Values(:, Slicing);

end

Half_Splitted_Data = Splitter(Half_Data, Sample_Size, Depth, Overlap);

end

