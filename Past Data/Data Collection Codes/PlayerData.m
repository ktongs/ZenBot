%This function will run through all the players' data files and match with
%playerID list

function Y = PlayerData(playerID,playerCount,folderStart,folderEnd,fileGroup)

playerArray = cell(playerCount,2);
% player(1:playerCount,1) = Player;

for i = 1:playerCount
    playerName = playerID{i,1};
    
    A = array2table(zeros(1,13));
    for j = folderStart:folderEnd
        filename = sprintf('C:\\Users\\Kingsley\\Dropbox\\Kingsley\\ZenBot\\Past Data\\Extracted\\%s\\%d\\pdb\\pdb.%s'...
            ,fileGroup,j,playerName);
        if (exist(filename, 'file')==0)
            
        else
            B = importPlayer(filename,1,inf);
            A = [A;B];
        end
    end
    playerArray{i,1} = playerName;
    playerArray{i,2} = A;
%     player(i,1).name = playerName;
end

Y = playerArray;