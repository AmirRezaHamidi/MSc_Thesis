function Make_Sure(varargin)


for Folder = string(varargin)

    if ~exist(string(Folder), "dir")

        mkdir(Folder)

    end

end
end