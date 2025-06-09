:-[distanze].
:-lib(fd).
:-lib(propia).
:-lib(fd_global).

tsp(L):-
    ncitta(N),
    length(L,N),
    L :: [1..N],
    impose_start(L),
    exist_arc(L, ListCost),
    fd_global:alldifferent(L),

    sumlist(ListCost,Cost),

    min_max(labeling(L),Cost).


impose_start([H|_]):-
    H #= 1.

exist_arc([A],[C]):-
    !,dista(A,1,C) infers most.
exist_arc([A,B|T],[C|Cost]):-
    dista(A,B,C) infers most,
    exist_arc([B|T],Cost)