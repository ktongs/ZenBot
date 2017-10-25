function [Cards, Suits, Hands, Deck, DeckSize] = initGame(varargin)
%This function will initialize parameter for game

% NumHoleCards = 2;

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
% NumHands = size(Hands,1);

% NumPlayers = 2;

% Initialize deck
Deck = 1:(DeckSize + 5); %+5 is for unknown

