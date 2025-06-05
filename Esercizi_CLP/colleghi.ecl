:-lib(fd).
:-lib(fd_global).

colleghi(Primi, Secondi):-
    Primi = [A1, B1, C1, D1, F1],
    Secondi = [A2, B2, C2, D2, F2],

    Primi :: [1..5],
    Secondi :: [1..5],

    B1 #= 4,

    ((C1 #= 4) #/\ (C2 #\= 4)) #\/ ((C2 #= 4) #/\ C1 #\= 4),

    (D1 #\= 3), (D2 #\= 3),

    (F1 #\= F2),

    (A1 #= 2) #\/ (A2 #= 2),

    fd:alldifferent(Primi),
    fd:alldifferent(Secondi).

funz_ob([],[],0,_).
funz_ob([Hp|Tp], [Hs|Ts], C, Curr):-
    Next is Curr + 1,

    funz_ob(Tp, Ts, C1, Next),

    (Hp #\= Curr, Hs #\= Curr
        ->  C #= C1 + 2
        ;   (Hp #\= Curr ; Hs #\= Curr)
            ->  C #= C1 + 1
            ;   C #= C1
    ).

funz_ob2([],[],[],_).
funz_ob2([Hp|Tp], [Hs|Ts],[B1,B2|R],Curr):-
    #\=(Hp,Curr,B1),
    #\=(Hs,Curr,B2),
    Next is Curr +1,
    funz_ob2(Tp,Ts,R,Next).

cop(L):-
    colleghi(Primi, Secondi),
    funz_ob2(Primi, Secondi, C, 1),
    sumlist(C,S),
    append(Primi, Secondi, L),
    minimize(labeling(L),S).
