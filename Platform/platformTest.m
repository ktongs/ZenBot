tic
%pot odds
potValue = 20; %Includes betted amount
toCall = 10;
%opponent range guess
range = StandardPreflop('middle','c');
agressiveness = 0.5; %From 0 to 1
tightness = 0.3; %From 0 to 1

%What do I know
heroCardNum = [23,5];
flop = [24,41,29]; %53,54,55 if unknown
turn = 56; %56 if unknown
river = 57;%57 if unknown

combo = rangeToCombo(range,heroCardNum,[flop,turn,river]);
[M,~] = size(combo);
num = zeros(M,1); outs = cell(M,1);
out = cell(M,1);
ranking = zeros(M,1);

[Cards, Suits, Hands, Deck,DeckSize] = initGame();

for i = 1:M
    [num(i,1),out{i,1},ranking(i,1)] = getMyOuts(heroCardNum, combo(i,:), flop, turn, river, Hands);
end

a = [num, combo];

f = fit([min(ranking);max(ranking);0.5.*(min(ranking)+max(ranking))],[0;1;tightness./2],'exp1');
plot(f,[min(ranking);max(ranking)],[0;1])

eq = zeros(M,1); feq = zeros(M,1); %expected value per hand, fold expected equity per hand
for i = 1:M
    if turn == 53
        deckCount = 45;
    elseif river == 53
        deckCount = 44;
    else
        deckCount =43;
    end
    eq(i) = num(i)./deckCount;
    feq(i) = f(ranking(i));
end
ev = sum(eq); fev = sum(feq);
showdownEq = ev/M; foldEq = fev/M;

foldEV = 0;
%Check for call EV
callEV = showdownEq*potValue - (1-showdownEq)*toCall;

%Check for potsize raise EV
potRaiseEV = foldEq*potValue + (1-foldEq)*(showdownEq*(potValue*2)-(1-showdownEq)*potValue);

%Check for 3xpot size raise EV
shoveRaiseEV = foldEq*potValue + (1-foldEq)*(showdownEq*(potValue*4)-(1-showdownEq)*3*potValue);

z = [foldEV,callEV,potRaiseEV,shoveRaiseEV];
action = ['fold';'call';'pot1';'pot3'];
[Y,I] = max(z);
Y
action(I,:)
toc
