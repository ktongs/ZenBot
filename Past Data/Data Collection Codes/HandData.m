%This functions gathers all hands played in time period
function C = HandData(handID,folderStart,folderEnd,fileGroup)

for i = folderStart:folderEnd
    
    handName = sprintf('C:\\Users\\Kingsley\\Dropbox\\Kingsley\\ZenBot\\Past Data\\Extracted\\%s\\%d\\hdb', fileGroup,i);
    A = importHand(handName,1,inf);
    handID{1} = [handID{1};A];
end

C = handID{1};