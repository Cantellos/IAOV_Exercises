:- [impegni].
:- lib(fd).
:- lib(fd_global).
:- lib(listut).

% 1 --> padre   2 --> madre     3 --> asilo     4 --> baby-sitter

estate(L,StartAsilo,EndAsilo):-
    length(L,30),
    L :: [1,2,3,4],
    [StartAsilo,EndAsilo] :: [1..30],
    OP :: [0..4],
    OM :: [0..6],

    EndAsilo #> StartAsilo,
    EndAsilo - StartAsilo #= 6,

    occurrences(1,L,OP),
    occurrences(2,L,OM),
    impose_constraint_parents(L),
    consraint_asilo(1,L,StartAsilo,EndAsilo),

    funzione_obiettivo(L,Cost),
    append(L,[StartAsilo,EndAsilo,OP,OM],Vars),
    
    min_max(labeling(Vars),Cost).


funzione_obiettivo(L,Cost):-
    costo_asilo(L,CostA),
    occurrences(4,L,CostBs),
    Cost #= CostA + CostBs*50.

costo_asilo([],0).
costo_asilo([3|_],100):-!.
costo_asilo([_|T],C):-
    costo_asilo(T,C).









consraint_asilo(_,[],_,_).
consraint_asilo(D,[H|T],StartAsilo,EndAsilo):-
    (D #< StartAsilo #\/ D #> EndAsilo) #<=> B,
    #\=(H,3,B),
    NextDay is D + 1,
    consraint_asilo(NextDay,T,StartAsilo,EndAsilo).

impose_constraint_parents(L):-
    findall(impegno(P,D),impegno(P,D),DataImpegni),
    constraint_parents(DataImpegni,L).

constraint_parents([],_).
constraint_parents([impegno(P,D)|ListI],L):-
    nth1(D,L,A),
    A #\= P,
    constraint_parents(ListI,L).