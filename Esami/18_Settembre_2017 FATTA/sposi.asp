invitati(1..NI):- num_invitati(NI).
tavoli(1..NT):- num_tavoli(NT).

1{assegnamento(ID,T): tavoli(T)}1 :- invitati(ID).

:- assegnamento(ID1,T), assegnamento(ID2,T), conflitto(ID1,ID2).

:- tavoli(T), capacita(C), #count{1,ID:assegnamento(ID,T)} > C.

obbiettivo(ID1,ID2) :- assegnamento(ID1, T), assegnamento(ID2, T), conosce(ID1, ID2).

#maximize{1,ID1,ID2 : obbiettivo(ID1,ID2)}.

#show assegnamento/2.
