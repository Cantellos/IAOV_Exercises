:- lib(fd).

colleghi(L):- 
    Primi = [A1, B1, C1, D1, F1],
    Secondi = [A2, B2, C2, D2, F2],
    Primi :: [1..5],
    Secondi :: [1..5],
    
    B1 #= 4,
    C2 #= 4,
    D1 #\= 3,
    D2 #\= 3,
    F1 #\= F2,
    A1 #= 2 #\/ A2 #= 2,

    alldifferent(Primi),
    alldifferent(Secondi),

    funz_o(Primi, Secondi, 0, C),

    append(Primi, Secondi, L),

    append(L, [C], T),

    minimize(labeling(T), C).

funz_o([], [], _, 0).  % Base case
funz_o([HP|TP], [HS|TS], Curr, C) :-
    Next is Curr + 1,
    funz_o(TP, TS, Next, C1),
    
    (
        HP #\= Next,
        HS #\= Next
    ->  C #= C1 + 2
    ;   (HP #\= Next ; HS #\= Next)
    ->  C #= C1 + 1
    ;   C #= C1
    ).