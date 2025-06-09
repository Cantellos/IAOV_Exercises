invitati(1..NI) :- num_invitati(NI).
tavoli(1..NT) :- num_tavoli(NT).

1{seduto(ID,T):tavoli(T)}1:- invitati(ID).

pieno(T) :- tavoli(T), capacita(C), #count{1,ID : seduto(ID,T)} > C.
:- pieno(T).

:- conflitto(ID1,ID2), seduto(ID1,T), seduto(ID2,T).


obiettivo(ID1,ID2) :- conosce(ID1,ID2), seduto(ID1,T), seduto(ID2,T).

#maximize{1,ID1,ID2 : obiettivo(ID1,ID2)}.


#show seduto/2.