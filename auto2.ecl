:-lib(fd).
:-[automobili].

auto(Cerchi, Aria, Navig):-
    findall([Id, End, 20],(rich(Id, End, C, _, _), C = 1), Cerchi),
    findall([Id, End, 80],(rich(Id, End, _, A, _), A = 1), Aria),
    findall([Id, End, 50],(rich(Id, End, _, _, N), N = 1), Navig),

    append(Cerchi, Aria, LR1),
    append(Navig, LR1, Lr).