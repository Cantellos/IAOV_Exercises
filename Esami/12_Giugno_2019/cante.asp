start(0..End-1):-endtime(End).

1{schedule(ID,Start) : start(Start)}1 :- ordine(ID,_).

:- schedule(P1,Start), schedule(P2,Start), P1 != P2.

:- precedenza(P1,P2), schedule(P1,Start1), schedule(P2,Start2), Start1 >= Start2.

guadagno(ID):- schedule(ID,Start), ordine(ID, Scad), Start + 1 <= Scad.

#maximize{1,ID:guadagno(ID), schedule(ID,_)}.

#show schedule/2.