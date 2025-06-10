:-[istanza].
:-lib(fd).
:-lib(fd_global).
:-lib(listut).

cante(L):-

    findall(Y, car(X,Y), Colors),
    write(Colors),
    maxd(MaxD),
    
    length(Colors, N),
    length(L, N),
    L::1..N,

    impose_distanza(L, MaxD, 1),

    fd_global:alldifferent(L),

    objective(L, L, Colors, 1, ListObj),

    fd_global:sumlist(ListObj, Obj),

    minimize(labeling(L), Obj).


objective([X],_,_,_,_).
objective([Pos|ListPos], L, ListColor, N, [Costo|ListCosto]):-
    nth1(X, L, N),
    nth1(X, L, Color),
    N1 is N + 1,
    nth1(Y, L, N1),
    nth1(Y, L, Color1),
    #\=(Color,Color1,Costo),
    objective(ListPos, L, ListColor, N1, ListCosto).


impose_distanza([],_,_).
impose_distanza([Pos|ListPos], MaxD, N):-
    Pos #<= N + MaxD,
    Pos #>= N - MaxD,
    N1 is N+1,
    impose_distanza(ListPos, MaxD, N1).

    
