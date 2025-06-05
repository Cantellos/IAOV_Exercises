:-[task].
:-lib(fd).
:-lib(cumulative).
:-lib(fd_global).


stampa(Data, MinList):-
    variables(Tasks),
    generate_cumulative(Tasks, StartList, DurList, ResList),
    cumulative(StartList, DurList, ResList, 1),
    distance_list(Tasks, Tasks, MinList).


distance_list([],_,[]).
distance_list([task(ID,_,_,Dur,Start)|Ttask], Tasks, [Min|Tmin]):-
    distance(task(ID,_,_,Dur,Start), Tasks, MinList),
    minlist(MinList, Min),
    distance_list(Ttask, Tasks, Tmin).

distance(_,[],[]).
distance(task(ID1,_,_,Dur1,Start1), [task(ID2,_,_,Dur2,Start2)|Ttask], [Min|Tmin]):-
    (ID1 \= ID2
        -> !, End1 #= Start1 + Dur1, D #= End1 - Start2, Min #= abs(D)
    ),
    distance(task(ID1,_,_,Dur1,Start1), Ttask, Tmin).

variables(Tasks):-
    findall(task(ID,EST,LCT,DUR), task(ID,EST,LCT,DUR), Data),
    add_start(Data, Tasks).

add_start([], []).
add_start([task(ID,EST,LCT,DUR)|Told], [task(ID,EST,LCT,DUR,Start)|Tnew]):-
    Start #>= EST,
    Start + D #<= LCT,
    add_start(Told,Tnew).

generate_cumulative([],[],[],[]).
generate_cumulative([task(ID,EST,LCT,Dur,Start)|T],[Start|Tstart],[Dur|Tdur],[1|Tres]):-
    generate_cumulative(T,Tstart,Tdur,Tres).
