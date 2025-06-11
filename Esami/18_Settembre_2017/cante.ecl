:- [matrimonio].
:- lib(fd).
:- lib(listut).
:- lib(fd_global).

sposi(L,C):-

    num_invitati(N),
    num_tavoli(NT),

    length(L,N),
    L::[1..NT],

    findall((X,Y), conflitto(X,Y), Conflitti),
    findall((X,Y), conosce(X,Y), Amici),

    impose_conflitti(L, Conflitti),

    capacita(Capacità),
    impose_capacità(L, Capacità),

    objective(L, Amici, Cost),
    C #= - Cost,
    append(L,[C],Vars),

    min_max(labeling(Vars),C).


objective(_,[],0).
objective(L, [(X,Y)|ListA], Cost):-
    nth1(X,L,P1),
    nth1(Y,L,P2),
    P1 #= P2 #<=> B,
    Cost #= Cost1 + B,
    objective(L, ListA, Cost1).
    
impose_capacità(L,C,):-
    occurences(L,N) #< 6.
    occurences(L,N) #< 6.
    occurences(L,N) #< 6.

impose_conflitti(_,[]).
impose_conflitti(L,[(X,Y)|ListC]):-
    nth1(X,L,P1),
    nth1(Y,L,P2),
    P1 #\= P2,
    impose_conflitti(L, ListC).