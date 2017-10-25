function y = SuitsToCats(filteredShowdownCell)
%This function will transform cards from cards to pair, offsuit, or suited
[M,N] = size(filteredShowdownCell);
catsShowdownCell = cell(M,1);
unfiltered = cell(1,2);

for i = 1:M
    A = filteredShowdownCell{i,1};
    [X,Y] = size(A);
    B = cell(X,1);
    for j = 1:X
        %sort in descending order of cards
        if (strcmpi(A{j,7}(1),'A'))
            unfiltered{j,1} = A{j,7};
            unfiltered{j,2} = A{j,8};
        elseif (strcmpi(A{j,8}(1),'A'))
            unfiltered{j,1} = A{j,8};
            unfiltered{j,2} = A{j,7};
        elseif (strcmpi(A{j,7}(1),'K'))
            unfiltered{j,1} = A{j,7};
            unfiltered{j,2} = A{j,8};
        elseif (strcmpi(A{j,8}(1),'K'))
            unfiltered{j,1} = A{j,8};
            unfiltered{j,2} = A{j,7};
        elseif (strcmpi(A{j,7}(1),'Q'))
            unfiltered{j,1} = A{j,7};
            unfiltered{j,2} = A{j,8};
        elseif (strcmpi(A{j,8}(1),'Q'))
            unfiltered{j,1} = A{j,8};
            unfiltered{j,2} = A{j,7};
        elseif (strcmpi(A{j,7}(1),'J'))
            unfiltered{j,1} = A{j,7};
            unfiltered{j,2} = A{j,8};
        elseif (strcmpi(A{j,8}(1),'J'))
            unfiltered{j,1} = A{j,8};
            unfiltered{j,2} = A{j,7};
        elseif (strcmpi(A{j,7}(1),'T'))
            unfiltered{j,1} = A{j,7};
            unfiltered{j,2} = A{j,8};
        elseif (strcmpi(A{j,8}(1),'T'))
            unfiltered{j,1} = A{j,8};
            unfiltered{j,2} = A{j,7};
        else
            D = [A{j,7}(1),A{j,8}(1)];
            C = sort(D,'descend');
            unfiltered{j,1} = C(1);
            unfiltered{j,2} = C(2);
        end

        %Lets do magic here
        if (strncmpi(unfiltered{j,1},unfiltered{j,2},1))
            result = sprintf('%c%c',unfiltered{j,1}(1),unfiltered{j,2}(1));
        elseif(strncmpi(A{j,7}(end),A{j,8}(end),1))
            result = sprintf('%c%cs',unfiltered{j,1}(1),unfiltered{j,2}(1));
        elseif(~strncmpi(A{j,7}(end),A{j,8}(end),1))
            result = sprintf('%c%co',unfiltered{j,1}(1),unfiltered{j,2}(1));
        end
        B(j,1) = cellstr(result);
    end
    catsShowdownCell{i,1} = B;
end

y = catsShowdownCell;

end
