function makePlayers(playerArray,handData)
%This function will fill player data as it reads table data

[M,~] = size(playerArray);
playerList = cell(M,1);

for i = 1:M %init players
    playerList{i,1} = Player;
    playerList{i,1}.Name = playerArray{i,1};
    playerList{i,1}.HandsPlayed = 0; playerList{i,1}.VPIPCount = 0; playerList{i,1}.PFRCount = 0;
    playerList{i,1}.Pre3BetCount = 0; playerList{i,1}.Pre3BetOpportunities = 0;
end

[N,~] = size(handData{1,1});
%Find players in hand
for j = 2:round(N/1000) %%%%%%%%%%%%%%%%%%%%%%
    timeStamp = char(handData{1,1}{j,1});
    players = cell(str2double(cell2mat(handData{1,1}{j,4})),7); %Name, preflop,flop,turn,river,arrayIndex,number of players behind
    for k = 1:str2double(cell2mat(handData{1,1}{j,4}))
        playerVar = handData{1,2}{j,k+2};
        [O,~] = size(playerArray);
        for l = 1:O+1 % find playerIndex in playerArray
            if strcmp(playerVar{1,1},playerArray{l,1})
                
                break
            end
            if l==O+1
                msgbox('could not find player')
            end
        end
        [P,~] = size(playerArray{l,2});
        for m = 2:P+1   % find handIndex in playerhand history
            if strcmp(timeStamp,num2str(playerArray{l,2}{m,2}))
                break
            end
            if m==P+1
                msgbox('could not find timestamp for player')
            end
        end
        
        pos = playerArray{l,2}{m,4};
        
        %grab data
        players(pos,1) = handData{1,2}{j,k+2};
        players(pos,2) = playerArray{l,2}{m,5};%preflop
        players(pos,3) = playerArray{l,2}{m,6};%flop
        players(pos,4) = playerArray{l,2}{m,7};%turn
        players(pos,5) = playerArray{l,2}{m,8};%river
        players(pos,6) = num2cell(l);          %playerIndex
        players(pos,7) = num2cell(playerArray{l,2}{m,3} -playerArray{l,2}{m,4});%number of players behind;
        
    end
    
    %Create counter matrix
    countMat = zeros(str2double(cell2mat(handData{1,1}{j,4})),29); %29 count parameters
    
    %count hands played
    for i = 1:str2double(cell2mat(handData{1,1}{j,4}))
        countMat(i,1) = 1;
    end
    
    tok = cell(str2double(cell2mat(handData{1,1}{j,4})),1);
    for p = 1:str2double(cell2mat(handData{1,1}{j,4})) %each player
        
        if strcmpi(players{p,2}(1),'B')
            players{p,2}= players{p,2}(2:end);
        end
        if ~isempty(players{p,2})
            
            %check for preflop actions
            tok{p} = players{p,2}(1);
            players{p,2}= players{p,2}(2:end);
            
            if strcmp(tok{p},'b')||strcmp(tok{p},'r')
                countMat(p,2) = 1; %VPIPCount
                countMat(p,3) = 1; %PFRCount
                for i = 2:p %Check if there was a raise before
                    if (countMat(i-1,4) > 0)
                        countMat(p,4) = countMat(p,4) + 1; %Pre3BetCount
                        countMat(p,18) = countMat(p,18) + 1; %Pre3BetOpportunities
                        break
                    end
                end
                if players{p,7}<3&& p>2
                    countMat(p,7) = countMat(p,7) + 1;%STCount
                    countMat(p,21) = countMat(p,7) + 1;%STOpportunities
                end
            elseif strcmp(tok{p},'c')
                countMat(p,2) = 1; %VPIPCount
                if players{p,7}>2&&p>2
                    countMat(p,6) = countMat(p,6) + 1;%CCCount
                    countMat(p,20) = countMat(p,20) + 1;%CCOpportunities
                elseif players{p,7}<3&& p>2
                    countMat(p,21) = countMat(p,7) + 1;%STOpportunities
                end
                for i = 2:p %Check for pre3Bet
                    if (countMat(i-1,4) > 0)
                        countMat(p,18) = countMat(p,18) + 1; %Pre3BetOpportunities
                        break
                    end
                end
                if players{p,7}>2&&p>2
                    for i = 2:p
                        if countMat(i,3) > 0
                            countMat(p,6) = countMat(p,6) + 1;%CCCount
                            countMat(p,20) = countMat(p,20) + 1;%CCOpportunities
                            break
                        end
                    end
                elseif players{p,7}<3&& p>2
                    countMat(p,21) = countMat(p,7) + 1;%STOpportunities
                end
            elseif strcmp(tok{p},'f')
                for i = 2:p
                    if (countMat(i-1,4) > 0)
                        for j = 3:i
                            if (countMat(j-1,4) > 0)
                                countMat(p,5) = countMat(p,5) + 1; %PreF3betCount
                                countMat(p,18) = countMat(p,19) + 1; %Pre3BetFaced
                                break
                            end
                        end
                    end
                end
                if players{p,7}>2&&p>2
                    for i = 2:p
                        if countMat(i,3) > 0
                            countMat(p,20) = countMat(p,20) + 1;%CCOpportunities
                            break
                        end
                    end
                elseif players{p,7}<3&& p>2
                    countMat(p,21) = countMat(p,7) + 1;%STOpportunities
                end
            end
        end
    end
    for i = 1:str2double(cell2mat(handData{1,1}{j,4})) %insert data
        playerList{players{i,6},1}.HandsPlayed = playerList{players{i,6},1}.HandsPlayed + countMat(i,1);
        playerList{players{i,6},1}.VPIPCount = playerList{players{i,6},1}.VPIPCount + countMat(i,2);
        playerList{players{i,6},1}.PFRCount = playerList{players{i,6},1}.PFRCount + countMat(i,3);
    end
end
%


end