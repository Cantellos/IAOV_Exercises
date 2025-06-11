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
    impose_capacita(1, NT, L, Capacità),

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


impose_capacita(NT, NT, L, C):- !,
    occurrences(Curr,L,X),
    X #<= 6.
impose_capacita(Curr, NT, L, C):-
    occurrences(Curr,L,X),
    X #<= 6,
    Next is Curr + 1,
    impose_capacita(Next, NT, L, C).


impose_conflitti(_,[]).
impose_conflitti(L,[(X,Y)|ListC]):-
    nth1(X,L,P1),
    nth1(Y,L,P2),
    P1 #\= P2,
    impose_conflitti(L, ListC).