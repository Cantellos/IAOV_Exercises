:-[istanza].
:-lib(fd).
:-lib(fd_global).
:-lib(listut).

colori(L, Obj, C):-

    findall(Y, car(X,Y), Colors),
    write(Colors),
    nl,
    maxd(MaxD),
    
    length(Colors, N),
    length(L, N),
    L::1..N,

    impose_distanza(L, MaxD, 1),

    fd_global:alldifferent(L),

    objective(L, Colors, Obj),

    minimize(labeling(L), Obj), 

    results(L,Colors,C).

results([],_,[]).
results([P1|ListP],Colors,[C|ListC]):-
    nth1(P1,Colors,C),
    results(ListP,Colors,ListC).


objective([],[],0).
objective([P|ListP],[C|ListC],Cost):-
    objective_loop(P,C,ListP,ListC,Cost1),
    objective(ListP,ListC,Cost2),
    Cost #= Cost1 + Cost2.

objective_loop(_,_,[],[],0).
objective_loop(P,C,[_|ListP],[C|ListC],Cost):-
    !, objective_loop(P,C,ListP,ListC,Cost).
objective_loop(P,C,[P1|ListP],[_|ListC],Cost):-
    abs(P-P1) #= 1 #<=> Cost1,
    objective_loop(P,C,ListP,ListC,Cost2),
    Cost #= Cost1 + Cost2.


impose_distanza([],_,_).
impose_distanza([Pos|ListPos], MaxD, N):-
    Pos #<= N + MaxD,
    Pos #>= N - MaxD,
    N1 is N+1,
    impose_distanza(ListPos, MaxD, N1).

    
