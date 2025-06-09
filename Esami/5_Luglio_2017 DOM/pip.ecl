:- [pack_inst].
:- lib(fd).
:- lib(listut).
:- lib(fd_global).


apt(L,Op):-
    read_data(ListInstall,ListRequires,ListConflict,ListInstalled,NPackage),
    length(L,NPackage),
    L :: [0,1],

    constraint_install(ListInstall,L),
    constraint_requires(ListRequires,L),
    constraint_conflict(ListConflict,L),

    objective(L,ListInstalled,ListOp),
    fd_global:sumlist(ListOp,Op),
    min_max(labeling(L),Op).



objective([],[],[]).
objective([H|T],[H1|T1],[C|Tc]):-
    #\=(H,H1,C),
    objective(T,T1,Tc).


constraint_conflict([],_).
constraint_conflict([conflict(X,Y)|ListConflict],L):-
    nth1(X,L,Px),
    nth1(Y,L,Py),
    Px + Py #<= 1,
    constraint_conflict(ListConflict,L).

constraint_requires([],_).
constraint_requires([requires(X,Y)|ListRequires],L):-
    nth1(X,L,Px),
    nth1(Y,L,Py),
    Px #<= Py,
    constraint_requires(ListRequires,L).

constraint_install([],_).
constraint_install([install(X)|ListInstall],L):-
    nth1(X,L,A),
    A #= 1,
    constraint_install(ListInstall,L).




read_data(ListInstall,ListRequires,ListConflict,ListInstalled,NPackage):-
    findall(install(X),install(X),ListInstall),
    findall(requires(X,Y),requires(X,Y),ListRequires),
    findall(conflict(X,Y),conflict(X,Y),ListConflict),
    package(ListPackage),
    installed(ListInstalled),
    length(ListPackage,NPackage).