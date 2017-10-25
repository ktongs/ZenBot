function y = showdownFilter(playerArray,playerCount)
% This function will filter showdown hands per player

actionTable = playerArray(:,2);
C = cell(playerCount,1);
for i = 1:playerCount
    A = actionTable{i,1};
    [M,N] = size(A);
    B = zeros(M,1);
    for j = 2:M
        B(j,1) = ~strcmp(A{j,12},'');
    end
    C{i,1} = B; 
end



y = C;

end