function range = holeCardsRangeDistribution(actionRate,distributionData)
%This function will determine the playing range of a player given the VPIP
%or PFR
%This assumes that the player understands the relative strengths of each
%hand
%This will also take "dealt probability" into account

%Import distribution data
%distributionData = importHoldCardDistribution('C:\\Users\\Kingsley\\Dropbox\\Kingsley\\ZenBot\\Platform\\HoleCardsRangeDistributionData.xlsx','Sheet1','A2:F170');
%columns:Rank,Cards,PDF,CDF,%won,%tied
[M,N] = size(distributionData);
idx = M;
for i = 1:M
    if (distributionData{i,4}<=actionRate)
    else
        idx = i;
        break
    end
end

range = distributionData(1:(idx-1),2);

end
    



