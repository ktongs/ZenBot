function [num, outs,results] = getMyOuts (heroCardNum, villainCardNum, flop, turn, river,Hands) 
%This function will determine the outs given a play

% Get hole cards
PlayersCards = zeros(2,2);

PlayersCards(1,:) = heroCardNum;
PlayersCards(2,:) = villainCardNum;

% Get the board
FlopTurnRiver = [flop turn river];

%Get the best hand and find out who is ahead
% [handRanking handResults] = HandResults(FlopTurnRiver,PlayersCards);
if turn==56
    turnOrRiver = 'turn';
elseif river==57
    turnOrRiver = 'river';
end

[num,outs,results] = numOfOuts(FlopTurnRiver,PlayersCards,turnOrRiver);


%Determine the outs needed for the player
function [count,out,results] = numOfOuts(commonCards,PlayersCards,turnOrRiver)
    count = 0;
    out = zeros(52,1);
    for kk = 1:52
        if (kk~=commonCards)
            if (kk~=PlayersCards(2,:))
                if (kk~=PlayersCards(1,:))
                    if (strcmpi(turnOrRiver,'turn'))
                        x = 4;
                    elseif (strcmpi(turnOrRiver,'river'))
                        x = 5;
                    else
                        msgbox('turn or river?')
                    end
                    commonCards(x) = kk;

                    [drawRanking,results] = HandResults(commonCards,PlayersCards);

                    if (drawRanking(1) == 1)
                        count = count+1;
                        out(count) = kk;
                    end
                end
            end
        end
    end
end

function [ranking,villainResults] = HandResults(commonCards,PlayersCards)
    % Compute each player's best hand
    result = zeros(2,6);
    for jjj = 1:2
        if ~isempty(find(PlayersCards(jjj,:) == 0,1))
            result(jjj,:) = [(10 + 1) 0 0 0 0 0];
        else
            result(jjj,:) = BestHand([PlayersCards(jjj,:) commonCards]);
        end
        
        for ii = 2:6
            result(jjj,ii) = 4.*(floor((result(jjj,ii)-1)./4)) + 1;
        end
    end
        
    % Figure out who won the hand
    %This is flawed because it doesn't recognize ties
    results = sum(result .* repmat(logspace(2,-8,6),2,1),2);
    villainResults = results(2,1);
%     
%     if (result(1,1) == result(2,1))
%         %check for high card
%         highCard1 = floor((result(1,2)+1)./4);
%         highCard2 = floor((result(2,2)+1)./4);
%     
%     end
        if results(1) == results(2)
            ranking = [1;1];
        else
            [~,ranking] = sort(results);
        end
end

%Find best hand given 7 cards
function result = BestHand(cards)   
    
    % Sort cards
    cards = sort(cards);
    
    % Create hand matrix
    handMatrix = zeros(4,13);
    for idx = 1:length(cards)
        if cards(idx) < 53;
            handMatrix(cards(idx)) = 1;
        end
    end
    
    % Get some info for the rest of the checks
    NumCardsPerSuit = sum(handMatrix,2);
    NumEachCard = sum(handMatrix,1);
    ind4 = find(NumEachCard >= 4,1,'first');
    ind3 = find(NumEachCard >= 3,2,'first');
    ind2 = find(NumEachCard >= 2,2,'first');
    indFl = find(NumCardsPerSuit >= 5,1,'first');
    
    % Determine best hand from given cards 
    result = zeros(1,6);
    for jjdx = 1:size(Hands,1)
        switch Hands{jjdx,3}
            case 'RF'
                % Check for Royal Flush
                suitsRF = (sum(handMatrix(:,1:5),2) == 5);
                suitRF = find(suitsRF,1,'first');
                if ~isempty(suitRF)
                    % Found Royal Flush
                    result(1) = jjdx;
                    result(2:6) = suitRF + 4 * (0:4);
                    return;
                end
            case 'SF'
                % Check for Straight Flush
                mat = [handMatrix handMatrix(:,1)];
                for suitStFl = 1:4
                    startInd = strfind(mat(suitStFl,:),ones(1,5));
                    if ~isempty(startInd)
                        % Found Straight Flush
                        result(1) = jjdx;
                        result(2:6) = suitStFl + 4 * (startInd(1) + (-1:3));
                        if (startInd(1) == (13 - 3))
                            result(6) = result(6) - DeckSize;
                        end
                        return;
                    end
                end
            case '4K'
                % Check for Four of a Kind
                if ~isempty(ind4)
                    % Found Four of a Kind
                    result(1) = jjdx;
                    suits4 = find(handMatrix(:,ind4(1)),4,'first');
                    result(2:5) = (4 * (ind4(1) - 1) + suits4);
                    hand = setdiff(cards,result(2:5));
                    result(6) = hand(1);
                    return;
                end
            case 'FH'
                % Check for Full House
                if ~isempty(ind3)
                    ind23 = setdiff(ind2,ind3(1));
                    if ~isempty(ind23)
                        % Found Full House
                        result(1) = jjdx;
                        suits3 = find(handMatrix(:,ind3(1)),3,'first');
                        suits2 = find(handMatrix(:,ind23(1)),2,'first');
                        result(2:4) = (4 * (ind3(1) - 1) + suits3);
                        result(5:6) = (4 * (ind23(1) - 1) + suits2);
                        return;
                    end
                end
            case 'F'
                % Check for Flush
                if ~isempty(indFl)
                    % Found Flush
                    result(1) = jjdx;
                    cardNumFl = find(handMatrix(indFl(1),:),5,'first');
                    result(2:6) = (4 * (cardNumFl - 1) + indFl(1));
                    return;
                end
            case 'S'
                % Check for Straight
                startInd = strfind([NumEachCard NumEachCard(1)] > 0,ones(1,5));
                if ~isempty(startInd)
                    % Found Straight
                    result(1) = jjdx;
                    if (startInd(1) == (13 - 3))
                        for idx = 1:4
                            result(idx + 1) = 4 * (startInd(1) + idx - 2) + find(handMatrix(:,startInd(1) + idx - 1),1,'first');
                        end
                        result(6) = find(handMatrix(:,1),1,'first');
                    else
                        for idx = 1:5
                            result(idx + 1) = 4 * (startInd(1) + idx - 2) + find(handMatrix(:,startInd(1) + idx - 1),1,'first');
                        end
                    end
                    return;
                end
            case '3K'
                % Check for Three of a Kind
                if ~isempty(ind3)
                    % Found Three of a Kind
                    result(1) = jjdx;
                    suits3 = find(handMatrix(:,ind3(1)),3,'first');
                    result(2:4) = (4 * (ind3(1) - 1) + suits3);
                    hand = setdiff(cards,result(2:4));
                    result(5:6) = hand(1:2);
                    return;
                end
            case '2P'
                % Check for Two Pair
                if (length(ind2) >= 2)
                    % Found Two Pair
                    result(1) = jjdx;
                    suits2a = find(handMatrix(:,ind2(1)),2,'first');
                    suits2b = find(handMatrix(:,ind2(2)),2,'first');
                    result(2:3) = (4 * (ind2(1) - 1) + suits2a);
                    result(4:5) = (4 * (ind2(2) - 1) + suits2b);
                    hand = setdiff(cards,result(2:5));
                    result(6) = hand(1);
                    return;
                end
            case '1P'
                % Check for One Pair
                if ~isempty(ind2)
                    % Found One Pair
                    result(1) = jjdx;
                    suits2 = find(handMatrix(:,ind2(1)),2,'first');
                    result(2:3) = (4 * (ind2(1) - 1) + suits2);
                    hand = setdiff(cards,result(2:3));
                    result(4:6) = hand(1:3);
                    return;
                end
            case 'H'
                % High Card
                result(1) = jjdx;
                result(2:6) = cards(1:5);
                return;
            otherwise
              error('Hand type not supported');
        end
    end
end

% function cards = GetCards(text,num)
%     cardStr = text;
%     cards = zeros(1,num);
%     for idx = 1:num
%         [c cardStr] = strtok(cardStr,[',',' ']); %#ok
%         cardStr = cardStr(2:end);
%         cards(idx) = ParseUserCard(c);
%     end
% end

% function holeCards = ParseHoleCards(text,NumHoleCards)
%     cardStr = text;
%     holeCards = zeros(1,NumHoleCards);
%     if ~strcmpi(cardStr,'X')
%         for idx = 1:NumHoleCards
%             [c cardStr] = strtok(cardStr,[',',' ']); %#ok
%             cardStr = cardStr(2:end);
%             holeCards(idx) = ParseHoleCard(c);
%         end
%     end
% end

% function holeCard = ParseHoleCard(cardStr)
%     if strcmpi(cardStr,'X')
%         holeCard = 0;
%     else
%         holeCard = GetCard(cardStr);
%         if (holeCard == 0)
%             holeCard = ParseHoleCard(ProcessUserInput(['Card ''' cardStr ''' was invalid. Try entering the card again: ']));
%         else
%             index = (Deck == holeCard);
%             if (sum(index) ~= 1)
%                 holeCard = ParseHoleCard(ProcessUserInput(['Card ''' cardStr ''' has already been drawn. Try entering the card again: ']));
%             else
%                 Deck(index) = [];
%             end
%         end
%     end
% end

% Takes a string like 'AH' and converts it to a card
% function card = ParseUserCard(cardStr)
%     card = GetCard(cardStr);
% %     if (card == 0)
% %         card = ParseUserCard(ProcessUserInput(['Card ''' cardStr ''' was invalid. Try entering the card again: ']));
% %     else
% %         index = (Deck == card);
% %         if (sum(index) ~= 1)
% %             card = ParseUserCard(ProcessUserInput(['Card ''' cardStr ''' has already been drawn. Try entering the card again: ']));
% %         else
% %             Deck(index) = [];
% %         end
% %     end
% end

% Gets the card associated with a card string
% function card = GetCard(cardStr)
%     if isempty(cardStr)
%         card = 0;
%     elseif strcmpi(cardStr,'x')
%         card = 53;
%     else
%         cardNum = find(strcmpi(Cards,cardStr(1:(end-1))));
%         suit = find(strcmpi(Suits,cardStr(end)));
%         if ((length(cardNum) ~= 1) || (length(suit) ~= 1))
%             card = 0;
%         else
%             card = suit + (cardNum - 1) * 4;
%         end
%     end
% end
% 
% function userStr = ProcessUserInput(text)
%     userStr = input(sprintf('\n%s',text),'s');
%     if strcmpi(userStr,'Help')
%         DisplayHelp;
%         userStr = ProcessUserInput(text);
%     elseif strcmpi(userStr,'Cards')
%         DisplayCards;
%         userStr = ProcessUserInput(text);
%     elseif strcmpi(userStr,'Suits')
%         DisplaySuits;
%         userStr = ProcessUserInput(text);
%     elseif strcmpi(userStr,'Hands')
%         DisplayHands;
%         userStr = ProcessUserInput(text);
%     elseif strcmpi(userStr,'Exit')
%         error(ExitMessageStr);
%     end
% end
end