
function GameStats(varargin)
%This function will set up the constants of the math in no-limit texas holdem

%
% Define number of cards added at each step
%
NumHoleCards = 2;
NumFlopCards = 3;
NumTurnCards = 1;
NumRiverCards = 1;

Cards = {'A','K','Q','J','T','9','8','7','6','5','4','3','2'};

Suits = {'S','D','H','C'};

Hands = {'Royal Flush','AKQJ10 of same suit','RF';
    'Straight Flush','5 consecutive cards of same suit','SF';
    'Four of a Kind','4 cards of same number','4K';
    'Full House','3 cards of one number and 2 cards of another number','FH';
    'Flush','5 cards of 1 suit','F';
    'Straight','5 consecutive cards (suit doesn''t matter)','S';
    'Three of a Kind','3 cards of same number','3K';
    'Two Pair','2 cards each of 2 different numbers','2P';
    'One Pair','2 cards of same number','1P';
    'High Card','Highest card in hand','H';
    };

NumCards = length(Cards);
NumSuits = length(Suits);
DeckSize = NumCards * NumSuits;
NumHands = size(Hands,1);

NumPlayers = 2;

% Initialize deck
Deck = 1:(DeckSize + 1); %+1 is for unknown


% Get hole cards
PlayersCards = zeros(NumPlayers,NumHoleCards);

for i = 1:NumPlayers
    PlayersCards(i,:) = ParseHoleCards(sprintf('What are Player %s''s hole cards?\n',num2str(i)),NumHoleCards);
end
% Get the Flop
FlopTurnRiver = GetCards('What was the Flop? ',NumFlopCards);

% Get the Turn
FlopTurnRiver = [FlopTurnRiver GetCards('What was the Turn? ',NumTurnCards)];

% Get the River
FlopTurnRiver = [FlopTurnRiver GetCards('What was the River? ',NumRiverCards)];

%Get the best hand and find out who is ahead
[handRanking handResults] = HandResults(FlopTurnRiver,PlayersCards);

if (handRanking == [1;2])
    behindPlayer =2;
    aheadPlayer = 1;
elseif (handRanking == [2;1])
    behindPlayer = 1;
    aheadPlayer = 2;
end

[num outs] = numOfOuts(FlopTurnRiver,PlayersCards,aheadPlayer,'turn');

msgbox(ans)
%Determine the outs needed for the player
function [count outs] = numOfOuts(commonCards,PlayersCards,aheadPlayer,turnOrRiver)
    count = 0;
    for kk = 1:52
        if (kk~=commonCards)
            if (kk~=PlayersCards(aheadPlayer,:))
                if (strcmpi(turnOrRiver,'turn'))
                    x = 4;
                    commonCards(x) = kk;
                elseif (strcmpi(turnOrRiver,'river'))
                    x = 5;
                    commonCards(x) = kk;
                else
                    msgbox('turn or river?')
                end
                [drawRanking drawResult] = HandResults(commonCards,PlayersCards);
                if (drawRanking ~= handRanking)
                    count = count+1;
                    outs(count) = kk;
                end
            end
        end
    end
end

function [ranking result] = HandResults(commonCards,PlayersCards)
    % Compute each player's best hand
    result = zeros(NumPlayers,6);
    format long
    for jjj = 1:NumPlayers
        if ~isempty(find(PlayersCards(jjj,:) == 0,1))
            result(jjj,:) = [(NumHands + 1) 0 0 0 0 0];
        else
            result(jjj,:) = BestHand([PlayersCards(jjj,:) commonCards]);
        end
        
        for ii = 2:6
            result(jjj,ii) = 4.*(floor((result(jjj,ii)-1)./4)) + 1;
        end
    end
        
    % Figure out who won the hand
    %This is flawed because it doesn't recognize ties
    results = sum(result .* repmat(logspace(2,-8,6),NumPlayers,1),2);
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
    format
end

%Find best hand given 7 cards
function result = BestHand(cards)   
    
    % Sort cards
    cards = sort(cards);
    
    % Create hand matrix
    handMatrix = zeros(NumSuits,NumCards);
    for idx = 1:length(cards)
        if cards(idx) ~= 53;
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
                    result(2:6) = suitRF + NumSuits * (0:4);
                    return;
                end
            case 'SF'
                % Check for Straight Flush
                mat = [handMatrix handMatrix(:,1)];
                for suitStFl = 1:NumSuits
                    startInd = strfind(mat(suitStFl,:),ones(1,5));
                    if ~isempty(startInd)
                        % Found Straight Flush
                        result(1) = jjdx;
                        result(2:6) = suitStFl + NumSuits * (startInd(1) + (-1:3));
                        if (startInd(1) == (NumCards - 3))
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
                    result(2:5) = (NumSuits * (ind4(1) - 1) + suits4);
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
                        result(2:4) = (NumSuits * (ind3(1) - 1) + suits3);
                        result(5:6) = (NumSuits * (ind23(1) - 1) + suits2);
                        return;
                    end
                end
            case 'F'
                % Check for Flush
                if ~isempty(indFl)
                    % Found Flush
                    result(1) = jjdx;
                    cardNumFl = find(handMatrix(indFl(1),:),5,'first');
                    result(2:6) = (NumSuits * (cardNumFl - 1) + indFl(1));
                    return;
                end
            case 'S'
                % Check for Straight
                startInd = strfind([NumEachCard NumEachCard(1)] > 0,ones(1,5));
                if ~isempty(startInd)
                    % Found Straight
                    result(1) = jjdx;
                    if (startInd(1) == (NumCards - 3))
                        for idx = 1:4
                            result(idx + 1) = NumSuits * (startInd(1) + idx - 2) + find(handMatrix(:,startInd(1) + idx - 1),1,'first');
                        end
                        result(6) = find(handMatrix(:,1),1,'first');
                    else
                        for idx = 1:5
                            result(idx + 1) = NumSuits * (startInd(1) + idx - 2) + find(handMatrix(:,startInd(1) + idx - 1),1,'first');
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
                    result(2:4) = (NumSuits * (ind3(1) - 1) + suits3);
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
                    result(2:3) = (NumSuits * (ind2(1) - 1) + suits2a);
                    result(4:5) = (NumSuits * (ind2(2) - 1) + suits2b);
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
                    result(2:3) = (NumSuits * (ind2(1) - 1) + suits2);
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

function cards = GetCards(text,num)
    cardStr = ProcessUserInput(text);
    cards = zeros(1,num);
    for idx = 1:num
        [c cardStr] = strtok(cardStr,[',',' ']); %#ok
        cardStr = cardStr(2:end);
        cards(idx) = ParseUserCard(c);
    end
end

function holeCards = ParseHoleCards(text,NumHoleCards)
    cardStr = input(text,'s');
    holeCards = zeros(1,NumHoleCards);
    if ~strcmpi(cardStr,'X')
        for idx = 1:NumHoleCards
            [c cardStr] = strtok(cardStr,[',',' ']); %#ok
            cardStr = cardStr(2:end);
            holeCards(idx) = ParseHoleCard(c);
        end
    end
end

function holeCard = ParseHoleCard(cardStr)
    if strcmpi(cardStr,'X')
        holeCard = 0;
    else
        holeCard = GetCard(cardStr);
        if (holeCard == 0)
            holeCard = ParseHoleCard(ProcessUserInput(['Card ''' cardStr ''' was invalid. Try entering the card again: ']));
        else
            index = (Deck == holeCard);
            if (sum(index) ~= 1)
                holeCard = ParseHoleCard(ProcessUserInput(['Card ''' cardStr ''' has already been drawn. Try entering the card again: ']));
            else
                Deck(index) = [];
            end
        end
    end
end

% Takes a string like 'AH' and converts it to a card
function card = ParseUserCard(cardStr)
    card = GetCard(cardStr);
%     if (card == 0)
%         card = ParseUserCard(ProcessUserInput(['Card ''' cardStr ''' was invalid. Try entering the card again: ']));
%     else
%         index = (Deck == card);
%         if (sum(index) ~= 1)
%             card = ParseUserCard(ProcessUserInput(['Card ''' cardStr ''' has already been drawn. Try entering the card again: ']));
%         else
%             Deck(index) = [];
%         end
%     end
end

% Gets the card associated with a card string
function card = GetCard(cardStr)
    if isempty(cardStr)
        card = 0;
    elseif strcmpi(cardStr,'x')
        card = 53;
    else
        cardNum = find(strcmpi(Cards,cardStr(1:(end-1))));
        suit = find(strcmpi(Suits,cardStr(end)));
        if ((length(cardNum) ~= 1) || (length(suit) ~= 1))
            card = 0;
        else
            card = suit + (cardNum - 1) * NumSuits;
        end
    end
end

function userStr = ProcessUserInput(text)
    userStr = input(sprintf('\n%s',text),'s');
    if strcmpi(userStr,'Help')
        DisplayHelp;
        userStr = ProcessUserInput(text);
    elseif strcmpi(userStr,'Cards')
        DisplayCards;
        userStr = ProcessUserInput(text);
    elseif strcmpi(userStr,'Suits')
        DisplaySuits;
        userStr = ProcessUserInput(text);
    elseif strcmpi(userStr,'Hands')
        DisplayHands;
        userStr = ProcessUserInput(text);
    elseif strcmpi(userStr,'Exit')
        error(ExitMessageStr);
    end
end
end