:- [matrimonio].
:- lib(fd).
:- lib(listut).
:- lib(fd_global).

sposi(L):-
    read_data(NI,NT,C,ListConflict,ListFriends),
    length(L,NI),
    L :: [1..NT],
    DomainC :: [1..C],

    constraint_conflict(ListConflict,L),
    constraint_capacity(1,NT,L,DomainC),

    objective(ListFriends,L,ListC),
    fd_global:sumlist(ListC,Sum),
    Obj #= -Sum,
    append(L,[DomainC],Vars),
    minimize(labeling(Vars),Obj).




objective([],_,[]).
objective([conosce(ID1,ID2)|ListFriends],L,[C|ListC]):-
    nth1(ID1,L,A),
    nth1(ID2,L,B),
    #=(A,B,C),
    objective(ListFriends,L,ListC).



constraint_capacity(NT,NT,L,DomainC):-!,
    occurrences(NT,L,DomainC).
constraint_capacity(N,NT,L,DomainC):-
    occurrences(N,L,DomainC),
    N1 is N + 1,
    constraint_capacity(N1,NT,L,DomainC).

constraint_conflict([],_).
constraint_conflict([conflitto(ID1,ID2)|ListConflict],L):-
    nth1(ID1,L,A),
    nth1(ID2,L,B),
    A #\= B,
    constraint_conflict(ListConflict,L).


read_data(NI,NT,C,ListConflict,ListFriends):-
    num_invitati(NI),
    num_tavoli(NT),
    capacita(C),
    findall(conflitto(ID1,ID2),conflitto(ID1,ID2),ListConflict),
    findall(conosce(ID1,ID2),conosce(ID1,ID2),ListFriends).