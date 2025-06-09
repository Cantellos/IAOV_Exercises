:- lib(fd).

%L = [rosso, giallo, rosso, verde, giallo]
%L = [rosso, giallo, rosso, verde, giallo], schedule(L,2,Sch,C).
schedule(Sequenza, MaxD, Schedule,Cost):-
    length(Sequenza,Nop),
    length(Schedule,Nop),
    Schedule :: [1..Nop],

    alldifferent(Schedule),
    constraint_MaxD(Schedule,1,MaxD),
    objective(Schedule,Sequenza,Cost),
    append(Schedule,[Cost],Vars),
    minimize(labeling(Vars),Cost).



objective([],[],0).
objective([P|ListP],[C|ListC],Cost):-
    objective_loop(P,C,ListP,ListC,Cost1),
    objective(ListP,ListC,Cost2),
    Cost #= Cost1 + Cost2.

objective_loop(_,_,[],[],0).
objective_loop(P,C,[_|ListP],[C|ListC],Cost):-
    !, objective_loop(P,C,ListP,ListC,Cost).
objective_loop(P,C,[P1|ListP],[_|ListC],Cost):-
    #=(P-P1,1,B1),
    #=(P1-P,1,B2),
    objective_loop(P,C,ListP,ListC,Cost1),
    Cost #= Cost1 + B1 + B2.


constraint_MaxD([],_,_).
constraint_MaxD([H|T], N, MaxD):-
    H #<= N + MaxD,
    H #>= N - MaxD,
    N1 is N + 1,
    constraint_MaxD(T,N1,MaxD).