function Time_in_Day = Clock2Day(Time_in_Clock)

Splited_Time = split(Time_in_Clock, ":");
Time_in_Day = str2double(Splited_Time{1}) * 3600 + ...
              str2double(Splited_Time{2}) * 60 + ...
              str2double(Splited_Time{3});
end