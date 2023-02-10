function Forged_Data = Channel_Forger(Data, Channel_Aggregate)

Start = 1;
index = 1;

Forged_Data = ones(length(Channel_Aggregate), size(Data, 2));

for i = Channel_Aggregate
    
    End = i + Start - 1;
    Forged_Data(index ,:) = sum(Data(Start:End, :), 1) / i;
    Start = End + 1;
    index = index + 1;

end

end

