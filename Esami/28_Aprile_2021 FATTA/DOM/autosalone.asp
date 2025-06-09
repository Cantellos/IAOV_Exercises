auto(ferrari). auto(lambo). auto(alfa). auto(maserati).
colore(giallo). colore(rosso). colore(nero). colore(grigio).
interni(verde). interni(marrone). interni(panna). interni(blu).
prezzo(1..4).

1{vendita(M,C,I,P) : colore(C), interni(I),prezzo(P)}1:- auto(M).



:- vendita(M1,C,_,_), vendita(M2,C,_,_), M1 != M2.
:- vendita(M1,_,_,P), vendita(M2,_,_,P), M1 != M2.
:- vendita(M1,_,I,_), vendita(M2,_,I,_), M1 != M2.


sbagliato(1,1) :- vendita(M,C,I,P), M = lambo, C != giallo.
sbagliato(1,2) :- vendita(M,C,I,P), M = lambo, P != 2.
sbagliato(1,3) :- vendita(M,C,I,P), M = lambo, I != marrone.

sbagliato(2,1) :- vendita(M,C,I,P), M = ferrari, I != marrone.
sbagliato(2,2) :- vendita(M,C,I,P), M = ferrari, P != 4.
sbagliato(2,3) :- vendita(M,C,I,P), M = ferrari, C != rosso.

sbagliato(3,1) :- vendita(M,C,I,P), M = alfa, C != nero.
sbagliato(3,2) :- vendita(M,C,I,P), M = alfa, P != 1.
sbagliato(3,3) :- vendita(M,C,I,P), M = alfa, I != panna.

sbagliato(4,1) :- vendita(M,C,I,P), M = lambo, P != 4.
sbagliato(4,2) :- vendita(M,C,I,P), M = lambo, I != blu.
sbagliato(4,3) :- vendita(M,C,I,P), M = lambo, C != rosso.

sbagliato(5,1) :- vendita(M,C,I,P), M = alfa, P != 3.
sbagliato(5,2) :- vendita(M,C,I,P), M = alfa, I != blu.
sbagliato(5,3) :- vendita(M,C,I,P), M = alfa, C != grigio.

#minimize{1,C,I:sbagliato(C,I)}.

#show vendita/4.
%#show sbagliato/2.