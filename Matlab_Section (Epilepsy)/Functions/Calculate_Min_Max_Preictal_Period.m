function Min_Max_Preictal_Preiod = ...
    Calculate_Min_Max_Preictal_Period(Subjects_Information ,N)

N_S = length(Subjects_Information);
Max_of_Bests = zeros(1, N_S);

for Subject = 1:N_S

    Best_Preictal_Preiod = zeros(1, 100);
    Index = 1;

    Current_Subject = Subjects_Information(Subject).Subejct_Information;
    N_R = length(Current_Subject);

    for Record = 1:N_R

        Current_Record = Current_Subject(Record);

        if Current_Record.Number_of_Seizures > 0
            
            Best_Preictal_Preiod(Index) = ...
                Calculate_Best_Preictal_Preiod(Current_Record);
            Index = Index + 1;
            
        end
        
    end
    
    Sorted_Preictal_Preiods = sort(Best_Preictal_Preiod, 'descend');
    Max_of_Bests(Subject) = Sorted_Preictal_Preiods(N);
    
end

Min_Max_Preictal_Preiod = min(Max_of_Bests);

end
%% The End :)