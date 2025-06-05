:- lib(fd).

marmellata(L):-
L = [A,B,C,D,E,F],
L :: [0,1],

V = [VA, VB, VC, VD, VE],
V :: [0,1],

somma(L, S1), S1 #= 2,
somma(V, S2), S2 #= 4,

D + E #= VA,
C + F #= VB,
F + E #= VC,
A + E #= VD,
C + B #= VE,

append(L, V, W),
labeling(W).

somma([],0).
somma([H|T],S):-
somma(T, S1), S #= S1 + H.