auto(ferrari).
auto(maserati).
auto(alfa).
auto(lamborghini).

colore(giallo).
colore(rosso).
colore(grigio).
colore(nero).

interno(marrone).
interno(panna).
interno(blu).
interno(verde).

prezzo(1..4).

1{combo(A,C,I,P): colore(C), interno(I), prezzo(P)}1 :- auto(A).

:- combo(A1,C1,_,_), combo(A2,C2,_,_), A1 != A2, C1 = C2.
:- combo(A1,_,I1,_), combo(A2,_,I2,_), A1 != A2, I1 = I2.
:- combo(A1,_,_,P1), combo(A2,_,_,P2), A1 != A2, P1 = P2.


sbagliato(1,2):- combo(A,C,_,_), A = lamborghini, C != giallo.
sbagliato(1,1):- combo(A,_,I,_), A = lamborghini, I != marrone.
sbagliato(1,3):- combo(A,_,_,P), A = lamborghini, P != 2. 
sbagliato(2,2):- combo(A,C,_,_), A = ferrari, C != rosso. 
sbagliato(2,1):- combo(A,_,I,_), A = ferrari, I != marrone. 
sbagliato(2,3):- combo(A,_,_,P), A = ferrari, P != 4. 
sbagliato(3,2):- combo(A,C,_,_), A = alfa, C != nero. 
sbagliato(3,1):- combo(A,_,I,_), A = alfa, I != panna. 
sbagliato(3,3):- combo(A,_,_,P), A = alfa, P != 1.
sbagliato(4,2):- combo(A,C,_,_), A = lamborghini, C != rosso. 
sbagliato(4,1):- combo(A,_,I,_), A = lamborghini, I != blu.
sbagliato(4,3):- combo(A,_,_,P), A = lamborghini, P != 4. 
sbagliato(5,2):- combo(A,C,_,_), A = alfa, C != grigio.
sbagliato(5,1):- combo(A,_,I,_), A = alfa, I != blu.
sbagliato(5,3):- combo(A,_,_,P), A = alfa, P != 3. 

#minimize{1,X,Y: sbagliato(X,Y)}.

#show combo/4.
#show sbagliato/2.