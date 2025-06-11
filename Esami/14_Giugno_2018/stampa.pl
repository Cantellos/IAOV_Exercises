:-lib(fd).
:-lib(fd_global).
:-[task].
:-lib(propia).
:-lib(cumulative).

stampante(Scheduling, Distanze):-
    findall([ID, EST, LCT, D], task(ID, EST, LCT, D), Task),
    add_start_time(Task, Scheduling),

    impose_EST(Scheduling),

    impose_LCT(Scheduling),

    liste_cumulative(Scheduling, Starts, Durate, Risorse),

    cumulative(Starts, Durate, Risorse, 1),

    calculate_distance(Scheduling, Dist),

    flatten(Dist, Distanze),

    minlist(Distanze, Min),

    C #= -Min,

    append(Starts, Distanze, L),
    min_max(labeling(L), C).

add_start_time([],[]).
add_start_time([L|R], [TaskST|Rs]):-
    ST :: 0..20,
    append(L, [ST], TaskST),
    add_start_time(R, Rs).

impose_EST([]).
impose_EST([[_,EST,_,_,ST]|R]):-
    ST #>= EST,
    impose_EST(R).

impose_LCT([]).
impose_LCT([[_,_,LCT,D,ST]|R]):-
    ST + D #<= LCT,
    impose_LCT(R).

liste_cumulative([], [], [], []).
liste_cumulative([[_, _, _, D, ST]|RTask], [ST|RST], [D|RD], [1|RR]):-
    liste_cumulative(RTask, RST, RD, RR).

calculate_distance([],[]).
calculate_distance([Task|RTask], [Dist|RDist]):-
    distance(Task, RTask, Dist) infers most,
    calculate_distance(RTask, RDist).

distance(_,[],[]).
distance([ID1, _, _, D1, ST1], [[_, _, _, _, ST2]|R], [Dist|Rd]):- 
    ST1 #< ST2, 
    Dist #= ST2 - ST1 - D1,
    distance([ID1, _, _, D1, ST1], R, Rd).
distance([ID1, _, _, D1, ST1], [[_, _, _, D2, ST2]|R], [Dist|Rd]):-
    ST1 #> ST2,
    Dist #= ST1 - ST2 - D2,
    distance([ID1, _, _, D1, ST1], R, Rd).