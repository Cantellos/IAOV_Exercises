:- lib(fd).
:- [automobili].

auto(L):-
    findall([Id,End,Cl,Ac,Nav], rich(Id,End,Cl,Ac,Nav), Rich),
    write(Rich).
