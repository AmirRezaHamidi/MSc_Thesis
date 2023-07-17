function Delete_Path(Directory)

Directory_Content = dir(Directory);
Number_of_Files = length(Directory_Content);

for i=3:Number_of_Files
        
    to_del = [Directory_Content(i).folder  '\' Directory_Content(i).name];

    if Directory_Content(i).isdir == 0

        delete(to_del)

    else 
    
        rmdir(to_del)
    end
    
end

end

