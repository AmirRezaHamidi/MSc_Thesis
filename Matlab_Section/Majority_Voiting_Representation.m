Error_Probablity = 0.2;
N = 20;

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

text_to_show = num2str(Majority_Voting_Probablities) + "%";
bar(Event_Occurance, Majority_Voting_Probablities)
text(Event_Occurance, Majority_Voting_Probablities, text_to_show,...
    'vert','bottom','horiz','center');

xlabel('Number of Samples to take vote')
ylabel('Accuracy %')
box off
%% The End :)