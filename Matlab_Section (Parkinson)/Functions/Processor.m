function Processor(Input_Folder, Output_Folder, Threshold)

Target_Folder = dir(Input_Folder);
Number_of_Subjects = length(Target_Folder);

for i = 3:Number_of_Subjects
        
    Subject_Number = Target_Folder(i).name(1:2);
    
    Address = Input_Folder + Subject_Number + ".bdf";
    Address = convertStringsToChars(Address);
    
    EEG = pop_biosig(Address, 'channels', (1:32));
    
    Loc = 'EEGLAB\plugins\dipfit\standard_BEM\elec\standard_1005.elc';
    EEG = pop_chanedit(EEG, 'lookup',Loc);
    
    EEG = pop_eegfiltnew(EEG, 'locutoff', 0.5);
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended', 1);
    
    EEG = pop_iclabel(EEG, 'default');
    
    Labels = EEG.etc.ic_classification.ICLabel.classifications;
    Channels_to_Remove = Component_Finder(Labels, Threshold);

    if length(Channels_to_Remove) < 32

        EEG = pop_subcomp(EEG, Channels_to_Remove, 0);
        Data = EEG.data;
        save(Output_Folder + Subject_Number , "Data");

    end
    
end

end

%% The End :)