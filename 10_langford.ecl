:- lib(fd).

lan(N,S,E):-

    length(S, N),
    S :: [1..2*N], % S = lista degli start time per ogni numero

    length(E, N),
    E :: [1..2*N],  % E = lista degli end time per ogni numero

    check(S, 1, E),

    append(S,E,L),

    alldifferent(L),

    labeling(L).

check([], _, []).
check([Hs|Ts], Curr, [He|Te]):-
    Next is Curr + 1,
    He #= Hs + Next,
    check(Ts, Next, Te).