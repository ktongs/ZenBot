function range = StandardPreflop(pos,action)
%This function will find the "cheat play" style of play and determine
%relative looseness and agressiveness given early middle or late pos
%This will be assumed for all players until further information
%Action will only consider call, bet or raise
distributionData = importHoldCardDistribution('C:\\Users\\Kingsley\\Dropbox\\Kingsley\\ZenBot\\Platform\\HoleCardsRangeDistributionData.xlsx','Sheet1','A2:F170');

if (strcmpi(action,'c')||strcmpi(action,'k'))
    
    if strcmpi(pos,'early')
        idx = 43;
    elseif strcmpi(pos,'middle')
        idx = 50;
    elseif strcmpi(pos,'late')
        idx = 120;
    else
        h = msgbox('Invalid pos');
    end
    
elseif(strcmpi(action,'r')||strcmpi(action,'b'))
    idx = 28;
else
    h = msgbox('Invalid action');
end

actionRate = distributionData{idx-1,4};
range = holeCardsRangeDistribution(actionRate,distributionData);

end