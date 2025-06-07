:- lib(fd).
:- lib(listut).

robot(Sequenza, L, Obj):-

    Sequenza = [1, 2, 1, 3, 2],
    MaxD = 2,

    length(Sequenza, Dim),
    length(L, Dim),
    L :: [1..Dim],
    fd_global:alldifferent(L),

    impose_maxD(L, 1, MaxD),

    objective(L, Sequenza, Objlist),
    sumlist(ObjList, Obj),

    minimize(labeling(L), Obj).

objective([H],_,_).
objective([H1|[H2|T]], Sequenza, [Obj|To]):-
    nth1(H1, Sequenza, C1),
    nth1(H2, Sequenza, C2),
    C1 #\= C2 #=> Obj,
    objective([H2|T], Sequenza, To).


impose_maxD([],_,_).
impose_maxD([H|T],N,MaxD):-
    H #>= N - MaxD,
    H #<= N + MaxD,
    N1 is N +1,
    impose_maxD(T,N1,MaxD).
