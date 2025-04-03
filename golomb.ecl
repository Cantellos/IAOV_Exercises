:-lib(fd).

golomb(L,N,Lmax):-
length(L, N),
L ::  0..Lmax,

alldifferent(L),
ordina(L),

distanze(L,D),
alldifferent(D),
labeling(L).

ordina([_]).
ordina([X, Y | T]) :- X #< Y, ordina([Y | T]).


distanze([_],[]).
distanze([L1|LS], D):-
distanze_loop(L1, LS, D1),
distanze(LS, DS),
append(D1, DS, D).

distanze_loop(_, [], []).
distanze_loop(L1, [L2|LS], [D | DS]):-
D #= L2 - L1,
distanze_loop(L1,LS,DS).