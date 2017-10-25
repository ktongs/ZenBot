%This function will run through the roster and output a list of all the
%different players in time period
function [Y,playerCount] = PlayerDataCollector(playerID,handID)

playerCount = 0;
C = handID{2};
grabbedPlayer = '';

for i = 2:height(C)
    totalPlayers = C{i,2};
    for j = 1:totalPlayers
        D = C{i,j+2};
        grabbedPlayer = D{1};
        
        foo = 0; k = 1;
        
        while (foo==0 &&k <= playerCount+1)
            if (strcmp(grabbedPlayer,playerID{k,1}))
                foo = 1;
            end
            k = k+1;
        end
        if (foo==0)
            playerID = createNewPlayer(grabbedPlayer,playerID,playerCount);
            playerCount = playerCount + 1;
        end
    end
end

Y = playerID;
