function [Start_Point, End_Point] = Index_Finder(Line)

for index = 1:length(Line)

    if Line(index) == ":"

        Start_Point = index + 2;

        for inner_index = Start_Point:length(Line)

            if Line(inner_index) == " "
        
                End_Point = inner_index - 1;
                break

            end

        end

        break

    end

end

end