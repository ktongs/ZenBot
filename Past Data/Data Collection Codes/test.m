clear plot
actionCell= finalFilteredShowdownCell(:,3);

for i = 5:5
    A = actionCell{i};
    [M,N] = size(A);
    x = zeros(M,1); y = zeros(M,1);
    for j = 1:M
    [x(j),y(j),type(j)] = CatsToNums(char(A{j,1}));
    hold on
    plot(x(j),y(j),type(j));
    end
end
xlim([1 13]);
ylim([1 13]);