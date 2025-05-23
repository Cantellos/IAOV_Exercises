permutation([],[]).
permutation([H|T], L) :-
    permutation(T, Lt),
    delete(H, L, Lt).