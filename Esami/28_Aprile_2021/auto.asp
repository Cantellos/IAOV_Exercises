auto(ferrari).
auto(lamborghini).
auto(alfa).
auto(maserati).

colore(giallo).
colore(rosso).
colore(grigio).
colore(nero).

interno(marrone).
interno(panna).
interno(blu).
interno(verde).

prezzo(1..4).

1{combo(M, I, E, P): interno(I), colore(E), prezzo(P)}1 :- auto(M).

:- combo(M1, I1, _, _), combo(M2, I2, _, _), M1 != M2, I1 = I2.
:- combo(M1, _, E1, _), combo(M2, _, E2, _), M1 != M2, E1 = E2.
:- combo(M1, _, _, P1), combo(M2, _, _, P2), M1 != M2, P1 = P2.

sbagliato(1,1) :- combo(M, I, _, _), M = lamborghini, I != marrone.
sbagliato(1,2) :- combo(M, _, E, _), M = lamborghini, E != giallo.
sbagliato(1,3) :- combo(M, _, _, P), M = lamborghini, P != 2.

sbagliato(2,1) :- combo(M, I, _, _), M = ferrari, I != marrone.
sbagliato(2,2) :- combo(M, _, E, _), M = ferrari, E != rosso.
sbagliato(2,3) :- combo(M, _, _, P), M = ferrari, P != 4.

sbagliato(3,1) :- combo(M, I, _, _), M = alfa, I != panna.
sbagliato(3,2) :- combo(M, _, E, _), M = alfa, E != nero.
sbagliato(3,3) :- combo(M, _, _, P), M = alfa, P != 1.

sbagliato(4,1) :- combo(M, I, _, _), M = lamborghini, I != blu.
sbagliato(4,2) :- combo(M, _, E, _), M = lamborghini, E != rosso.
sbagliato(4,3) :- combo(M, _, _, P), M = lamborghini, P != 4.

sbagliato(5,1) :- combo(M, I, _, _), M = alfa, I != blu.
sbagliato(5,2) :- combo(M, _, E, _), M = alfa, E != grigio.
sbagliato(5,3) :- combo(M, _, _, P), M = alfa, P != 3.

#minimize{1,T,I : sbagliato(T,I)}.


#show sbagliato/2.
#show combo/4.