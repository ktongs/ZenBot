%This function finds all the roster data in time period
%Gathers roster into an array
function C = RosterData(handID,folderStart,folderEnd,fileGroup)

for i = folderStart:folderEnd
    
    rosterName = sprintf('C:\\Users\\Kingsley\\Dropbox\\Kingsley\\ZenBot\\Past Data\\Extracted\\%s\\%d\\hroster', fileGroup,i);
    A = importRoster(rosterName,1,inf);
    handID{2} = [handID{2};A];

end

C = handID{2};