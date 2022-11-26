function Best_Preictal_Preiod = Calculate_Best_Preictal_Preiod(Record)

Baes = 0;
Si_N = Record.Number_of_Seizures;
Preictal_Preiods = zeros(1, Si_N);

for Seizure = 1:Si_N

    Current_Seizure = Record.Seizures_Info(Seizure);
    Preictal_Preiods(Seizure) = Current_Seizure.Start - Baes;
    Baes = Current_Seizure.End;

end

Best_Preictal_Preiod = max(Preictal_Preiods);

end

