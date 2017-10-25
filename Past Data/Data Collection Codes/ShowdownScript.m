   
function finalFilteredShowdownCell = ShowdownScript(showdownCell,playerArray)
%This function will mine player action occurances filtered for showdown hands
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

NumPlayers = 1;

% Initialize deck
Deck = 1:DeckSize;
[M,N] = size(showdownCell);

filteredShowdownCell = cell(M,4); %Data, position, hole cards,preflop action,post flop position

%Generate data for filteredShowdownCell for filtering
for i = 1:M
    A = showdownCell{i};
    NumShowdowns = sum(A);
    B = playerArray{i,2};
    foo = 1;
    showdownArray = cell(NumShowdowns,NumHoleCards + 6);
    for j = 2:length(A)
        if (A(j) == 1)
            showdownArray(foo,:) = {B{j,3}, B{j,4}, B{j,5}, B{j,6}, B{j,7}, B{j,8},char(B{j,12}), char(B{j,13})};
            foo = foo+1;
        end
    end
    filteredShowdownCell{i} = showdownArray;
end

% Get hole cards
filteredShowdownCell(:,3) = SuitsToCats(filteredShowdownCell(:,1));

%Find number of players behind for showdownhands
filteredShowdownCell(:,2) = findPlayersBehind(filteredShowdownCell);

%Find the preflop action for showdownhands
filteredShowdownCell(:,4) = preflopAction(filteredShowdownCell(:,1));

filteredShowdownCell(:,5) = findTotalPlayers(filteredShowdownCell);

%Final Output
finalFilteredShowdownCell = filteredShowdownCell; 

% Get the flop
% FlopTurnRiver = GetCards('What was the Flop? ',NumFlopCards);
% %     timeStamp = playerMat{row,2};
%     handMat = handData{1,1};
%     y = find(handMat{:,1} == timeStamp);

% % Get the Turn
% FlopTurnRiver = [FlopTurnRiver GetCards('What was the Turn? ',NumTurnCards)];
% 
% % Get the River
% FlopTurnRiver = [FlopTurnRiver GetCards('What was the River? ',NumRiverCards)];
% 
% % Determine results of hand
% [handRanking handResults] = HandResults(FlopTurnRiver);

function holeCards = ParseHoleCards(cardStr,NumHoleCards)
    holeCards = zeros(1,NumHoleCards);
    for idx = 1:NumHoleCards
        [c cardStr] = strtok(cardStr,[',',' ']); %#ok
        cardStr = cardStr(2:end);
        holeCards(idx) = ParseHoleCard(c);
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
%             if (sum(index) ~= 1)
%                 holeCard = ParseHoleCard(ProcessUserInput(['Card ''' cardStr ''' has already been drawn. Try entering the card again: ']));
%             else
%                 Deck(index) = [];
%             end
        end
    end
end

% Gets the card associated with a card string
function card = GetCard(cardStr)
    if isempty(cardStr)
        card = 0;
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

% showdownCell2000 = ShowdownFilter(playerArray2000,playerCount);

