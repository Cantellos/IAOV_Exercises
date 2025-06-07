1{schedule(ID,D,S) : tempo(S)}1 :- task(ID,EST,LCT,D).

time_constraint(ID):- schedule(ID,D,S), task(ID,EST,LCT,D), S > EST, S+D < LCT.

:- schedule(ID,D,S), not time_constraint(ID).

:- schedule(ID1,D1,S1), schedule(ID2,D2,S2), ID1 != ID2, S1 > S2, S1 < S2 + D2.
:- schedule(ID1,D1,S), schedule(ID2,D2,S), ID1 != ID2.

minimo(M):- #min{ |S1+D1-S2|, ID1, ID2 : schedule(ID1,D1,S1), schedule(ID2,D2,S2), ID1 != ID2} = M.

#maximize{M : minimo(M)}.

#show schedule/3.
#show minimize/1.


