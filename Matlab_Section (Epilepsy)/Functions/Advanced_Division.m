function Channel_Aggregate = Advanced_Division(Size, Channel_Division)

if Size < Channel_Division

    error("Channel Division Value Should be Less Than or Equal " ...
          + string(Size))

end
Channel_Aggregate = ones(1 , Channel_Division);
Reminder = mod(Size, Channel_Division);
dividable = Size - Reminder;
quotient = dividable / Channel_Division;

for i = 1:Channel_Division
    
    Channel_Aggregate(i) = quotient;

    if Reminder > 0
        
        Channel_Aggregate(i) = Channel_Aggregate(i) + 1;

    end
    
    Reminder = Reminder - 1;

end

end

