:-lib(fd).
:-lib(fd_global).

divisioni(Fratelli, N):-
    length(Fratelli, N),
    Fratelli :: 0..1,

    calcola_cubi(1, N, Pesi),
    
    somma_lista(Pesi, TotP),

    MetaP * 2 #= TotP,

    somma_pesi(Fratelli, Pesi, P1),

    P1 #= MetaP,

    labeling(Fratelli).

somma_lista([], 0).
somma_lista([H|T], K):- K#=H+K1, somma_lista(T,K1).

calcola_cubi(N, N, [P]):- !, P is N*N*N.
calcola_cubi(I1, N, [Peso|R]):-
    I1 < N,
    Peso is I1*I1*I1,
    I is I1 + 1,
    calcola_cubi(I, N, R).

somma_pesi([],[], 0).
somma_pesi([F|Rf], [P|Rp], Somma):-
    Somma #= F*P + Somma1,
    somma_pesi(Rf, Rp, Somma1).