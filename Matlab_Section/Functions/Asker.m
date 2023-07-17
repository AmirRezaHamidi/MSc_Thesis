function Create_Data = Asker(Message)

while true
    
    Create_Data = input(Message, "s");
    
    if isempty(Create_Data)

        Create_Data = false;
        break 
        
    elseif Create_Data == "n"
        
        Create_Data = false;
        break
        
    elseif Create_Data == "y" 

        Create_Data = true;
        break

    else
        
        fprintf('\nYou Should Choose Between y(yes) & n(no) \n')
        
    end
    
end

clc

end

%% the end :)