function is_Full = Check(Path)

if exist(Path, "dir")

    if length(dir(Path)) > 2 
    
        is_Full = true;
    
    
    else
    
        is_Full = false;
    
    end

else 

    is_Full = false;

end

end

