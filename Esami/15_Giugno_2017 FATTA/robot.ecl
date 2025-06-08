:- lib(fd).
:- lib(listut).

robot(Sequenza, L, Obj):-

    Sequenza = [rosso, giallo, rosso, verde, giallo],
    MaxD = 2,

    length(Sequenza, Dim),
    length(L, Dim),
    L :: [1..Dim],

    alldifferent(L),

    impose_maxD(L, 1, MaxD),

    objective(L, Sequenza, Obj),

    append(Schedule,[Obj],Vars),

    minimize(labeling(Vars), Obj).


objective([P|ListP],[C|ListC],Costo):-
    obj_loop(P,C,ListP,ListC,Costo1),
    objective(ListP,ListC,Costo2),
    Costo #= Costo1 + Costo2.

obj_loop(_,_,[],[],0).
obj_loop(P,C,[_|ListP],[C|ListC],Costo):-
    !, obj_loop(P,C,ListP,ListC,Costo).
obj_loop(P,C,[P1|ListP],[_|ListC],Costo):-
    P-P1 #= 1 #<=> X1,
    P1-P #= 1 #<=> X2,
    obj_loop(P,C,ListP,ListC,Costo1),
    Costo #= Costo1 + X1 + X2.


impose_maxD([],_,_).
impose_maxD([H|T],N,MaxD):-
    H #>= N - MaxD,
    H #<= N + MaxD,
    N1 is N +1,
    impose_maxD(T,N1,MaxD).
