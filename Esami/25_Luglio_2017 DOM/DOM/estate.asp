% 1 --> padre   2 --> madre     3 --> asilo     4 --> baby-sitter

giorno(1..30).
scelta(1..4).

1{bambino(D,S) : scelta(S)}1:- giorno(D).

:-bambino(D,S), impegno(S,D).

:- #count{D:bambino(D,1)} > 4.
:- #count{D:bambino(D,2)} > 6.

:- bambino(D1,3), bambino(D2,3), D1 != D2, |D1 - D2| > 6.

asilo :- bambino(D,3).
costoBs(C) :- #count{D:bambino(D,4)} = N, C = 50*N.

costoTotale(C) :- costoBs(C), not asilo.
costoTotale(Ct) :- costoBs(C), asilo, Ct = 100 + C.

#minimize{C:costoTotale(C)}.

#show bambino/2.
#show costoBs/1.
#show costoTotale/1.