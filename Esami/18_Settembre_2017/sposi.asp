
invitati(1..NI):- num_invitati(NI).
tavoli(1..NT):- num_tavoli(NT).

1{seduto(P,T):tavoli(T)}1:- invitati(P).

:- {seduto(_,T)} > C, tavolo(T), capacita(C).

:- conflitto(X,Y), seduto(X,T), seduto(Y,T).

costo(X,Y):- conosce(X,Y), seduto(X,T), seduto(Y,T).

#maximize{1,X,Y:costo(X,Y)}.


#show seduto/2.
#show costo_tot/1.