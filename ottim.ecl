:- lib(fd).

    B1 = D1
    C2 = D2
    D1/2 \= C1/2
    F1 owner \= F2 owner
    A1 E/O A2 = B1/B2
    (Owner, Receiver)
    C = 
    findall((O,R), (sol(0, R), L)

cop(L):
    imponi_vincoli(L),
    funz_o(L,C),
    minimize(labeling(L), C).

funz_o([H|T], C):-
    funz_o(H,C1),
    diff(H,Cp),
    C is C2 + C1,