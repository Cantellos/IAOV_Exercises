:- [production].
:- lib(fd).
:- lib(cumulative).
:- lib(fd_global).
:- lib(listut).

prod(L,C):-

    findall((ID,Scadenza), ordine(ID, Scadenza), Ordini),
    endtime(End),

    length(Ordini, N),
    length(L, N),
    L::0..End-1,

    findall((X,Y), precedenza(X,Y), Precedenze),
    impose_precedenze(L, Precedenze),

    length(Durate, N),
    Durate::1,
    length(Risorse, N),
    Risorse::1,
    cumulative(L, Durate, Risorse, 1),

    objective(L, Ordini, Costo),
    C #= - Costo,
    append(L,C,Vars),
    min_max(labeling(L),C).


objective(_,[],0).
objective(L, [(ID,Scadenza)|ListOrd], Costo):-
    nth1(ID, L, X),
    X + 1 #<= Scadenza #<=> B,
    objective(L, ListOrd, Costo1),
    Costo = Costo1 + B.


impose_precedenze(_, []).
impose_precedenze(L, [(P1,P2)|ListPrec]):-
    nth1(P1, L, Start1),
    nth1(P2, L, Start2),
    Start1 + 1 #<= Start2,
    impose_precedenze(L, ListPrec).
