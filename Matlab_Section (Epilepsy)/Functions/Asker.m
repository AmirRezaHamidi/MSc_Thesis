function Create_Data = Asker(Message)

while true
    
    Create_Data = input(Message, "s");
    
    if isempty(Create_Data)

        Create_Data = "n";
        break 
        
    elseif Create_Data == "n"
        
        break
        
    elseif Create_Data == "y" 
        
        break

    else
        
        fprintf('\nYou Should Choose Between y(yes) & n(no) \n')
        
    end
    
end

clc

end
%% the end :)