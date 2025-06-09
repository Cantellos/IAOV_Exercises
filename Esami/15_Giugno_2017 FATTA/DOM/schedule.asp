auto(1,rosso). auto(2,giallo). auto(3,rosso). auto(4,verde). auto(5,giallo).
maxD(2).
pos(X) :- auto(X,_).

1{schedule(N,C,P):pos(P)}1:- auto(N,C).


:- schedule(N,C,P), maxD(D), P > N + D.
:- schedule(N,C,P), maxD(D), P < N - D.
:- schedule(N1,_,P), schedule(N2,_,P), N1 != N2.

costo(P2,P1):- schedule(_,C1,P1), schedule(_,C2,P2), C1 != C2, P2 - P1 = 1.
costo(P1,P2):- schedule(_,C1,P1), schedule(_,C2,P2), C1 != C2, P1 - P2 = 1.

#minimize{1,P1,P2:costo(P1,P2)}.

#show schedule/3.