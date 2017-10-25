function [X,Y,type] = CatsToNums(stringInput)
%This function returns the plot locations of each card

x = zeros(1,2);
for i = 1:2
    
    if (stringInput(i) == 'A')
        x(1,i) = 14;
    elseif(stringInput(i) == 'K')
        x(1,i) = 13;
    elseif(stringInput(i) == 'Q')
        x(1,i) = 12;
    elseif(stringInput(i) == 'J')
        x(1,i) = 11;
    elseif(stringInput(i) == 'T')
        x(1,i) = 10;
    elseif(stringInput(i) == '9')
        x(1,i) = 9;
    elseif(stringInput(i) == '8')
        x(1,i) = 8;
    elseif(stringInput(i) == '7')
        x(1,i) = 7;
    elseif(stringInput(i) == '6')
        x(1,i) = 6;
    elseif(stringInput(i) == '5')
        x(1,i) = 5;
    elseif(stringInput(i) == '4')
        x(1,i) = 4;
    elseif(stringInput(i) == '3')
        x(1,i) = 3;
    elseif(stringInput(i) == '2')
        x(1,i) = 2;
    end
end

%Determines suited, pair, or offsuit
if (stringInput(1) == '') %nothing
    X = []; Y = []; type = '';
elseif (x(1,1) == x(1,2)) %pair
    X = 15 - x(1,1);
    Y = x(1,2)-1;
    type = '.';
elseif (stringInput(3) == 's') %suit
    Y = x(1,1) - 1;
    X = 15 - x(1,2);
    type = 'x';
else                      %offsuit
    X = 15-x(1,1);
    Y = x(1,2) - 1;
    type = 'o';
end
