%This script imports all data and concatenate into 1 matrix

Holdem32000{1} = array2table(zeros(1,13));
Holdem32000{2} = array2table(zeros(1,12));

fileGroup = 'holdem3';

folderStart = 200001;
folderEnd = 200012;
    
Holdem32000{1} = HandData(Holdem32000,folderStart,folderEnd,fileGroup);
Holdem32000{2} = RosterData(Holdem32000,folderStart,folderEnd,fileGroup);

%Load or mine player data (playerIDScript)

% Mining Code
% playerArray2000 = cell(playerCount,2);
% playerArray2000 = PlayerData(playerID2000,playerCount,folderStart,folderEnd,fileGroup);


