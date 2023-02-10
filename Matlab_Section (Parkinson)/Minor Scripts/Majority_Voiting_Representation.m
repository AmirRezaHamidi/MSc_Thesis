Error_Probablity = 0.3;
N = 50;
Mode_of_Plot = "E";

Event_Occurance = 1 : 2 : N;
Majority_Voting_Probablities = zeros(length(Event_Occurance), 1);
index = 0;

for i = 1 : 2 : N
    
    index = index + 1;
    Total_Probablity = 0;
    
    for j = round(i/2) : i
        

        Wrong_Probablity = Error_Probablity ^ j;
        Right_Probablity = (1 - Error_Probablity) ^ (i - j);
        
        Event_Probablity = Wrong_Probablity * Right_Probablity;
        Event_Combination = nchoosek(i, j);

        Current_Probablity = Event_Combination * Event_Probablity;
        Total_Probablity =  Total_Probablity + Current_Probablity;
    
    end

    Majority_Voting_Probablities(index) = (Total_Probablity) * 100;

end

y_label = 'Error';

if Mode_of_Plot == "A"

    Majority_Voting_Probablities = 100 - Majority_Voting_Probablities;
    y_label = "Accuracy";

end 

text_to_show = num2str(round(Majority_Voting_Probablities, 2)) + "%";
bar(Event_Occurance, Majority_Voting_Probablities)
text(Event_Occurance, Majority_Voting_Probablities, text_to_show,...
    'vert','bottom','horiz','center');

xlabel('Number of Samples to take vote')
ylabel(y_label)
box off
%% The End :)