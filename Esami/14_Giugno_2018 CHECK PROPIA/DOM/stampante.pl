:- [task].
:- lib(fd).
:- lib(propia).
:- lib(cumulative).
:- lib(fd_global).

stampante(TaskList,Min):-
    read_data(TaskList),
    extract_list_cumulative(TaskList,ListS,ListD,ListR),
    cumulative(ListS,ListD,ListR,1),
    calculate_distance(TaskList,Distance),
    flatten(Distance,ListDistance),
    minlist(ListDistance,Min),
    C #= - Min,
    min_max(labeling(ListS),C).


calculate_distance([],[]).
calculate_distance([task(_,_,_,D,Start)|Ts],[C|Cs]):-
    distance(Start,D,Ts,C) infers most,
    calculate_distance(Ts,Cs).



distance(_,_,[],[]).
distance(StartI,DI,[task(_,_,_,_,Start)|Ts],[C|Cs]):-
    StartI #< Start, End #= StartI + DI, C #= Start - End,
    distance(StartI,DI,Ts,Cs).
distance(StartI,DI,[task(_,_,_,D,Start)|Ts],[C|Cs]):-
    StartI #> Start, End #= Start + D, C #= StartI - End,
    distance(StartI,DI,Ts,Cs).







extract_list_cumulative([],[],[],[]).
extract_list_cumulative([task(_,_,_,D,Start)|Ts],[Start|ListS],[D|ListD],[1|ListR]):-
    extract_list_cumulative(Ts,ListS,ListD,ListR).

read_data(TaskList):-
    findall(task(ID,EST,LCT,D),task(ID,EST,LCT,D),Data),
    make_task_variables(Data,TaskList).

make_task_variables([],[]).
make_task_variables([task(ID,EST,LCT,D)|Ds],[task(ID,EST,LCT,D,Start)|Ts]):-
    Start #>= EST,
    Start + D #<= LCT,
    make_task_variables(Ds,Ts).

