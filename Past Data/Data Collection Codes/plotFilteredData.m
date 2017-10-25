function plotFilteredData(finalFilteredShowdownCell)
%This function will plot the preflop actions for each set of hole cards

actionCell = finalFilteredShowdownCell(:,4);
holeCardsCell = finalFilteredShowdownCell(:,3);
playersBehindCell = finalFilteredShowdownCell(:,2);
[M,N] = size(finalFilteredShowdownCell);

%Plot set up (late,middle,early)
for i = 1:M
if (playersBehindCell{i} >=0||playersBehindCell{i} <=2) %Late position
    
end
end

    
    