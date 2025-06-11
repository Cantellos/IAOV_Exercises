:-[pack_inst].
:-lib(fd).
:-lib(fd_global).
:-lib(listut).

packets(L, Cost):-

    findall((X,Y), requires(X,Y), Req),
    findall((X,Y), conflict(X,Y), Conf),
    install(Install), 
    installed(Installed),

    length(Installed, N),
    length(L, N),
    L :: [0..1],

    vincoli_install(L, Install),
    vincoli_requires(L, Req),
    vincoli_conflict(L, Conf),

    objective(L, Installed, Cost),

    minimize(labeling(L), Cost).


objective([],[],0).
objective([L1|ListL], [I1|ListI], Cost):-
    L1 #\= I1 #<=> B,
    objective(ListL, ListI, Cost1),
    Cost #= Cost1 + B.


vincoli_conflict(_,[]).
vincoli_conflict(L, [(X,Y)|ListC]):-
    nth1(X, L, V1), 
    nth1(Y, L, V2),
    V1 #= 1 #<=> B1,
    V2 #= 1 #<=> B2,
    B1 + B2 #<= 1,
    vincoli_conflict(L, ListC).


vincoli_requires(_,[]).
vincoli_requires(L, [(X,Y)|ListR]):-
    nth1(X, L, V1), 
    nth1(Y, L, V2),
    V1 #\= 1 #<=> B1,
    V2 #= 1 #<=> B2,
    B1 + B2 #>= 1,
    vincoli_requires(L, ListR).


vincoli_install(L, Install):-
    nth1(Install, L, X),
    X #= 1.


