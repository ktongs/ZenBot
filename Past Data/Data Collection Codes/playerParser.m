%This script will run through all the hands played and parse through the
%actions of each player

player(1:playerCount,1) = Player;
for i = 1:playerCount
    player(i,1).name = playerArray{i,1}
end


A = Holdem32000{1};
B = Holdem32000{2};
C = A{2,1};
timeStamp = str2double(C{1});

I = find(B{:,1} == timeStamp);
xOfPlayers = B{I,2};
grabbedPlayers = cell(xOfPlayers,1)



for i = 1:xOfPlayers
    B{I,2+i}
end