:-lib(fd).
:-lib(fd_global).
:-[warehouse_data].

magazzini(L, MAperti):-
    findall([IDm, Cap], magazzino(IDm, Cap), Magazzini),
    length(Magazzini, Nmag),

    findall(IDn, negozio(IDn), Negozi),
    length(Negozi, Nneg),

    length(L, Nneg),
    L :: 1..Nmag,

    % Creo la lista di magazzini aperti e impongo che debbano essere esattamente 7
    length(MAperti, Nmag),
    MAperti :: [0,1],
    fd_global:occurrences(1, MAperti, NAperti),
    NAperti #= 7,

    % impongo che il magazzino non sia chiuso
    impose_non_chiuso(1, MAperti, L),

    impose_capacita(Magazzini, L),

    % Estraggo le distanze tra magazzini e negozi
    findall(Ld, costo_negozio(_, Ld), Distanze),
    
    get_costo(L, Distanze, LCosti),
    fd_global:sumlist(LCosti, C),

    append(L, MAperti, Lista),

    min_max(labeling(Lista), C).


impose_non_chiuso(_, [], _).
impose_non_chiuso(I, [1|RMa], L):-!,
    I1 is I + 1,
    impose_non_chiuso(I1, RMa, L).
impose_non_chiuso(I, [0|RMa], L):-
    occurrences(I, L, 0),
    I1 is I + 1,
    impose_non_chiuso(I1, RMa, L).


impose_capacita([], _).
impose_capacita([[IDm, Capm]|Rm], L):-
    fd_global:occurrences(IDm, L, N),
    N #<= Capm,
    impose_cap(Rm, L).


get_costo([], [], []).
get_costo([El|Rl], [Dist|Rd], [C|Rc]):-
    element(El, Dist, C),
    get_costo(Rl, Rd, Rc).