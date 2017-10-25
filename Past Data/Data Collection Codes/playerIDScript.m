%Script will run PlayerDataCollector to form list of players
%and playerParser to create log of all action per person

playerID2000 = cell(1000,1);
playerID2000(:) = {'empty'};

[playerID2000,playerCount] = PlayerDataCollector(playerID2000,Holdem32000);

playerParser;