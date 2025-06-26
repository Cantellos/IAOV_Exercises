
1{ass(N,M) : magazzino(M,_)}1 :- negozio(N).

aperto(M):- ass(_, M).
:- {M:aperto(M)}=A, A >7.

conta(M,A,C):- magazzino(M,C), {N:ass(N,M)} = A.
:- conta(M,A,C), A > C.

costo(N,M,C):- ass(N,M), distanza(N,M,C).
#minimize{C,N,M:costo(N,M,C)}.

#show ass/2.