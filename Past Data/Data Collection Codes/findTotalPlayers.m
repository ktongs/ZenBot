function y = findTotalPlayers(filteredShowdownCell)

[M,N] = size(filteredShowdownCell);

y = cell(M,1)
for i = 1:M
    A = filteredShowdownCell{i,1};
    [X,Y] = size(A);
    B = cell(X,1);
    for j = 1:X
        B{j,1} = A{j,1}(1);
    end
    y{i,1} = B;
end

