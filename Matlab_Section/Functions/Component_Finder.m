function Channel_to_Remove = Component_Finder(Labels, Threshold)

Channel_to_Remove = zeros(32, 1);
Count = 0;

for i = 1 : size(Labels, 1)
    
    maximum = max(Labels(i,:));
    
    if maximum == Labels(i, 1)
        
        if Labels(i, 1) >= Threshold
            
            continue
            
        end
        
    end
    
    Count = Count + 1;
    Channel_to_Remove(Count) = i;

end

Channel_to_Remove = Channel_to_Remove(1:Count);

end

%% The End :)