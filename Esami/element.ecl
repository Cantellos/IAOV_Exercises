:-lib(fd).

spesa(X,Y):-
    [X,Y] :: [1..5],
    L = [10,5,6,8,11],

    X #\= Y,
    element(X,L,CostX),
    element(Y,L,CostY),
    Cost #= CostX + CostY,
    minimize(labeling([X,Y]), Cost).