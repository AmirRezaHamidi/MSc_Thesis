function [Chosen_Interictals, Chosen_Preictals] = ...
    Choose(Subjects_Information, N)

Min_Max_Preictal_Preiod = ...
    Calculate_Min_Max_Preictal_Period(Subjects_Information ,N);
clc
Message = ['Available Time for ' num2str(N) ' Recording(s):' '\n'...
    num2str(Min_Max_Preictal_Preiod) ' Seconds or ' ...
    num2str(Min_Max_Preictal_Preiod/60) ' Minutes\n'];
fprintf(Message)

Chosen_Interictals = struct();
Chosen_Preictals = struct();

N_S = length(Subjects_Information);
Chosen_Interictal_Index = 1;
Chosen_Preictal_Index = 1;


for Subject = 1:N_S

    Candidate_Interictals = struct();
    Candidate_Preictals = struct();

    Interictal_Index = 1;
    Preictal_Index = 1;

    Curren_Subject = Subjects_Information(Subject).Subejct_Information;
    N_R = length(Curren_Subject);
    
    for Record = 1:N_R

        Current_Record = Curren_Subject(Record);
        Condition_1 = (Current_Record.Number_of_Seizures == 0);
        Condition_2 = (Current_Record.Number_of_Seizures > 0);
        
        if Condition_1
            
            Candidate_Interictals(Interictal_Index).Info = ...
                Current_Record;
            Interictal_Index = Interictal_Index + 1;

        elseif Condition_2

            Preictal_Preiod = Calculate_Best_Preictal_Preiod(Current_Record);
            Condition_3 = Preictal_Preiod > Min_Max_Preictal_Preiod - 1;

            if Condition_3
                
                Candidate_Preictals(Preictal_Index).Info =...
                        Current_Record;
                Preictal_Index = Preictal_Index + 1;

            end

        end

    end

    Candidate_Interictals_Length = length(Candidate_Interictals);
    Candidate_Preictals_Length = length(Candidate_Preictals);

    Random_Iterictal_Candidate = ...
        randsample(1:Candidate_Interictals_Length, N);
    Random_Preictal_Candidate = ...
        randsample(1:Candidate_Preictals_Length, N);

    Subject_Number = Subjects_Information(Subject).Subject_Number;
    
    for index = sort(Random_Iterictal_Candidate)

        Chosen_Interictals(Chosen_Interictal_Index).Subject_Number = ...
            Subject_Number;
        Chosen_Interictals(Chosen_Interictal_Index).Info = ...
            Candidate_Interictals(index).Info;
        Chosen_Interictal_Index = Chosen_Interictal_Index + 1;

    end

    for index = sort(Random_Preictal_Candidate)
        Chosen_Preictals(Chosen_Preictal_Index).Subject_Number = ...
            Subject_Number;
        Chosen_Preictals(Chosen_Preictal_Index).Info = ...
            Candidate_Preictals(index).Info;
        Chosen_Preictal_Index = Chosen_Preictal_Index + 1;
    end

end

end

%% The End :)