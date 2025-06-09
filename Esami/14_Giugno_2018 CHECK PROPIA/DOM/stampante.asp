1{schedule(ID,EST,LCT,D,S):tempo(S)}1:- task(ID,EST,LCT,D).



:- schedule(ID,EST,LCT,D,S), S < EST.
:- schedule(ID,EST,LCT,D,S), S + D > LCT.
:- schedule(ID1,_,_,_,S), schedule(ID2,_,_,_,S), ID1 != ID2.

:- schedule(ID1,_,_,D1,S1), schedule(ID2,_,_,_,S2), ID1 != ID2, S1 < S2, S2 < S1 + D1.


distanze(D,ID1,ID2):- schedule(ID1,_,_,D1,S1), schedule(ID2,_,_,_,S2), ID1 != ID2, S1 < S2, Fine = S1 + D1, D = S2 - Fine.

distanzaMinima(M) :- #min{D,ID1,ID2 : distanze(D,ID1,ID2)}=M.

#maximize{M:distanzaMinima(M)}.


#show schedule/5.